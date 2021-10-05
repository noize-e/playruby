# Ruby Sinatra App

## Business Requirements

- Consume data on JSON format thorugh API Endpoint.
- Define API resources and methods

## Install

### Local Env

Install Ruby Gems dependencies:

```bash
bundle install
```

Run Sinatra's with Rack:

```bash
cd app && rackup
```

Check [API Endpoints](./docs/API.md).

## Resources

### Dynamoid Config

```ruby
Dynamoid.configure do |config|
    config.adapter = 'local' # This adapter allows offline development without connecting to the DynamoDB servers. Data is *NOT* persisted.
    # config.adapter = 'aws_sdk' # This adapter establishes a connection to the DynamoDB servers using Amazon's own AWS gem.
    # config.access_key = 'access_key' # If connecting to DynamoDB, your access key is required.
    # config.secret_key = 'secret_key' # So is your secret key. 
    config.namespace = "dynamoid_app_development" # To namespace tables created by Dynamoid from other tables you might have.
    config.warn_on_scan = true # Output a warning to the logger when you perform a scan rather than a query on a table.
    config.partitioning = true # Spread writes randomly across the database. See "partitioning" below for more.
    config.partition_size = 200  # Determine the key space size that writes are randomly spread across.
    config.read_capacity = 100 # Read capacity for your tables
    config.write_capacity = 20 # Write capacity for your tables
    config.endpoint = 'dynamodb.us-east-1.amazonaws.com' # Set the regional endpoint
end
```
