# BIAL Hackathon (Prototype Phase)
![Hackathon Banner](Documentation/hackathon_banner.png)

# Project Title: BIAL-Concierge

> Team: #3stack
>
> Team Members:
> - Naman Mayer
> - Nischith B
> - Pulavarthy Harshik
>

# Tech-Stack

<p align="center">
<img src="Documentation/azure.png" width="170"> 
<img src="Documentation/cosmosDB.png" width="330"> 
<img src="Documentation/azureFunction.png" width="170">
</p>

> Azure Services Used:
>
> 1. Azure CosmosDB
> 1. Azure Functions
> 1. Azure Storage Account
>

<p align="center">
<img src="Documentation/flutter.png" width="220">
<img src="Documentation/dart.png" width="225"> 
<img src="Documentation/python.png" width="220">
</p>

> Frameworks & Programming Languages Used:
> 
> 1. Flutter & Dart -> User-Interface
> 1. Python -> Azure Functions backend

# User-Interface
Home Screen             | Flights
:-------------------------:|:-------------------------:
![Home Page](Documentation/HomeScreen.png)  |  ![Flights Page](Documentation/flightsPage.png)

Sign-In Screen             | Sign-up
:-------------------------:|:-------------------------:
![Sign-in Screen](Documentation/sign-in.png)  |  ![Sign-up Screen](Documentation/sign-up.png)

## Chat Bot
<p align="center">
<img src="Documentation/chatBot.png" width="400" >
</p>
<p>
Passengers can have various types of questions; some questions need to be answered by an actual human being, but a lot of the queries can be handled by a bot reducing staffing needs of the airport. Also, a bot can be available 24x7</p>

> Chat Bot Commands:
> - Flight Status \<Flight-No> -> Returns the status of the flight
> - Help -> Returns the contact details for medical emergency
> - Tell me something new -> Tells interesting facts about the airport
>

## Customs Declaration
<p align="center">
<img src="Documentation/customs.png" width="270" > <img src="Documentation/customs2.png" width="270" >
</p>
<p>
At the end of each international flight the flight crew hands over the customs declaration form to the passengers. Wouldn’t it be convenient if passengers could fill the form using the airport mobile application? It can speed-up the immigration process and make keeping digital records easier.</p>

## In app service requests for Special Assistance to passengers
<p align="center">
<img src="Documentation/assistance.png" width="270" > <img src="Documentation/bookWheelChair.png" width="270" >
<p>
Passengers needing special assistance can request the airport staff using the mobile application, making it convenient for the passengers and airport staff at the same time.</p>

## Airline Contact resources
<p align="center">
<img src="Documentation/airlineContact.png" width="400" >
</p>
<p>Certain passenger queries require the airline staff and finding the contact resources for the respective airport on the web is not very convenient and therefore a contact resource in the airport application could save valuable time.</p>

## In App-store and Airport rewards
<p align="center">
<img src="Documentation/store.png" width="270" > <img src="Documentation/rewards.png" width="270" >
<p>
<p align="center">
<img src="Documentation/productDetail.png" width="270" > <img src="Documentation/cart.png" width="270" >
<p>
<p>Stores at the airport can choose to have their products added to the in-app store of the application allowing customers to buy the products within the application and then picking up the products from the store itself or getting it delivered somewhere within the airport.</p>

## Feedback / complaint section
<p align="center">
<img src="Documentation/feedback.png" width="400" >
</p>
<p>To continuously keep improving the passenger experience, passenger feedbacks are essential. Also, any passenger complaints could be registered using the mobile application making the procedure convenient for passenger and staff.</p>

##  Lost and Found section
<p align="center">
<img src="Documentation/lostAndFound.png" width="270" > <img src="Documentation/lostItem.png" width="270" ></p>
<p>
With such large number of passengers visiting the airport everyday there would be many lost or missing items. Therefore, to make the process of reporting and claiming lost items easier we want to have a lost and found section in the application.</p>

## Boarding Pass generation
<p align="center">
<img src="Documentation/profilePage.png" width="270" > <img src="Documentation/boardingPass.png" width="270" ></p>
<p>
There are always huge queues in front of check in desks at the airport. Despite having machines to allow passengers to self-check-in a lot of the passengers are not very comfortable using them. Having the option to generate an e-boarding pass within the application would make the check-in process convenient.
</p>

# Now Lets Talk about the Server-Side

<p>
<ul>
<li>All our Backend logic is handled by Azure Functions and the language of our choice is Python</li>
<li>Having a serverless architecture for the prototype meant that we didn't have to manage any servers and using an event-based system would reduce the overall cost.</li>
<li>We used CosmosDB as our database of choice. Its a NoSQL database but accepts SQL like queries. </li>
<li>We used Azure storage account containers to store some of our image resources.</li>
<li>We use JWTs (JSON Web Tokens) on the backend to verify that the requests come from a genuine user and only then perform any further computation</li>
<li>The tokens are generated by the backend system on a successful sign-up or sign-in event and is safely stored on device using flutter_secure_storage plugin</li>
<li>The passwords of users are not stored as plaint text but are hashed using SHA256 algorithm before storing them in cosmosDB</li>
</ul>
</p>