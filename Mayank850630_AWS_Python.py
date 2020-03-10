#List buckets and their contents
#!/usr/bin/env python
import boto3
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
 print bucket.name
 print "---"
 for item in bucket.objects.all():
 print "\t%s" % item.key
 
 #Create a bucket
 
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
 
 $ ./create_bucket.py projectx-bucket1-$(date +%F-%s)
s3.Bucket(name='projectx-bucket1-2017-01-01-1483305884')

$ ./list_buckets.py
projectx-bucket1-2017-01-01-1483305884
