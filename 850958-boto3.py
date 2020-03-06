# print all the instance-id and instance-state using boto3

import boto3
ec2 = boto3.resource('ec2')
for instance in ec2.instances.all():
    print (instance.id , instance.state)

# for all regions
for region in `aws ec2 describe-regions --output text | cut -f3`
do
     echo -e "\nInstances status in region: '$region'"
     aws ec2 describe-instance-status --include-all-instances
done
