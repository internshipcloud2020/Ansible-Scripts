list instances:

#!/usr/bin/env python
import boto3
ec2 = boto3.resource('ec2')
for instance in ec2.instances.all():
 print instance.id, instance.state

creating instance:

#!/usr/bin/env python
import boto3
ec2 = boto3.resource('ec2')
instance = ec2.create_instances(
 ImageId='ami-1e299d7e',
 MinCount=1,
 MaxCount=1,
 InstanceType='t2.micro')
print instance[0].id

terminate an instance:

#!/usr/bin/env python
import sys
import boto3
ec2 = boto3.resource('ec2')
for instance_id in sys.argv[1:]:
 instance = ec2.Instance(instance_id)
 response = instance.terminate()
 print response

creating the bucket:

#!/usr/bin/env python
import sys
import boto3
s3 = boto3.resource("s3")
for bucket_name in sys.argv[1:]:
 try:
 response = s3.create_bucket(Bucket=bucket_name)
 print response
 except Exception as error:
 print error

put a file in bucket:

#!/usr/bin/env python
import sys
import boto3
s3 = boto3.resource("s3")
bucket_name = sys.argv[1]
object_name = sys.argv[2]
try:
 response = s3.Object(bucket_name, object_name).put(Body=open(object_name, 'rb'))
 print response
except Exception as error:
 print error

delete bucket content:

#!/usr/bin/env python
import sys
import boto3
s3 = boto3.resource('s3')
for bucket_name in sys.argv[1:]:
 bucket = s3.Bucket(bucket_name)
 for key in bucket.objects.all():
 try:
 response = key.delete()
 print response
 except Exception as error:
 print error

delete a bucket:

#!/usr/bin/env python
import sys
import boto3
s3 = boto3.resource('s3')
for bucket_name in sys.argv[1:]:
 bucket = s3.Bucket(bucket_name)
try:
 response = bucket.delete()
 print response
except Exception as error:
 print error