# Build a Docker image based on the cloud9/ws-nodejs Docker image.
FROM ws-cpp

# Enable the Docker container to communicate with AWS Cloud9 by
# installing SSH.

RUN apt-get update && apt-get install -y openssh-server

# Ensure that Node.js is installed.

RUN apt-get install -y nodejs && ln -s /usr/bin/nodejs /usr/bin/node

# Disable password authentication by turning off the
# Pluggable Authentication Module (PAM).
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# Add the AWS Cloud9 SSH public key to the Docker container.
# This assumes a file named authorized_keys containing the
# AWS Cloud9 SSH public key already exists in the same
# directory as the Dockerfile.
RUN mkdir -p /home/ubuntu/.ssh
ADD ./authorized_keys /home/ubuntu/.ssh/authorized_keys
RUN chown -R ubuntu /home/ubuntu/.ssh /home/ubuntu/.ssh/authorized_keys && \
chmod 700 /home/ubuntu/.ssh && \
chmod 600 /home/ubuntu/.ssh/authorized_keys

# Start SSH in the Docker container.

CMD /usr/sbin/sshd -D

# Update the password to a random one for the user ubuntu.

RUN echo "ubuntu:$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)" | chpasswd

RUN apt-get install gdbserver

#
# use miniconda to build a robust python evironment
#

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 

USER ubuntu

RUN bash ./Miniconda3-latest-Linux-x86_64.sh -b -p /home/ubuntu/miniconda

ADD conda_create.sh .

RUN bash -v ./conda_create.sh

RUN echo ". /home/ubuntu/miniconda/etc/profile.d/conda.sh" >> ~ubuntu/.bashrc

RUN echo ". /home/ubuntu/miniconda/bin/activate py36" >> ~ubuntu/.bashrc

RUN wget -O - https://raw.githubusercontent.com/c9/install/master/install.sh | bash

USER root

RUN rm ./Miniconda3-latest-Linux-x86_64.sh


