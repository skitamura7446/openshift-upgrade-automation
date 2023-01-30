FROM docker.io/amazon/aws-cli:latest

RUN yum update -y \
    && yum install tar gzip gettext -y \
    && curl -LO "https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux.tar.gz" \
    && curl -LO "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz" \
    && tar xvf rosa-linux.tar.gz \
    && tar xvf openshift-client-linux.tar.gz \
    && mv rosa /usr/local/bin/rosa \
    && mv oc /usr/local/bin/oc

ENTRYPOINT [""]
