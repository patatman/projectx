portainer:
  docker_container.running:
    - image: portainer/portainer
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock:rw
    - port_bindings:
      - "9000:9000/tcp"
#  require:
#    pip.installed: docker-py

#traefik:
#  file.managed:
#    - name: /srv/docker/traefik/traefik.toml
#    - source: salt://traefik/traefik.toml
#  docker_container.running:
#    - image: traefik
#    - binds:
#    - binds:
#      - /var/run/docker.sock:/var/run/docker.sock:rw
#      - /srv/docker/traefik/:/etc/traefik/traefik.toml:rw
#    - port_bindings:
#      - "80:80/tcp"
#      - "443:443/tcp"
#      - "8080:8080/tcp"

sabnzbd:
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

sonarr:
  docker_container.running:
    - image: linuxserver/sonarr
    - binds:
      - /srv/docker/sonarr/config:/config:rw
      - /data/sabnzbd/downloads:/downloads:rw
      - /data/media/tv:/tv:rw
    - port_bindings:
      - "8989:8989/tcp"
