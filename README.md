# antier

1.) while creating entire infra make sure that alb.yaml.tpl, install_rmq_docker.sh.tpl, loki.yaml.tpl these 3 file should come under template folder
2.) Make sure to make folder with name scripts and then keep these files buildspec.yaml, install_jenkins.sh, install_redis_docker.sh file below is the buildspec.yaml file
version: 0.2

phases:
  install:
    commands:
      - echo Logging in to Amazon ECR...
  pre_build:
      commands:
      - echo "Generating Tag ...."
      - TAG=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION|cut -c1-7)
  build:
    commands:
      - echo "Building image ...."
      - docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}:${TAG} .
  post_build:
    commands:
      - echo "Pushing image to ecr ...."
      - aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com
      - docker push  ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}:${TAG} 
      - printf '[{"name":"%s","imageUri":"%s"}]' ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}:$TAG > build.json
artifacts:
  files: 
    - build.json

