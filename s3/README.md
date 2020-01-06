# terraform-cloudfront-ecs-s3

## Static files S3 bucket

In this stage we'll use Terraform to set up an S3 bucket configured to serve static files over the web.

### What's here?

#### [aws.tf](aws/aws.tf)

Specifies which AWS region to use.

#### [s3.tf](aws/s3.tf)

Defines the static files S3 bucket.

#### [variables.tf](aws/variables.tf)

Declares two [Terraform Input Variables](https://www.terraform.io/docs/configuration/variables.html), `aws_region` and `static_files_bucket`.

Values for Input Variables can be provided on the command line or the way I'll do it here, with a Variable Definitions (.tfvars) File.

## Do it

1. Set environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY

2. Create your Variable Definitions File.

    ```
    cp ../example.tfvars ../testing.tfvars
    vi ../testing.tfvars    
    ```

3. Create the infrastructure.

    ```
    terraform init aws
    terraform plan -var-file='../testing.tfvars' aws
    terraform apply -var-file='../testing.tfvars' aws
    ``` 

4. Upload a file to the static files S3 bucket.

    ```
    ./upload-static-file.sh -r eu-west-2 -b my-static-files-bucket
    ```

5. Check that the file is available via the AWS S3 web URL.

    ```
    curl http://my-static-files-bucket.s3.eu-west-2.amazonaws.com/hello-world.txt
    ```

6. (Optional) Tear it all down.

    ```
    terraform destroy -var-file='../testing.tfvars' aws
    ``` 
