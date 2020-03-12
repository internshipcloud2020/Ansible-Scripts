# Python boto3 script for printing all the names of buckets in s3 and total number of buckets


import boto3
s3 = boto3.resorces("s3")
# variable to count number of buckets
j=0
print("Bucket name\n")
for i in s3.buckets.all():
	print(i.name+"\n")
	j += 1
# Printing total number of buckets
print("Total number of buckets = " + j)
