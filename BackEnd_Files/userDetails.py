import logging
import jwt
import json
from schema import Schema, And
import azure.functions as func
from azure.cosmos import  CosmosClient

# primary key for the cosmos DB (replace with your own)
__primaryKey = "cosmosPrimaryKey"

# initializing the cosmost client and database
client = CosmosClient("cosmosDBUrl",__primaryKey) #put your own url

# initalizing the database and the container
__dataBaseName = "BIAL"
db = client.create_database_if_not_exists(id=__dataBaseName)

def checkRequest(request):
    schema = Schema({
        'token':And(str,len)
    })
    return schema.is_valid(request)

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('------------------user details request-----------------')

    item = req.get_json()

    if checkRequest(item):
        try:
            decode = jwt.decode(jwt=item['token'],
            key='decodeKey', #replace with your own decode key
            algorithms="HS256"
            )
            container = db.get_container_client('rewards')
            results = [i for i in container.query_items(
                query = 'SELECT c.rewards FROM c WHERE c.id = "'+decode['id']+'"',
                enable_cross_partition_query=True
            )]
            decode['rewards'] = results[0]['rewards']
            return func.HttpResponse(json.dumps({'message':decode}))
        except ValueError:
            return func.HttpResponse(json.dumps({'message':'invalid token'}))
    else:
        return func.HttpResponse(json.dumps({'message':'schema error'}))
