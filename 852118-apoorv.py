import boto3
import awsutils
import pprint
def get_session(region):
    return boto3.session.Session(region_name=region)
session = awsutils.get_session('us-east-1')
client = session.client('ec2')
pprint.pprint(client.describe_instances())