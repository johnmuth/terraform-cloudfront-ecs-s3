# Initial setup

1. [Install Docker](https://docs.docker.com/get-docker/) if you don't already have it. 

2. [Create an AWS account](https://aws.amazon.com/) if you don't already have one.

3. Clone this repo.

4. Rename stuff. 3 bucket names need to be globally unique across all of AWS. The following commands should do it for you.

    Terraform state bucket name:

    ```
    newTerraformStateBucketName=$(git remote -v | head -n1 | awk '{print $2}' | cut -f2 -d':' |tr '/' '-'|sed "s/\.git/-terraform-state/")
    echo "newTerraformStateBucketName=$newTerraformStateBucketName"
    for file in `find .`; do sed -i '' "s/terraform-state-bucket-name/$newTerraformStateBucketName/" "$f"; done
    ```

    Static files bucket name:

    ```
    newStaticFilesBucketName=$(git remote -v | head -n1 | awk '{print $2}' | cut -f2 -d':' |tr '/' '-'|sed "s/\.git/-static-files/")
    echo "newStaticFilesBucketName=$newStaticFilesBucketName"
    for file in `find .`; do sed -i '' "s/static-files-bucket-name/$newStaticFilesBucketName/" "$f"; done
    ```

5. Set up environment variables for AWS access 

    ```
   export AWS_ACCESS_KEY_ID=<your aws access key id>
   export AWS_SECRET_ACCESS_KEY=<your aws secret access key>
    ```

6. Create an S3 bucket to hold your Terraform state.

    ```
   ./create-tf-state-bucket.sh
    ```

