install_docker:
  pkg.installed:
    - name: docker.io

install_pip:
   pkg.installed:        
    - name: python-pip

start_docker_service:
  service.running:
    - name: docker
    - require:
      - pkg: python-pip

install_docker_python:
  pip.installed:
    - name: docker-py
    - reload_modules: True
