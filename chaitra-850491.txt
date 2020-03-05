TOPIC: Create a function in Azure that responds to HTTP requests

To create and activate a virtual environment

In bash, type the follwing commands
1. python -m venv .venv
2. source .venv/bin/activate
3. sudo apt-get install python3-venv

1. In the virtual environment, run the func init command to create a functions project in a folder named LocalFunctionProj with the specified runtime:
func init LocalFunctionProj --python

2. Navigate into the project folder:
cd LocalFunctionProj

3. Add a function to your project by using the following command, where the --name argument is the unique name of your function and the --template argument specifies the function's trigger.
func new --name HttpExample --template "HTTP trigger"

Python code:

import logging

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    if name:
        return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
             status_code=200
        )

4. Run the instance locally
func start