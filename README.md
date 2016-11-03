# Docker-Workflowcomposer

Brocade Workflow composer (aka [stackstorm](https://stackstorm.com/)) in a single docker container, including DBs, GUI, etc...

This is, of course, not production ready, but very convenient for testing purpose.

# Building the container

The procedure is pretty simple:

1. copy your Workflow Composer key into the `./mykey` file
2. change the environment variable called `BWC_PASSWORD` and set your own BWC password
3. build the container, using a command like `docker build -t brocade/workflowcomposer $HOME/dockerfiles/brocade_workflowcomposer/`

# Using the container

## Normal usage

Use a command like this one:

  `docker run -it --rm=true --name=workflowcomposer --hostname=workflowcomposer brocade/workflowcomposer`

The GUI is available at https://<container IP>, user 'st2admin' and password the one set in `Dockerfile`

## Debugging

Use a command like this one:

  `docker run -it --rm=true --name=workflowcomposer --hostname=workflowcomposer --entrypoint=bash brocade/workflowcomposer`

