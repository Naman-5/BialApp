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


def checkRequest(request):
    schema = Schema({
        'token':And(str,len),
        'passport-no':And(str,len),
        'arrival-date':And(str,len),
        'flight-no':And(str,len),
        'coming-from':And(str,len),
        'no-baggage':And(str,len,lambda s: int(s)),
        'countries-visited':And(str,len),
        'value':And(str,len),
        'questions':[
            And(str,len, lambda s: s.lower() in ['no','yes'])
        ]
    })
    return schema.is_valid(request)

def createEntry(input):
    returnDoc = {}
    try:
        decode = jwt.decode(jwt=input['token'],
        key='decodeKey', #replace with your own,
        algorithms="HS256"
        )
        returnDoc['id'] = decode['id']
        returnDoc['Name of the Passenger'] = decode['name']
        returnDoc['Passport Number'] = input['passport-no']
        container = db.get_container_client('userCredential')
        nation = [i for i in container.query_items(
            query='SELECT c.nationality FROM c WHERE c.id ="'+decode['id']+'"',
            enable_cross_partition_query=True)]
        returnDoc['Nationality'] = nation[0]['nationality']
        returnDoc['Date of Arrival'] = input['arrival-date']
        returnDoc['Flight No.'] = input['flight-no']
        returnDoc['Number of baggages'] = input['no-baggage']
        returnDoc['Country from where coming'] = input['coming-from']
        returnDoc['Countries visited in last six days'] = input['countries-visited']
        returnDoc['Total value of dutiable goods being imported (Rs.)'] = input['value']
        returnDoc['Are you bringing the following items into India?'] = {
            'Prohibited Articles': input['questions'][0],
            'Gold jewellery (over Free Allowance) ':input['questions'][1],
            'Gold Bullion':input['questions'][2],
            'Meat and meat products/dairy products/fish/poultry products':input['questions'][3],
            'Seeds/plants/seeds/fruits/flowers/other planting material':input['questions'][4],
            'Satellite phone':input['questions'][5],
            'Indian currency exceeding Rs. 10,000/- ':input['questions'][6],
            'Foreign currency notes exceed US $ 5,000 or equivalent':input['questions'][7],
            'Aggregate value of foreign exchange including currency exceeds US $ 10,000 or equivalent.':input['questions'][8]
        }
    except:
        logging.info("decoding JWT failed")
    return returnDoc


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Customs form filling function')
    item = req.get_json()

    if checkRequest(item):
        try:
            customsEntry = createEntry(item)
            print(customsEntry)
            container = db.get_container_client('customs')
            try:
                container.create_item(customsEntry)
            except:
                return func.HttpResponse(json.dumps({'message':'Form Already filled'}))
            return func.HttpResponse(json.dumps({'message':'Form Filled'}))
        except ValueError:
            return func.HttpResponse(json.dumps({'message':'unable to process request'}))
    else:
        return func.HttpResponse(json.dumps({'message':'schema error'}))
