import logging
from schema import Schema, And, Use, Optional, SchemaError
import jwt
import json
from Crypto.Hash import SHA256
import azure.functions as func
from azure.cosmos import  CosmosClient, PartitionKey

def hashPassword(password):
    key = SHA256.new(password.encode('utf-8')).hexdigest()
    return key

def checkRequest(request):
    schema = Schema(
    {'id': And(str, len,lambda s: '@' in s),
    'fullName':And(str,len),
    'DOB':And(str,len),
    'gender': And(str, Use(str.lower),lambda s: s in ('male', 'female','others')),
    'nationality':And(str, len),
    'code':And(str,len,lambda s: int(s)>0),
    'mobileNumber':And(str,len, lambda s: 4<len(s)<12, lambda s: int(s)>0),
    'password':And(str,len),
    'method': And(str, len, lambda s: s in ('in-app'))
    })
    return schema.is_valid(request)

def createJWT(name, email):
    payload_data= {
        'role':'user',
    }
    payload_data['name'] = name
    payload_data['id'] = email
    return jwt.encode(payload_data,key='this key will be needed to decode the JWT') #replace with your own


def main(req: func.HttpRequest) -> func.HttpResponse:
    item = req.get_json()
    logging.info(f"New User creation. Using -> {item['method']}")
    

    # primary key for the cosmos DB (replace with your own)
    __primaryKey = "cosmosPrimaryKey"

    # initializing the cosmost client and database 
    client = CosmosClient("cosmosDBUrl",__primaryKey) # put your own url
    __dataBaseName = "BIAL"
    db = client.create_database_if_not_exists(id=__dataBaseName)
    __containerName = "userCredential"
    container = db.create_container_if_not_exists(
        id=__containerName,
        partition_key = PartitionKey(path="/id"),
    )

    if checkRequest(item):
        try:
            item['password'] = hashPassword(item['password'])
            container.create_item(item)
            output = {'token':createJWT(
                item['fullName'],
                item['id']
            )}
            logging.info('------------------created new user------------------')
            return func.HttpResponse(json.dumps(output))
        except:
            logging.info('----------------------user already exists -----------------')
            return func.HttpResponse('User Already exisits')
    else :
        logging.info('-----------------------invalid schema operation--------------------')
        return func.HttpRequest('Invalid Schema request')
