Cloud9 setup for docker and flask mini-server
----------------------------------------------

Dockerfile builds a cloud9 environment from ws-cpp originally here: 

[ws-cpp](https://github.com/c9/templates/tree/master/ws-cpp)

but slightly customized/modified in the 'ws-cust' directory
of this repository.

Before building copy public key from cloud9 IDE to 'authorized_keys' file.

To build images first cd to ws-cust and:

docker build -t ws-cpp .

Then back to the repo root and:

docker build -t cloud9 .

Then launch cloud9:

Blah blah. Need to combine these. Also copy home dir to named volume to make this persistent.

docker run -d -it --rm --expose 9090 -p 0.0.0.0:9090:22 --name cloud9 --security-opt seccomp:unconfined -v c9home:/newHome cloud9 bash

docker-compose up





