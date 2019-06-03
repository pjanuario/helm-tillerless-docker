FROM alpine/helm:2.14.0

# Adds
# * git: required to install tillerless plugin
# * bash: required to run tiller less plugin
RUN apk add --no-cache git bash

# Adds missing helm plugins
RUN mkdir -p ~/.helm/plugins

# Install tillerless plugin
RUN helm plugin install https://github.com/rimusz/helm-tiller
