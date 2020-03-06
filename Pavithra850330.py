
#create an IAM user and update ,delete the user 

import boto3

iam=boto3.client('iam')
response=iam.create_user(username="user123")
print response


response=iam.update_user(username="user123",newusername="ABC")
print response

iam.delete_user(newusername="ABC") 

#create an ec2 instance

ec2 = boto3.resource('ec2')
instance = ec2.create_instances(
    ImageId = 'ami-009d6802948d06e52',
    MinCount = 1,
    MaxCount = 1,
    InstanceType = 't2.micro',
    KeyName = 'newkeypair123',
    SubnetId = 'subnet-0yhg678990d56c277')
print (instance[0].id)