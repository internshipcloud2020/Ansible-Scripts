
#This script creates snapshots of all such volumes that has the tag Environment:Prod


from boto3 import Session
from botocore.exceptions import ClientError

sess = Session(aws_access_key_id=ARN_ACCESS_KEY,aws_secret_access_key=ARN_SECRET_KEY,region_name="us-east-1")
ec2_client = sess.client("ec2",region_name="us-east-1")
try:
	ec2_volumes = ec2_client.describe_volumes(Filters = [{ 'Name' : "tag-key",'Values' : ["Environment"]},{'Name' : "tag_value", 'Values' : ['Prod']}])
	for volume in ec2_volumes.get('Volumes',[]):
		volume_id = volume.get('VolumeId')
		try:
			snapshot = ec2_client.create_snapshot(VolumeId = volume_id, Description = "Created by script")
			print(snapshot['SnapshotId'])
		except clientError as e:
			print("error in snapshot",e)
except clientError as e:
	print("error in volume describe",e)