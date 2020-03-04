pip install awscli boto3 -U --ignore-installed six
AWS Access Key ID [None]: AKIAJFUD42GXIN4SQRKA
AWS Secret Access Key [None]: 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
Default region name [None]: us-west-2
Default output format [None]: text

#list ec2 instances

import boto3
ec2 = boto3.resource('ec2')
for instance in ec2.instances.all():
 print instance.id, instance.state

#create instance
import boto3
ec2 = boto3.resource('ec2')
instance = ec2.create_instances(
 ImageId='ami-1e299d7e',
 MinCount=1,
 MaxCount=1,
 InstanceType='t2.micro')
print instance[0].id

#terminate instance

#!/usr/bin/env python
import sys
import boto3
ec2 = boto3.resource('ec2')
for instance_id in sys.argv[1:]:
 instance = ec2.Instance(instance_id)
 response = instance.terminate()
 print response