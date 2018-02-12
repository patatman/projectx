install_docker:
  pkg.installed:
    - name: docker.io

start_docker_service:
  service.running:
    - name: docker
    - require:
      - pkg: docker.io
