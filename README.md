# Docker-Tutorial
A docker tutorial on how to get things running on cair-gpu servers
The Dockerfile serves as a template for how to create a image that can run CUDA powered applications.
This sample runs cifar_10 as an example.

1. git clone https://github.com/UIA-CAIR/Docker-Tutorial.git
2. nvidia-docker build -t cair/tutorial .
3. nvidia-docker run -t cair/tutorial
4. nvidia-docker exec -it <DOCKER ID> bash
5. cd /development
6. python3 cifar10_train.py

You now succesfully started training of cifar_10!
