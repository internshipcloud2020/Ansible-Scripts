    
##for creating an instancew using python boto3

#!/usr/bin/env python

import boto3

ec2 = boto3.resource('ec2')

instance = ec2.create_instances(

 ImageId='ami-1e299d7e',

 MinCount=1,

 MaxCount=1,

 InstanceType='t2.micro')

print instance[0].id

##for terminating the instance

#!/usr/bin/env python

import sys

import boto3

ec2 = boto3.resource('ec2')

for instance_id in sys.argv[1:]:

 instance = ec2.Instance(instance_id)

 response = instance.terminate()

 print respons
