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
    'password':And(str,len),
    })
    return schema.is_valid(request)

def createJWT(name, email):
    payload_data= {
        'role':'user',
    }
    payload_data['name'] = name
    payload_data['id'] = email
    return jwt.encode(payload_data,key='decodeKey') #replace your own key   


def main(req: func.HttpRequest) -> func.HttpResponse:
    item = req.get_json()
    print(item)
    logging.info(f"Signing in -> {item['id']}")

     # primary key for the cosmos DB (replace with your own)
    __primaryKey = "cosmosPrimaryKey"

    # initializing the cosmost client and database
    client = CosmosClient("cosmosDBUrl",__primaryKey) #put your own url
    if checkRequest(item):
        try:
            output = {}
            item['password'] = hashPassword(item['password'])
            db = client.get_database_client('BIAL')
            container = db.get_container_client('userCredential')
            result = [i for i in container.query_items(
                query="SELECT c.fullName from c WHERE c.id = \""+item['id']+"\" AND c.password = \""+item['password']+"\"",
                enable_cross_partition_query=True)]
            if(len(result)==1):
                output['token'] = createJWT(result[0]['fullName'],item['id'])
                return func.HttpResponse(json.dumps(output))
            return func.HttpResponse("Invalid Details")
        except :
            return func.HttpResponse('failed to sign in')
    else:
        return func.HttpResponse("Schema Error")
