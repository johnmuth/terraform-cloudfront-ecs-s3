# terraform-cloudfront-ecs-s3

## Static files S3 bucket

In this stage we'll use Terraform to set up an S3 bucket configured to serve static files over the web.

### What's here?

#### [aws.tf](aws/aws.tf)

Specifies which AWS region to use.

#### [s3.tf](aws/s3.tf)

Defines the static files S3 bucket.

#### [s3-bucket-policy.json](aws/s3-bucket-policy.json)

Makes the bucket publicly accessible.

## Do it

1. Set environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

2. Create the infrastructure

    ```
    ./create-infra.sh
    ``` 

3. Upload a file to the static files S3 bucket.

    ```
    ./upload-static-file.sh
    ```

4. Check that the file is available via the AWS S3 web URL.

    ```
    curl http://static-files-bucket-name.s3-website-eu-west-2.amazonaws.com/hello-world.txt
    ```

7. Tear down the infrastructure.

    ```
    ./delete-infra.sh
    ``` 
