import logging
from schema import Schema, And
import jwt
import json
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
        'token':And(str,len),
        'products':Schema([{
            'store': And(str,len),
            'item':And(str,len)
        }]),
        'redeem':And(str,len, lambda s: s in ['0','1'])
    })
    return schema.is_valid(request)

def findPrice(store,itemNumber):
    container = db.get_container_client('retail')
    result = [i['itemDetails'][itemNumber]['price'] for i in container.query_items(
        query='SELECT c.itemDetails from c WHERE c.id = "'+store+'"',
        enable_cross_partition_query=True)]
    return int(result[0])

def createEntry(input):
    billing = {}
    totalBill = 0
    try:
        decode = jwt.decode(jwt=input['token'],
        key='decodeKey', #replace with your own,
        algorithms="HS256"
        )
        billing['id'] = decode['id']
        for i in input['products']:
            totalBill += findPrice(i['store'],i['item'])
        billing['bill'] = totalBill
        billing['rewards'] = totalBill//10
        print(billing)
    except:
        logging.info("Decode error -> couldn't verify signature")
    return billing

def rewards(details,r):
    rewards = 0
    bill = 0
    container = db.get_container_client('rewards')
    result = [i for i in container.query_items(
        query='SELECT * from c WHERE c.id = "'+details['id']+'"',
        enable_cross_partition_query=True)]
    bill = details['bill']
    details.pop('bill')
    if len(result)==0 :
        if details['rewards']<0:
            details['rewards'] *= -1
        rewards += details['rewards']
        container.create_item(details)
    else:
        if r=='0':
            rewards = details['rewards'] + result[0]['rewards']
            if rewards <0:
                rewards *= -1
            details['rewards'] = rewards
            container.replace_item(result[0],details)
        else:
            bill -= result[0]['rewards']
            details['rewards'] = bill//10
            if details['rewards'] <0:
                details['rewards'] *= -1
            rewards = bill//10
            container.replace_item(result[0],details)
    return bill, rewards

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('--------item - checkout page-----------')
    item = req.get_json()

    if checkRequest(item):
        try:
            summary = createEntry(item)
            totalBill, totalRewards = rewards(summary,item['redeem'])
            return func.HttpResponse(json.dumps({'message':{'bill':totalBill,'rewards':totalRewards,'products':item['products']}}))
        except ValueError:
            pass
    else:
        return func.HttpResponse(json.dumps({'message':'schema error'}))
