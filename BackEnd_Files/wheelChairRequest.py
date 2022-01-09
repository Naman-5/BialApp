import logging
from schema import Schema, And
import jwt
import json
import azure.functions as func
from azure.cosmos import  CosmosClient

def checkRequest(request):
    schema = Schema(
        {'token': And(str, len),
        'flightNo':And(str,len),
        'PNR':And(str,len),
        'pickup':And(str,len),
        })
    return schema.is_valid(request)

def createEntry(input):
    returnDoc = {}
    try:
        decode = jwt.decode(jwt=input['token'],
        key='decodeKey', #replace with your own
        algorithms="HS256"
        )
        returnDoc = input
        returnDoc.pop("token")
        returnDoc['id'] = "".join(decode['id'])
    except:
        logging.info("Decode error -> couldn't verify signature")
        returnDoc = -1
    return returnDoc


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('----------New Wheel Chair Request----------')
    item = req.get_json()

     # primary key for the cosmos DB (replace with your own key)
    __primaryKey = "cosmosPrimaryKey"

    # initializing the cosmost client and database
    client = CosmosClient("cosmosDBUrl",__primaryKey) #put your own
    
    # initalizing the database and the container
    __dataBaseName = "BIAL"
    db = client.create_database_if_not_exists(id=__dataBaseName)
    __containerName = "wheelchairRequests"
    container = db.get_container_client(__containerName)


    if checkRequest(item):
        logging.info('Schema Verified')
        try:
            document = createEntry(item)
            result = [i for i in container.query_items(
                query='SELECT * from c WHERE c.id = "'+document['id']+'"',
                enable_cross_partition_query=True)]
            if(len(result)==0):
                container.create_item(document)
            else:
                container.replace_item(result[0],document)
            return func.HttpResponse(json.dumps({'message':f'''
Current Wheel Chair Request
Id -> {document['id']},
Flight No. -> {document['flightNo']},
Pickup Location -> {document['pickup']}
            '''}))
        except :
            return func.HttpResponse(json.dumps({'message':'Unable to Process Request'}))
    else:
        logging.info('---------------schema error-------------------')
        return func.HttpResponse(
             "Incorrect Request SChema",
             status_code=200
        )
