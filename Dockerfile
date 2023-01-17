FROM python:3.10.9-slim-bullseye

ENV KUBESPRAY_REPO_REF="v2.20.0"
ENV ANSIBLECORE_VERSION="2.12"

RUN apt-get update && apt-get install -y openssh-client && rm -rf /var/lib/apt/lists/*

ADD https://raw.githubusercontent.com/kubernetes-sigs/kubespray/$KUBESPRAY_REPO_REF/requirements-$ANSIBLECORE_VERSION.txt /opt/requirements.txt
RUN pip3 install --no-cache-dir --root-user-action=ignore -r /opt/requirements.txt
