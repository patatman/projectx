install_docker:
  pkg.installed:
    - name: docker.io

install_pip:
  pkg.installed: 
    - name: python-pip

start_docker_service:
  service.running:
    - name: docker
    #- require:
    #  - pkg: docker.io

install_docker_python:
  pip.installed:
    - name: docker-py
    - reload_modules: True
    - require:
        - pkg: python-pip

#portainer:
#  docker_container.running:
#    - image: portainer/portainer
#  require: 
#    pip.installed: docker-py
