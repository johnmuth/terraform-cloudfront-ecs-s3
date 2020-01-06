# Initial setup

1. [Create an AWS account](https://aws.amazon.com/) if you don't already have one.

2. [Install Docker](https://docs.docker.com/get-docker/) if you don't already have it.

3. [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) if you don't already have it.

4. Fork this repo. (I suggest fork because the scripts below use the git repo url to generate unique bucket names - 
they won't be unique if you just clone. Alternatively you could fiddle with the scripts so they don't rely on the git 
repo url.)

5. Set up environment variables for AWS access 

    ```
   export AWS_ACCESS_KEY_ID=<your aws access key id>
   export AWS_SECRET_ACCESS_KEY=<your aws secret access key>
    ```

# Next

[S3](s3/README.md)
