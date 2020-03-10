import boto3
ec2 = boto3.resource('ec2')
instance = ec2.create_instances(
    ImageId = 'ami-009d6802948d06e52',
    MinCount = 1,
    MaxCount = 1,
    InstanceType = 't2.micro',
    KeyName = 'Bharathi vl ',
    SubnetId = 'subnet-0yhg678990d56c277')
print (instance[0].id)