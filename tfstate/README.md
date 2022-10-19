This folder is to create s3 bucket of hosting the tfstate files when code pushed to github. 

Each terraform plan and apply will trigger to create a new tfstate file to be updated in s3 bucket of anne-tfstate-store. 

Each github action will also trigger the tfstate file to be updated in s3 bucket. 