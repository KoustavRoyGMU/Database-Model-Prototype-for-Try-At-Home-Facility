# Database-Model-Prototype-for-Try-At-Home-Facility
I'm designing an RDBMS system for a retail chain trying to implement a Try at Home facility. My focus is 
to make sure that the Data is not redundant, All the constraints are followed properly to avoid garbage 
data, to reduce the data latency.

Assumptions:
• We have the Master Data available in the system (In this case I have created the Customer Data Manually, Item Stock Data by analyzing the VS website)

• Customer will not be charged any shipment fees

• All the products in the inventory are eligible to try at home.


Requirements: 
• Customer can order up to 3 products at a time 

• Tax Should be calculated as per the state residence of the customer

• When a customer places an order we should retrieve detailed Customer Information, Billing Information and Payment Information simultaneously

• Customer can return all the products or keep all, but they must return within 30 days

• While Processing the Return request, The Billing Information and Source Payment Information must be retrieved

• The price change of the product should not reflect in the return amount


Future Improvements:

1. We can add Promotional offers for products

2. We can update the stock automatically with order place and return


