## clean-data - Lambda

This Lambda is used to receive data from Firehose, select only necessary attributes, and send back to Firehose so that it can register this clean data on a s3 bucket.

Attributes:

```
keys = ['id','name','abv','ibu','target_fg','target_og','ebc','srm','ph']

```