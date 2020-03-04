import boto3
ec2 = boto3.resource('ec2')


outfile = open('ec2-keypair.pem','w')


key_pair = ec2.create_key_pair(KeyName='ec2-keypair')


KeyPairOut = str(key_pair.key_material)
print(KeyPairOut)
outfile.write(KeyPairOut)ec2 = boto3.resource('ec2')

instances = ec2.create_instances(
     ImageId='ami-00b6a8a2bd28daf19',
     MinCount=1,
     MaxCount=2,
     InstanceType='t2.micro',
     KeyName='ec2-keypair'
 )
s3 = boto3.resource('s3')
copy_source = {
    'Bucket': 'mybucket',
    'Key': 'mykey'
}
bucket = s3.Bucket('otherbucket')
bucket.copy(copy_source, 'otherkey')
response = bucket.create(
    ACL='private'|'public-read'|'public-read-write'|'authenticated-read',
    CreateBucketConfiguration={
        'LocationConstraint': 'EU'|'eu-west-1'|'us-west-1'|'us-west-2'|'ap-south-1'|'ap-southeast-1'|'ap-southeast-2'|'ap-northeast-1'|'sa-east-1'|'cn-north-1'|'eu-central-1'
    },
    GrantFullControl='string',
    GrantRead='string',
    GrantReadACP='string',
    GrantWrite='string',
    GrantWriteACP='string',
    ObjectLockEnabledForBucket=True|False
)
response = client.create_api_key(
    name='string',
    description='string',
    enabled=True|False,
    generateDistinctId=True|False,
    value='string',
    stageKeys=[
        {
            'restApiId': 'string',
            'stageName': 'string'
        },
    ],
    customerId='string',
    tags={
        'string': 'string'
    }
)