Refer to https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html for instructions.


1. To upload your local images to ECR, please login your docker first with command:
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com
2. Tag your local image with: docker tag 9c191f6c58e1 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com/anne-test-website:10_22
3. Push to ECR with: docker push 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com/anne-test-website:10_22 
