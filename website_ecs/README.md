Refer to https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html for instructions.


1. To upload your local images to ECR, please login your docker first with command:
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com/anne-test-website
2. Build docker image but specify -platform when using apple M1 chip:  docker build -t 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com/anne-test-website:10_22 . --platform linux/amd64
See reference in https://stackoverflow.com/questions/66662820/m1-docker-preview-and-keycloak-images-platform-linux-amd64-does-not-match-th. 
4. Tag your local image with: docker tag 9c191f6c58e1 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com/anne-test-website:10_22
3. Push to ECR with: docker push 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com/anne-test-website:10_22 

If you are getting this error with Mac:
annewang@Annes-MBP website_ec2 % aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 064782962204.dkr.ecr.ap-southeast-2.amazonaws.com
Error saving credentials: error storing credentials - err: exit status 1, out: `Post "http://ipc/registry/credstore-updated": dial unix backend.sock: connect: no such file or directory`
annewang@Annes-MBP website_ec2 % 
Solve it with
"
I installed the Docker credentials helper for macOS, changed the credsStore parameter in ~/.docker/config.json to osxkeychain. That fixed the issues.
""
The reference in: https://stackoverflow.com/questions/64455468/error-when-logging-into-ecr-with-docker-login-error-saving-credentials-not

