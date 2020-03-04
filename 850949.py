
#Using boto3 for creating an ec2 instance with the keypair

#install both awscli and boto3

#create Keypair for the ec2 instance
import boto3
ec2=boto3.resource('ec2)

#Store key-alue pair
outfile = open('ec2-keypair.pem','w')

#create keypair
key-pair=ec2.create_key_pair(KeyName='ec2-keypair)
keypairout=str(key_pair.key_material)
print(keypairout)
outfile.write(keypairout)



#create ec2 instance

import boto3
ec2=boto3.resource('ec2')

instances=ec2.create_instances(
    ImageId='yourImageID'
    InstanceType='t2-micro'
    KeyName='ec2-keypair'
)