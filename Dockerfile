FROM jupyter/minimal-notebook:6c91f60f69e7

ENV DISPLAY=:99

# Switch to notebook user
USER $NB_UID

RUN ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

# Add an x-server to the entrypoint. This is needed by Mayavi
ENTRYPOINT ["tini", "-g", "--", "xvfb-run", "-a", "jupyter", "notebook"]
