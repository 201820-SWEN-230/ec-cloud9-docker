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
# Now throw in some python goodies
#
# RUN apt-get install -y python python-dev python-pip python-setuptools ipython \
#     python-scipy python-matplotlib python-virtualenv virtualenvwrapper
# 

RUN apt-get install -y python3 python3-dev python3-pip python3-setuptools \
     ipython3 python3-scipy python3-matplotlib 
 
RUN apt-get install -y python3.5-complete

RUN pip3 install flask

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 

RUN su ubuntu -c "bash ./Miniconda3-latest-Linux-x86_64.sh -b -p /home/ubuntu/miniconda"

RUN rm ./Miniconda3-latest-Linux-x86_64.sh

RUN /home/ubuntu/miniconda/bin/conda install -y cython

RUN /home/ubuntu/miniconda/bin/conda install -y pandas

RUN /home/ubuntu/miniconda/bin/conda install -y scipy

RUN /home/ubuntu/miniconda/bin/conda install -y matplotlib

RUN /home/ubuntu/miniconda/bin/conda install -y jupyter

RUN chown -R ubuntu:ubuntu /home/ubuntu/miniconda

