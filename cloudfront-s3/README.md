# terraform-cloudfront-ecs-s3

## Cloudfront distribution + S3

In this stage we'll use Terraform to set up:
    - an S3 bucket configured to serve static files over the web
    - a Cloudfront distribution

## Quick start

1. Set environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

2. Add two new variables to your .tfvars file:

    ```
    echo "xxx=yyy" >> ../
    ``` 

2. Create the infrastructure

    ```
    ./create-infra.sh
    ``` 

5. Upload a file to the static files S3 bucket.

    ```
    ./upload-static-file.sh
    ```

6. Check that the file is available via the Cloudformation domain.

    ```
    curl http://dvibgn96rogbo.cloudfront.net/hello-world.txt
    ```

7. Tear down the infrastructure.

    ```
    ./delete-infra.sh
    ``` 
