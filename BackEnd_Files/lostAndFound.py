import logging
import json
import azure.functions as func
import azure.cosmos.cosmos_client as cosmosClient
import azure.cosmos.exceptions as excep


# primary key for the cosmos DB (replace with your own)
__primaryKey = "cosmosPrimaryKey"
# database name
databaseName = "BIAL"

def convertToInt(d):
    d = d.split('-')
    d = ''.join(map(str,d))
    return int(d)

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Fetching Lost and Found data')

    item = req.get_json()
    #intializing cosmos client
    client = cosmosClient.CosmosClient("cosmosDBUrl",__primaryKey) #put your own url

    name = req.params.get('name')
    if item['info']=='lost&found':
        try:
            startDate = convertToInt(item['start'])
            endDate = convertToInt(item['end'])
            db = client.get_database_client(databaseName)
            container = db.get_container_client("foundItems")
            result = [item for item in container.query_items(
                query= "SELECT c.id, c.date, c.item, c.location, c.description from c WHERE c.dateComparison<= "+str(endDate)+" AND c.dateComparison >= "+str(startDate) ,
                enable_cross_partition_query=True
                )]
            return func.HttpResponse(json.dumps(result))
        except ValueError:
            return func.HttpResponse("Internal Server Error",status_code=500)
