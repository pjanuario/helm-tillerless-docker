# Helm Tillerless Docker

Helm docker image with [tillerless plugin](https://rimusz.net/tillerless-helm/).

## How to use

Start helm tillerless container

    $ docker run --entrypoint /bin/bash --name helm -ti --rm -v ~/.kube/singular_managed_config.yaml:/root/.kube/config prnjanuario/helm-tillerless:latest

Assuming that we want to deploy stuff the production namespace, once inside the container run the following command to start the tillerless plugin.

    $ helm tiller start production

Run helm instruction, the example list all helm releases in the namespace.

    $ helm ls

Stop the tillerless plugin

    $ helm tiller stop

# GitLab CI/CD Example

The following snippet can be integrated in GitLab CI/CD pipeline to release a image using helm tillerless image.

Change the following variables, according your needs:

* CHART: the local path to your chart
* CHART_RELEASE: the chart release name
* NAMESPACE: where tiller server should be connected to
* TAG: the docker image tagµ


```
variables:
  KUBEDIR: /root/.kube
  KUBECONFIG: /root/.kube/config
  CHART: ./chart
  NAMESPACE: production
  NAME: example
  TAG: e142d537

stages:
  - production

.prod_deploy: &prod_deploy
  image:
    name: prnjanuario/helm-tillerless:latest
    entrypoint: ["/bin/bash", "-c"]

  stage: production
  environment: production
  script:
    - mkdir -p ${KUBEDIR}
    - echo -n ${KUBE_CONFIG} | base64 -d > ${KUBECONFIG}
    - helm tiller run production -- helm upgrade -i --namespace $NAMESPACE --set image.tag=$TAG $CHART_RELEASE $CHART

auto-deploy-master:
  <<: *prod_deploy
  only:
    - master
```
