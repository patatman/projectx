install_docker:
  pkg.installed:
    - pkgs:
        - docker.io
        - python-pip

start_docker_service:
  service.running:
    - name: docker
    #- require:
    #  - pkg: docker.io

install_docker_python:
  pip.installed:
    - name: docker-py
