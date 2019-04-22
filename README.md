# Helm Tillerless Docker

Helm docker image with tillerless plugin.

## How to use

Start helm tillerless container

    $ docker run --entrypoint /bin/bash --name helm -ti --rm -v $(pwd):/apps -v ~/.kube/singular_managed_config.yaml:/root/.kube/config helm-tillerless:latest

Assuming that we want to deploy stuff the production namespace, once inside the container run the following command to start the tillerless plugin.

    $ helm tiller start production

Run helm instruction, the example list all helm releases in the namespace.

    $ helm ls

Stop the tillerless plugin

    $ helm tiller stop
