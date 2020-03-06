import boto3
import awsutils
import pprint

def get_session(region):
    return boto3.session.Session(region_name=region)

    session = awsutils.get_session('us-east-1')
    client = session.client('ec2')

    pprint.pprint(client.describe_instances())

    demo = client.describe_instances(Filters=[{'Name': 'tag:Name', 'Values': ['demo-instance']}])
    pprint.pprint(demo)

instance_id = demo['Reservations'][0]['Instances'][0]['InstanceId']
    instance_id 'i-0c462c48bc396bdbb'
 pprint.pprint(client.stop_instances(InstanceIds=[instance_id]))
{
    'ResponseMetadata': 
        {
            'HTTPHeaders': 
                {   
                    'content-length': '579',
                    'content-type': 'text/xml;charset=UTF-8',
                    'date': 'Sat, 22 Dec 2018 19:26:30 GMT',
                    'server': 'AmazonEC2'},
                    'HTTPStatusCode': 200,
                    'RequestId': 'e04a4a64-74e4-442f-8293-261f2ca9433d',
                    'RetryAttempts': 0
                },
    'StoppingInstances':
        [{
            'CurrentState': 
                {
                    'Code': 64, 'Name': 'stopping'
                },
                    'InstanceId': 'i-0c462c48bc396bdbb',
                    'PreviousState': {'Code': 16, 'Name': 'running'}
        }]

        demo = client.describe_instances(Filters=[{'Name': 'tag:Name', 'Values': ['demo-instance']}])
        demo['Reservations'][0]['Instances'][0]['State']
            {'Code': 80, 'Name': 'stopped'}

        pprint.pprint(client.start_instances(InstanceIds=[instance_id]))
            {
                'ResponseMetadata': 
                        {
                            'HTTPHeaders': 
                            {   'content-length': '579',
                                'content-type': 'text/xml;charset=UTF-8',
                                'date': 'Sat, 22 Dec 2018 19:37:02 GMT',
                                'server': 'AmazonEC2'
                            },
                                'HTTPStatusCode': 200,
                                'RequestId': '21c65902-6665-4137-9023-43ac89f731d9',
                                'RetryAttempts': 0
                        },
                'StartingInstances': [{'CurrentState': {'Code': 0, 'Name': 'pending'},
                        'InstanceId': 'i-0c462c48bc396bdbb',
                        'PreviousState': {'Code': 80, 'Name': 'stopped'}}]
            }

    demo = client.describe_instances(Filters=[{'Name': 'tag:Name', 'Values': ['demo-instance']}])
    demo['Reservations'][0]['Instances'][0]['State']
        {'Code': 16, 'Name': 'running'} 

        date = datetime.datetime.utcnow().strftime('%Y%m%d') 
        date '20181221'
        name = f"InstanceID_{instance_id}_Image_Backup_{date}"
        name 'InstanceID_i-0c462c48bc396bdbb_Image_Backup_20181221'
        name = f"InstanceID_{instance_id}_Backup_Image_{date}"
        name 'InstanceID_i-0c462c48bc396bdbb_Backup_Image_20181221'
    
        pprint.pprint(client.create_image(InstanceId=instance_id, Name=name))
        {
            'ImageId': 'ami-00d7c04e2b3b28e2d',
            'ResponseMetadata': 
            {
                'HTTPHeaders': 
                {
                    'content-length': '242',
                    'content-type': 'text/xml;charset=UTF-8',
                    'date': 'Sat, 22 Dec 2018 20:13:55 GMT',
                    'server': 'AmazonEC2'
                },
                    'HTTPStatusCode': 200,
                    'RequestId': '7ccccb1e-91ff-4753-8fc4-b27cf43bb8cf',
                    'RetryAttempts': 0
            }
        }

        image = instance.create_image(Name=name + '_2')


        instance.tags[{'Key': 'BackUp', 'Value': ''}, {'Key': 'Name', 'Value': 'demo-instance'}]

        image.create_tags(Tags=[{'Key': 'RemoveOn', 'Value': remove_on}])
        [ec2.Tag(resource_id='ami-081c72fa60c8e2d58', key='RemoveOn', value='20181222')]