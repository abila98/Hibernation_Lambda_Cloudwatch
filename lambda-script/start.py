import boto3  
client = boto3.client('ec2') 
instances_id = []

def lambda_handler(event, context):
    filters = [{  
    'Name': "tag:hibernate",
    'Values': ['true']
    }]
    response = client.describe_instances(Filters=filters)
    print(response)       # in logs
    
    
    for instanceid in response["Reservations"]:
        for id in instanceid["Instances"]:
            print(id["InstanceId"])
            
            temp = id["InstanceId"]
            client.stop_instances(InstanceIds=[temp])
            
            instances_id.append(id["InstanceId"])
            
    
    return instances_id     #comes in response
    
