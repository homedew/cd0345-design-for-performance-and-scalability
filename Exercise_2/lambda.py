# lambda.py

def handler(event, context):
    print("greeting from Lambda!")
    return {
        'statusCode': 200,
        'body': 'greeting from Lambda!'
    }
