FROM python:3.10.9-slim-bullseye

ENV KUBESPRAY_REPO_REF="v2.25.0"
ENV ANSIBLECORE_VERSION="2.12"

# Install required packages including curl
RUN apt-get update && apt-get install -y openssh-client curl && rm -rf /var/lib/apt/lists/*

# Use shell scripting to handle conditional logic within a RUN command
RUN if curl --head --silent --fail "https://raw.githubusercontent.com/kubernetes-sigs/kubespray/$KUBESPRAY_REPO_REF/requirements-$ANSIBLECORE_VERSION.txt"; then \
        curl -o /opt/requirements.txt "https://raw.githubusercontent.com/kubernetes-sigs/kubespray/$KUBESPRAY_REPO_REF/requirements-$ANSIBLECORE_VERSION.txt"; \
    else \
        curl -o /opt/requirements.txt "https://raw.githubusercontent.com/kubernetes-sigs/kubespray/$KUBESPRAY_REPO_REF/requirements.txt"; \
    fi

RUN pip3 install --no-cache-dir --root-user-action=ignore -r /opt/requirements.txt
