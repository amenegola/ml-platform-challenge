region  = "us-east-2"

lambda_get_data_name        = "get-random-beer-dev"
lambda_get_data_source_path = "../../../lambda_sources/get-random-beer"
lambda_get_data_handler     = "main.query_beer"

kinesis_stream_name = "random-beer-data-stream-dev"
kinesis_tags        = {Environment = "test"}

firehose_name_raw      = "registry-raw-data-dev"
firehose_role_name_raw = "kinesis_firehose_stream_role_dev" 
bucket_raw             = "random-beer-raw-dev" 

firehose_name_clean      = "registry-raw-data-dev"
firehose_role_name_clean = "kinesis_firehose_stream_role_dev" 
bucket_clean             = "random-beer-cleaned-dev"

lambda_clean_data_name        = "clean-data-dev"
lambda_clean_data_source_path = "../../../lambda_sources/clean-data"
lambda_clean_data_handler     = "main.clean_data"