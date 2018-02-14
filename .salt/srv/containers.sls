portainer_docker_initialization:
  docker_container.running:
    - image: portainer/portainer
#  require:
#    pip.installed: docker-py

sabnzbd_docker_initialization:
  docker_container.running:
    - image: linuxserver/sabnzbd
    - binds:
      - /srv/docker/sabnzbd/config:/config:rw
      - /data/sabnzbd/downloads:/downloads:rw
      - /data/sabnzbd/incomplete-downloads:/incomplete-downloads:rw
    - port_bindings:
      - "8080:8080/tcp"
  file.managed:
    - name: /srv/docker/sabnzbd/config/sabnzbd.ini
    - source: salt://sabnzbd/sabnzbd.ini

sonarr_docker_initialization:
  docker_container.running:
    - image: linuxserver/sonarr
    - binds:
      - /srv/docker/sonarr/config:/config:rw
      - /data/sabnzbd/downloads:/downloads:rw
      - /data/media/tv:/tv:rw
    - port_bindings:
      - "8989:8989/tcp"
