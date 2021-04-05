#!/usr/bin/env python

import boto3
import json
import requests

url = 'https://api.punkapi.com/v2/beers/random'
stream_name = 'random-beer-data-stream'
k_client = boto3.client('kinesis')

def query_beer(event, context):

    r = requests.get(url)
        
    # write the data to the stream
    put_response = k_client.put_record(
                StreamName=stream_name,
                Data=r.text,
                PartitionKey='shard-1')
