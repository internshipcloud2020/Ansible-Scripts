import boto3
#to create a table in DynamoDB
table = dynamodb.create_table(
        TableName='mytable',
        KeySchema=[ 
            {
                'AttributeName': 'Firstname',
                'KeyType': 'HASH',
		'AttributeType': 'S'
            },
            {
                'AttributeName': 'Lastname',
                'KeyType': 'RANGE',
		'AttributeType': 'S'
            }
        ],
 	ProvisionedThroughput={
             'ReadCapacityUnits': 1,
             'WriteCapacityUnits': 1
         }
)
#to insert into table
table = dynamodb.Table('mytable') 
    response = table.put_item(
        Item = {
               'Firstname': 'vamsip',
               'Lastname': 'password'
               } 
        )



#to delete elements inthe database
   table = dynamodb.Table('mytable')
    #with delete_item function we delete the data from table
    response = table.delete_item(
        Item = {
               'Firstname': 'vamsipulikonda'
               
               }
        )
