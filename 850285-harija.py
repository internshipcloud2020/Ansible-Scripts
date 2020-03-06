import boto3
#Creating 3c2
ec2 = boto3.resource('ec2')
instance = ec2.create_instances(
 ImageId='ami-1e299d7e',
 MinCount=1,
 MaxCount=1,
 InstanceType='t2.micro')
print instance[0].id
#creating s3 bucket 
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
 print bucket.name
 print "---"
 for item in bucket.objects.all():
 print "\t%s" % item.key

#listing all db instances
 rds = boto3.client('rds')
try:
# get all of the db instances
 dbs = rds.describe_db_instances()
for db in dbs['DBInstances']:
 print ("%s@%s:%s %s") % (
 db['MasterUsername'],
 db['Endpoint']['Address'],
 db['Endpoint']['Port'],
 db['DBInstanceStatus'])


