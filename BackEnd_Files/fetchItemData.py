import logging
from typing import Container
import json
import azure.functions as func
import azure.cosmos.cosmos_client as cosclie

# replace with your own
primarykey = "cosmosPrimary key"


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Getting the store details...')

    data=req.get_json()
    client=cosclie.CosmosClient("cosmosDBUrl", primarykey) ## put your own url
    db=client.get_database_client("BIAL")
    container=db.get_container_client("retail")
    print(data)

    flow=data["info"]
    if flow=="shops":
        try:
            result=[item for item in container.query_items(
            query="SELECT * FROM C",
            enable_cross_partition_query= True
            )]
            return func.HttpResponse(json.dumps(result))
        except:
            return func.HttpResponse("Request Failed")
