region  = "us-east-2"

cloudwatch_rule_name = "start-beer-collection-dev"
lambda_schedule_expression = "rate(5 minutes)"

lambda_get_data_name        = "get-random-beer-dev"
lambda_get_data_source_path = "../../../lambda_sources/get-random-beer"
lambda_get_data_handler     = "main.query_beer"
environment_variables       = {STREAM_NAME = "random-beer-data-stream-dev"}
create_kinesis_policy       = true

kinesis_stream_name = "random-beer-data-stream-dev"
kinesis_tags        = {Environment = "test"}

firehose_name_raw      = "registry-raw-data-dev"
firehose_role_name_raw = "firehose_role_raw_dev" 
bucket_raw             = "beer-raw-dev" 

firehose_name_clean      = "clean-data-dev"
firehose_role_name_clean = "firehose_role_clean_data_dev" 
bucket_clean             = "beer-cleaned-dev"

lambda_clean_data_name        = "clean-data-dev"
lambda_clean_data_source_path = "../../../lambda_sources/clean-data"
lambda_clean_data_handler     = "main.clean_data"

database_name = "random-beer-database"
table_name    = "random-beer-table"
crawler_name  = "random-beer-crawler"