# Sinatra

## Background

A RESTful API on Ruby Sinatra.

## Improvements

1.  Ruby data mapping [AWS Record]() was changed for [Dynamoid](https://github.com/Dynamoid/dynamoid) ORM.
    > Gems stats can be found in [The Ruby Toolbox](https://www.ruby-toolbox.com/categories/Amazon_DynamoDB?display=compact&order=score).
2.  Given the NoSQL premise, the data model design pattern has been modified to follow the __DynamoDB Single Table__ one.
3.  The __Sinatra application__ abstraction was changed for a modular approach, using __Sinatra::Application__ as middleware.
4.  To remove operational burden and reduce function package size, the __Ruby Gems dependencies__ now are bundled and provided as a __layer in Amazon Lambda__.

## Breakdown

- Database
    - [Table Schema](./docs/db-schema.md)
- API
    - [Ruby Sinatra App](./docs/api.md)
    - [API Endpoints](./docs/api-endpoints.md)

## Deployment

### Build Packages

__Ruby Gems__

To reduce operational burden and reduce function package size(>=35MB). The Gems dependencies are deployed as a Lambda Layer.

To create the layer archive execute:

```bash
bash ./bin/build.sh --layer
```

__Lambda Function__

To create the lambda code source archive execute:

```bash
bash ./bin/build.sh --lambda
```

### Stack Deployment

1.  Create a S3 Bucket. Save the name, you will use it in the next step
2.  Create the deployment package
3.  Install SAM CLI and run the following command
    ```bash
     $ sam package \
         --template-file template.yaml \
         --output-template-file serverless-output.yaml \
         --s3-bucket { your-S3-bucket-name }
    ```
4.  Deploying your application
    ```bash
     $ sam deploy \
         --template-file serverless-output.yaml \
         --stack-name cloud-dev-challenge \
         --capabilities CAPABILITY_IAM
    ```
