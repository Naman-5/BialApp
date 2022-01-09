import logging
import json
import azure.functions as func
import azure.cosmos.cosmos_client as cosmosClient
import azure.cosmos.exceptions as excep

# primary key for the cosmos DB (replace with your own)
__primaryKey = "cosmosPrimaryKey"
# database name
databaseName = "BIAL"
containerName = "airlineContact"


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Began getAirline() or getFlight() function')
    item = req.get_json()

    #intializing cosmos client
    client = cosmosClient.CosmosClient("cosmosDBUrl",__primaryKey) #put your own

    flow = item['info']
    if flow == 'airlines':
        try:
            db = client.get_database_client(databaseName)
            container = db.get_container_client(containerName)
            airlines = list(container.read_all_items())
            result = []
            for i in airlines:
                ele = {}
                print(i)
                ele['Title']=i['id']
                ele['LogoPath'] = i['image']
                ele['Website'] = i['website']
                result.append(ele)
            return func.HttpResponse(json.dumps(result))
        except excep.CosmosResourceNotFoundError:
            return func.HttpResponse('Internal Server error!')

    elif flow == 'flights':
        try:
            db = client.get_database_client(databaseName)
            container = db.get_container_client("flights")
            result = [item for item in container.query_items(
                query="SELECT c.id, c.carrier, c.status, c.start, c.to, c.scheduled, c.estimated from c",
                enable_cross_partition_query=True
                )]
            return func.HttpResponse(json.dumps(result))
        except:
            return func.HttpResponse("Internal Server Error",status_code=500)
    else:
        return func.HttpResponse(
             "Something is not right",
             status_code=200
        )
