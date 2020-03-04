import boto3
import sys
ec2 = boto3.resource('ec2')
for instance in ec2.instances.all():
 print instance.id, instance.state
#choose an amazon machine image 
instance = ec2.create_instances(
 ImageId='ami-1e299d7e',
 MinCount=1,
 MaxCount=1,
 InstanceType='t2.micro')
print instance[0].id 
#to terminate an instance
for instance_id in sys.argv[1:]:
 instance = ec2.Instance(instance_id)
 response = instance.terminate()
 print response
#list s3 buckets and their contents
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
 print bucket.name
 print "---"
 for item in bucket.objects.all():
 print "\t%s" % item.key
# creating a bucket
s3 = boto3.resource("s3")
for bucket_name in sys.argv[1:]:
 try:
 response = s3.create_bucket(Bucket=bucket_name)
 print response
 except Exception as error:
 print error
#put a file into a bucket
bucket_name = sys.argv[1]
object_name = sys.argv[2]
try:
 response = s3.Object(bucket_name, object_name).put(Body=open(object_name, 'rb'))
 print response
except Exception as error:
 print error 
#to delete a bucket
s3 = boto3.resource('s3')
for bucket_name in sys.argv[1:]:
 bucket = s3.Bucket(bucket_name)
try:
 response = bucket.delete()
 print response
except Exception as error:
 print error
#create a db instance
rds = boto3.client('rds')
try:
 response = rds.create_db_instance(
 DBInstanceIdentifier='dbserver',
 MasterUsername='dbadmin',
 MasterUserPassword='abcdefg123456789',
 DBInstanceClass='db.t2.micro',
 Engine='mariadb',
 AllocatedStorage=5)
 print response
except Exception as error:
 print error
#delete a db instance
db = sys.argv[1]
rds = boto3.client('rds')
try:
 response = rds.delete_db_instance(
 DBInstanceIdentifier=db,
 SkipFinalSnapshot=True)
 print response
except Exception as error:
 print error   