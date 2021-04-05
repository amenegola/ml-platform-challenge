#!/usr/bin/env python

import os
import boto3
import json
import requests

url = 'https://api.punkapi.com/v2/beers/random'
STREAM_NAME = os.getenv('STREAM_NAME')
k_client = boto3.client('kinesis')

def query_beer(event, context):
    r = requests.get(url)
        
    # write the data to the stream
    put_response = k_client.put_record(
                StreamName=STREAM_NAME,
                Data=r.text,
                PartitionKey='shard-1')
