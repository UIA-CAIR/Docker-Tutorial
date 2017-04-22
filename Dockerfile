FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER Per-Arne Andersen

RUN apt-get update && apt-get install -y apt-utils
RUN apt-get update && apt-get install -y openssh-server
RUN apt-get update && apt-get install git python3 python3-pip unzip libcudnn5 libcudnn5-dev -y
RUN pip3 install tensorflow-gpu

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

ADD . /development

RUN apt-get purge libcudnn5 libcudnn5-dev -y
RUN apt-get install libcudnn5 libcudnn5-dev -y -f
ENV LD_LIBRARY_PATH /usr/local/cauda/lib64:/usr/local/cuda/lib
RUN ldconfig /usr/local/cuda/lib64
RUN echo "ldconfig /usr/local/cuda/lib64" >> /root/.bashrc
RUN cd /development



