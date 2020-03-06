import json
import boto3

s3 = boto3.client('s3')
 
def lambda_handler(event, context):
     
       bucket = 'sample_bucket'
       key = 'content/file1.json'

       try:
           data = s3.get_object(Bucket=bucket, Key=key)
           output = data['Body'].read()

           return output
 
       except Exception as e:
           print(e)
           raise e
    