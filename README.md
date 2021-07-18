### WageGAN for SageMaker Docker image

This repository contains a Dockerfile for deploying WaveGAN training job to Amazon SageMaker as a custom ML algorithm.  
You can learn more about WaveGAN by reading the doc in the original repository. You can build a Docker image file from it and then push it to
 [Amazon ECR](https://aws.amazon.com/ecr/). 
  
#### Prerequisites

* Docker
* AWS account
* AWS Access Keys
* AWS command line tools

#### Building and pushing to Amazon ECR

```bash
git clone git@github.com:deviant-syndrome/wavegan-sagemaker.git
git submodule init
git submodule update
./build_and_push.sh sagemaker-wavegan
```

*NOTE*: You can run into some trouble when pulling and pushing images from Amazon, because you need to "login" to Amazon ECR first. Furthermore
, the IAM user you are logging-in to, should have the right access levels (AdministratorAccess). 
You can read more about using docker login for Amazon ECR in the 
[official documentation](https://docs.aws.amazon.com/AmazonECR/latest/userguide/get-set-up-for-amazon-ecr.html).  

#### Usage 

If you're using SageMaker Studio or AWS SDK for Python (code example was taken from [Amazon SageMaker Examples](https://sagemaker-examples.readthedocs.io/en/latest/advanced_functionality/tensorflow_bring_your_own/tensorflow_bring_your_own.html)):

```python
from sagemaker import get_execution_role
role = get_execution_role()

estimator = Estimator(
    role=role,
    instance_count=1,
    instance_type="ml.g4dn.xlarge",
    image_uri="sagemaker-wavegan:latest"
)

estimator.fit("file:///tmp/train-data")
```

Otherwise, you can use AWS SageMaker GUI to create a training job, it has pretty descriptive set of options to select your own image and point to
 an S3
 bucket that contains source data for training and checkpoints.
 
#### Misc. info
This image is built upon a GPU-optimized Tensorflow image. The original code of WaveGAN was primarly targeted to single-GPU systems and did
 not have support to LA-optimized computational devices. This can be added relatively easily, however I would need to a PR request to original
  maintainers or use my fork for that.   

Also, there is no Sagemaker Tensorflow data or model partitioning support at the moment. The code changes required for that are yet beyond my
 level of expertise. 
    