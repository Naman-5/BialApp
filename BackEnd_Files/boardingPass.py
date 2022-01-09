import logging
from schema import Schema, And
import jwt
import json
import azure.functions as func
from azure.cosmos import  CosmosClient

# primary key for the cosmos DB (replace with your own)
__primaryKey = "cosmosPrimaryKey"

# initializing the cosmost client and database
client = CosmosClient("cosmosDBUrl",__primaryKey) #put your own
    
# initalizing the database and the container
__dataBaseName = "BIAL"
db = client.create_database_if_not_exists(id=__dataBaseName)
__containerName = "flights"
container = db.get_container_client(__containerName)

errorPass = {'name':'NA','seat':'NA','class':'NA'}

def checkRequest(request):
    schema = Schema(
        {'token': And(str, len),
        'flightNo':And(str,len),
        'PNR':And(str,len),
        })
    return schema.is_valid(request)

def createPass(input):
    boardingPass = {}
    try:
        decode = jwt.decode(jwt=input['token'],
        key='decodeKey',  ## replace with your own
        algorithms='HS256'
        )
        results = [i for i in container.query_items(
            query='SELECT c.passengers from c WHERE c.id = "'+input['flightNo']+'"',
            enable_cross_partition_query=True)]
        boardingPass = results[0]['passengers'][input['PNR']]
        if boardingPass['email'] == decode['id']:
            boardingPass.pop('email')
        else:
            boardingPass = errorPass
    except:
        boardingPass = errorPass
    return boardingPass

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('---------------boarding pass generation request------------')
    item = req.get_json()
    if checkRequest(item):
        try:
            boarding = createPass(item)
            return func.HttpResponse(json.dumps({'message':boarding}))
        except ValueError:
            logging.info('failed to find the passenger')
            return func.HttpResponse(json.dumps({'message':errorPass}))
    else:
        logging.info('schema error')
        return func.HttpResponse(json.dumps({'message':'schema error'}))
