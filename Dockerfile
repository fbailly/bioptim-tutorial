FROM jupyter/minimal-notebook:latest

USER root

RUN apt update && apt -yq dist-upgrade \
    && apt install -yq --no-install-recommends \
    openssh-client \
    vim \
    curl \
    gcc \

# Xvfb
RUN apt install -yq --no-install-recommends \
    xvfb \
    x11-utils \
    libx11-dev \
    qt5-default \
    && apt clean
    
ENV DISPLAY=:99

# Switch to notebook user
USER $NB_UID

# RUN ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

# Add an x-server to the entrypoint. This is needed by Mayavi
ENTRYPOINT ["tini", "-g", "--", "xvfb-run", "-a", "jupyter", "notebook"]
