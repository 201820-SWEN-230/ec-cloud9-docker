Cloud9 setup for docker and flask mini-server
----------------------------------------------

Dockerfile builds a cloud9 environment from ws-cpp originally here: 

[ws-cpp](https://github.com/c9/templates/tree/master/ws-cpp)

but slightly customized/modified in the 'ws-cust' directory of this repository.

authorized_keys is a placeholder that should be replaced at runtime with the real thing.

To build images first cd to ws-cust and:

docker build -t ws-cust .

Then back to the repo root and:

docker build -t cloud9 .

Then launch the container:

docker-compose up

You'll want to edit the 'authorized_keys' file in the containers home directory
to make it a "real" one. The file in the repository is just a placeholder.
