# terraform-cloudfront-ecs-s3

## Cloudfront distribution + S3

In this stage we'll use Terraform to set up:
    - an S3 bucket configured to serve static files over the web
    - a Cloudfront distribution

## Do it

1. Create the infrastructure

    ```
    terraform apply aws
    ``` 

2. Upload a file to the static files S3 bucket.

    ```
    ./upload-static-file.sh
    ```

3. Check that the file is available via the Cloudformation domain.

    ```
    curl http://dvibgn96rogbo.cloudfront.net/hello-world.txt
    ```

4. Tear down the infrastructure.

    ```
    terraform destroy aws
    ``` 
