region  = "us-east-2"

kinesis_stream_name = "random-beer-data-stream-dev"
kinesis_tags        = {Environment = "test"}

kinesis_firehose_stream_name      = "registry-raw-data-dev"
kinesis_firehose_stream_role_name = "kinesis_firehose_stream_role_dev" 
raw_bucket_name                   = "random-beer-raw-dev" 

lambda_get_data_name        = "get-random-beer-dev"
lambda_get_data_source_path = "../../../lambda_sources/get-random-beer"
lambda_get_data_handler     = "main.query_beer"

lambda_clean_data_name        = "clean-data-dev"
lambda_clean_data_source_path = "../../../lambda_sources/clean-data"
lambda_clean_data_handler     = "main.clean_data"