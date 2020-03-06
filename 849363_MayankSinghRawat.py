import sys
import boto3

//creating a new instance
ec2 = boto3.resource('ec2', region_name="ap-southeast-2")
instance = ec2.create_instances(
    ImageId='ami-1e299d7e',
    InstanceType='t2.micro')

//listing all the instances created
for instance in ec2.instances.all():
    print(instance.id, instance.state)

//to terminate all the created resources
for instance_id in sys.argv[1:]:
    instance = ec2.Instance(instance_id)
    response = instance.terminate()
    print(response)
