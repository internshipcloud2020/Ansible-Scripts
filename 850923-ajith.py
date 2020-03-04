import boto3
cloudwatch = boto3.client('cloudwatch')

# Create alarm
cloudwatch.put_metric_alarm(
    AlarmName='ajalarm',
    ComparisonOperator='greaterthanthreshold',
    EvaluationPeriods=1,
    MetricName='ajith-metric',
    Namespace='AWS/EC2',
    Period=60,
    Statistic='average',
    Threshold=30.0,
    ActionsEnabled=False,
    AlarmDescription='alarm when server CPU exceeds 30%',
    Dimensions=[
        {
          'Name': 'instanceno',
          'Value': 'instanceidno'
        },
    ],
    Unit='seconds'
)