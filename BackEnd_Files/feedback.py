import logging
from schema import Schema, And, Use, Optional, SchemaError
import jwt
import json
import azure.functions as func
from azure.cosmos import  CosmosClient, PartitionKey
import datetime

def checkRequest(request):
    schema = Schema(
        {'token': And(str, len),
        'appExperience':And(str,len),
        'securityScreening':And(str,len),
        'processes':And(str,len),
        'cleanliness':And(str,len),
        'comments':And(str,len)
        })
    return schema.is_valid(request)

def createEntry(entry):
    returnDoc = {}
    try:
        decode = jwt.decode(jwt=entry['token'],
        key='decodeKey', #replace with your own,
        algorithms="HS256"
        )
        logging.info(f"{decode}")
        returnDoc['id'] = "".join(decode['id'])
        returnDoc['id'] += "->"+str(datetime.datetime.now())
        returnDoc['appExperience'] = entry['appExperience']
        returnDoc['securityScreening'] = entry['securityScreening']
        returnDoc['processes'] = entry['processes']
        returnDoc['cleanliness'] = entry['cleanliness']
        returnDoc['comments'] = entry['comments']
    except:
        logging.info("Decode error -> couldn't verify signature")
        returnDoc = -1
    return returnDoc


def main(req: func.HttpRequest) -> func.HttpResponse:
    item = req.get_json()
    logging.info("---------------------------adding feedback-------------------------------")

    # primary key for the cosmos DB
    __primaryKey = "cosmosPrimaryKey" #replace with your own

    # initializing the cosmost client and database
    client = CosmosClient("cosmosDBUrl",__primaryKey) # put your own url
    
    __dataBaseName = "BIAL"
    db = client.create_database_if_not_exists(id=__dataBaseName)
    __containerName = "feedback"
    container = db.create_container_if_not_exists(
        id=__containerName,
        partition_key = PartitionKey(path="/id"))

    if checkRequest(item):
        logging.info("schema verified")
        try:
            document = createEntry(item)
            logging.info(f'{document}')
            container.create_item(document)
            return func.HttpResponse(json.dumps({'status':'OK'}))
        except :
            logging.info("error in creating a new feedback item")
            return func.HttpResponse(json.dumps({'status':'error'}))
    else:
        return func.HttpResponse(json.dump({'status':'schema error'}))
