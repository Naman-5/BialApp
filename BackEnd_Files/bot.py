import logging
import json
import random
import azure.functions as func
import azure.cosmos.cosmos_client as cosmosClient
import azure.cosmos.exceptions as excep

# primary key for the cosmos DB (replace with your own)
__primaryKey = "cosmosPrimaryKey"
# database name
databaseName = "BIAL"


commands = ['flightstatus','help','tellmesomethingnew','highlights']

def commandSelection(input):
    returnCode = {}
    input = input.split(" ")
    logging.info(input)
    values = input
    input = ''.join(map(str,input))
    input = input.lower()
    for i in range(len(commands)):
        if commands[i] in input and (i==0 or i==4):
            returnCode['code'] = i
            returnCode['value'] = values[len(values)-1]
            logging.info(f"value -> {returnCode}")
        elif commands[i] in input:
            returnCode['code'] = i
    return returnCode


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('-----------------bot request----------------------')
    item = req.get_json()

    execute = commandSelection(item['command'])
    client = cosmosClient.CosmosClient("cosmosDBUrl",__primaryKey) #put your own url
    try:
        if execute['code'] == 0:
            try:
                db = client.get_database_client(databaseName)
                container = db.get_container_client("flights")
                result = [item for item in container.query_items(
                    query= '''SELECT c.status from c  WHERE c.id = "'''+execute['value']+'"' ,
                    enable_cross_partition_query=True)]
                return func.HttpResponse(json.dumps({'message':result[0]}))
            except:
                return func.HttpResponse(json.dumps({'message':"couldn't find flight"}))
        elif execute['code'] == 1:
            return func.HttpResponse(json.dumps({'message':'''Duty Medical Officer (Medical Centre) - 9739733335\nDuty Medical Officer (Aster PTB clinic - 9148790154 )'''}))
        elif execute['code'] == 2:
            factNumber = random.randint(0,5)
            facts = [
                "Bangalore's main airport till 2008 was the Hindustan Aeronautics Limited(HAL) airport, which was built in 1942.",
                '''Bangalore Airport was given the honour of the “Best Airport in India” at the Skytrax 'World Airport Awards' in 2011''',
                '''The HAL airport was used by the British Royal Navy to protect India from Japan during World War II.''',
                '''Bangalore airport was the first airport in India to be developed under a “Public-Private Partnership”.''',
                '''It is the busiest airport in South India and the 3rd busiest airport in India, serving more than 20 million passengers annually.''',
                '''Bangalore Airport will be the first airport in India to use a humanoid robot called ‘Kempa’, to assist passengers travelling to the airport.'''
                ]
            return func.HttpResponse(json.dumps({'message':facts[factNumber]}))
        elif execute['code'] == 3:
            return func.HttpResponse(json.dumps({'message':'API not ready'}))
    except:
        return func.HttpResponse(json.dumps({'message':'Kindly enter a valid command'}))
