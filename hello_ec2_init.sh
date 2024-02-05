#!/bin/bash

# docker 설치
sudo curl https://get.docker.com | bash

# redis docker
# --requirepass옵션은  image뒤에 작성한다. 
sudo docker run --name my-redis -d -p 6379:6379 redis --requirepass 1234
