# terraform-cloudfront-ecs-s3

This project demonstrates how to use Terraform to manage a bunch of AWS infrastructure for hosting a webapp.

The main thing I wanted to figure out was how to set up Cloudfront to route traffic to a webapp and to an S3 bucket, 
depending on the path.

## Overview

- S3 bucket : to serve static files
- Cloudfront : to route traffic to S3 or ECS depending on path
- TODO : webapp : Node.js + Express webapp
- TODO : ECS cluster : to run the webapp in Docker container(s)  

## Prerequisites

- Docker
- AWS account

## Quick start

1. Clone this repo

2. Set environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

3. Create an S3 bucket to hold the Terraform state (see Notes below for why).

    ```
    ./create-tf-state-bucket.sh
    ``` 

4. Create the infrastructure

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

## Notes

- Runs Terraform commands in Docker. I've chosen to do it this way to avoid installing Terraform natively.
- Stores [Terraform state](https://www.terraform.io/docs/state) in S3. Useful if working with Terraform in a team.
