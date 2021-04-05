#!/usr/bin/env python

import base64
import json

keys = ['id','name','abv','ibu','target_fg','target_og','ebc','srm','ph']

def clean_data(event, context):
    output = []
    for record in event['records']:
        payload = base64.b64decode(record["data"])
        data = json.loads(payload)[0]
        data_cleaned = { key: data[key] for key in keys }
        output_record = {
            'recordId': record['recordId'],
            'result': 'Ok',
            'data': base64.b64encode(json.dumps(data_cleaned).encode('utf-8')).decode('utf-8')
        }
        output.append(output_record)
    return {'records': output}
