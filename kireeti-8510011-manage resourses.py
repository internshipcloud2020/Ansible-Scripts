import os
import json
from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
WEST_US = "westus"
GROUP_NAME = "azure-sample-group"

def run_example():
    
    subscription_id = os.environ.get(
        "AZURE_SUBSCRIPTION_ID", "11111111-1111-1111-1111-111111111111"
    )  

    credentials = ServicePrincipalCredentials(
        client_id=os.environ["AZURE_CLIENT_ID"],
        secret=os.environ["AZURE_CLIENT_SECRET"],
        tenant=os.environ["AZURE_TENANT_ID"],
    )

    client = ResourceManagementClient(credentials, subscription_id)

    
    resource_group_params = {"location": "westus"}

    # List Resource Groups
    print("List Resource Groups")
    for item in client.resource_groups.list():
        print_item(item)

    # Create Resource group
    print("Create Resource Group")
    print_item(
        client.resource_groups.create_or_update(
            GROUP_NAME, resource_group_params)
    )

    # Modify the Resource group
    print("Modify Resource Group")
    resource_group_params.update(tags={"hello": "world"})
    print_item(
        client.resource_groups.create_or_update(
            GROUP_NAME, resource_group_params)
    )

 # Delete Resource group and everything in it
    print("Delete Resource Group")
    delete_async_operation = client.resource_groups.delete(GROUP_NAME)
    delete_async_operation.wait()
    print("\nDeleted: {}".format(GROUP_NAME))

if __name__ == "__main__":
    run_example()
