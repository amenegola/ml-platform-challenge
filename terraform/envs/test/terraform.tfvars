region  = "us-east-2"
kinesis_stream_name = "random-beer-data-stream-dev"
kinesis_tags = {
    Environment = "test"
  }

kinesis_firehose_stream_name = "registry-raw-data-dev"
kinesis_firehose_stream_role_name = "kinesis_firehose_stream_role_dev" 
raw_bucket_name = "random-beer-raw-dev" 
