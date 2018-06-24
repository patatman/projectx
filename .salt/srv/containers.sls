#################################################################################
##########################      Infrastructure      #############################
#################################################################################

#caddy:
#  docker_container.running:
#    - image: lucaslorentz/caddy-docker-proxy:latest
#    - port_bindings:
#      - "80:80/tcp"
#      - "443:443/tcp"
#    - restart_policy: always

traefik:
  docker_container.running:
    - image: traefik
    - command: "--api --docker"
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock
    - port_bindings:
      - "81:80/tcp"
      - "8084:8080/tcp"
    - restart_policy: always

redis:
  docker_container.running:
    - image: redis:latest
    - binds:
      - /data/docker/redis:/data:rw
    - port_bindings:
      - "6379:6379/tcp"
    - restart_policy: always

portainer:
  docker_container.running:
    - image: portainer/portainer:latest
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock:rw
    - port_bindings:
      - "9000:9000/tcp"
    - labels:
      - "traefik.frontend.rule=Host:portainer.docker.localhost"
    - restart_policy: always

#################################################################################
########################## Front-End webinterfaces   ############################
#################################################################################

organizr:
  docker_container.running:
    - image: lsiocommunity/organizr:latest
    - binds:
      - /data/docker/organizr/config:/config:rw
    - port_bindings:
      - "8888:80/tcp"
    - restart_policy: always

htpcmanager:
  docker_container.running:
    - image: linuxserver/htpcmanager:latest
    - binds:
      - /data/docker/htpcmanager/config:/config:rw
    - port_bindings:
      - "8085:8085/tcp"
    - restart_policy: always

muximux:
  docker_container.running:
    - image: linuxserver/muximux:latest
    - binds:
      - /data/docker/muximux/config:/config:rw
    - port_bindings:
      - "8880:80/tcp"
    - restart_policy: always

ombi:
  docker_container.running:
    - image: linuxserver/ombi:latest
    - binds:
      - /data/docker/ombi/config:/config:rw
    - port_bindings:
      - "3579:3579/tcp"
    - restart_policy: always

#################################################################################
##########################    Indexing Containers   #############################
#################################################################################

hydra:
  docker_container.running:
    - image: linuxserver/hydra:latest
    - binds:
      - /data/docker/hydra/config:/config:rw
    - port_bindings:
      - "5075:5075/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

jackett:
  docker_container.running:
    - image: linuxserver/jackett:latest
    - binds:
      - /data/docker/jackett/config:/config:rw
      - /data/docker/jackett/blackhole:/downloads:rw
    - port_bindings:
      - "9117:9117/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

#################################################################################
##########################    Usenet Downloaders    #############################
#################################################################################

sabnzbd:
  file.managed:
    - name: /data/docker/sabnzbd/config/sabnzbd.ini
    - source: salt://sabnzbd/sabnzbd.ini
  docker_container.running:
    - image: linuxserver/sabnzbd:latest
    - binds:
      - /data/docker/sabnzbd/config:/config:rw
      - /data/downloads/complete:/complete:rw
      - /data/downloads/incomplete:/incomplete-downloads:rw
    - port_bindings:
      - "8080:8080/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

nzbget:
  docker_container.running:
    - image: linuxserver/nzbget:latest
    - binds:
      - /data/docker/nzbget/config:/config:rw
      - /data/downloads:/downloads:rw
    - port_bindings:
      - "6789:6789/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

#################################################################################
##########################    Torrent Downloaders   #############################
#################################################################################

deluge:
  docker_container.running:
    - image: linuxserver/deluge:latest
    - binds:
      - /data/docker/deluge/config:/config:rw
      - /data/downloads/torrents:/downloads:rw
    - networks:
      - host
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

transmission:
  docker_container.running:
    - image: linuxserver/transmission:latest
    - binds:
      - /data/docker/transmission/config:/config:rw
      - /data/downloads/torrents:/downloads:rw
      - /data/downloads/torrents/watch:/watch:rw
    - port_bindings:
      - "9091:9091/tcp"
      - "51413:51413/tcp"
      - "51413:51413/udp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

#################################################################################
##########################      TV Containers       #############################
#################################################################################

sonarr:
  docker_container.running:
    - image: linuxserver/sonarr:latest
    - binds:
      - /data/docker/sonarr/config:/config:rw
      - /data/downloads:/downloads:rw
      - /data/media/tv:/tv:rw
    - port_bindings:
      - "8989:8989/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

sickrage:
  docker_container.running:
    - image: linuxserver/sickrage:latest
    - binds:
      - /data/docker/sickrage/config:/config:rw
      - /data/downloads:/downloads:rw
      - /data/media/tv:/tv:rw
    - port_bindings:
      - "8081:8081/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

#################################################################################
##########################     Movie Containers     #############################
#################################################################################

radarr:
  docker_container.running:
    - image: linuxserver/radarr:latest
    - binds:
      - /data/docker/radarr/config:/config:rw
      - /data/downloads:/downloads:rw
      - /data/media/movies:/movies:rw
    - port_bindings:
      - "7878:7878/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

couchpotato:
  docker_container.running:
    - image: linuxserver/couchpotato:latest
    - binds:
      - /data/docker/couchpotato/config:/config:rw
      - /data/downloads:/downloads:rw
      - /data/media/movies:/movies:rw
    - port_bindings:
      - "5050:5050/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

#################################################################################
##########################    Music Containers      #############################
#################################################################################

headphones:
  docker_container.running:
    - image: linuxserver/headphones:latest
    - binds:
      - /data/docker/headphones/config:/config:rw
      - /data/downloads:/downloads:rw
      - /data/media/music:/music:rw
    - port_bindings:
      - "8181:8181/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

lidarr:
  docker_container.running:
    - image: linuxserver/lidarr:latest
    - binds:
      - /data/docker/lidarr/config:/config:rw
      - /data/downloads:/downloads:rw
      - /data/media/music:/music:rw
    - port_bindings:
      - "8686:8686/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

    #################################################################################
    ########################    Streaming services    ###############################
    #################################################################################

plex:
  docker_container.running:
    - image: linuxserver/plex:latest
    - binds:
      - /data/docker/plex/config:/config:rw
      - /data/media/tv:/data/tvshows:rw
      - /data/media/movies:/data/movies:rw
      - /data/transcode/transcode:/transcode:rw
    - port_bindings:
      - "32400:32400/tcp"
      - "32400:32400/udp"
      - "32469:32469/tcp"
      - "32469:32469/udp"
      - "5353:5353/udp"
      - "1900:1900/udp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always

emby:
  docker_container.running:
    - image: emby/embyserver
    - binds:
      - /data/docker/plex/config:/config:rw
      - /data/media/tv:/data/tvshows:rw
      - /data/media/movies:/data/movies:rw
      - /data/transcode/transcode:/transcode:rw
    - port_bindings:
      - "8096:8096/tcp"
      - "8920:8920/tcp"
    - environment:
      - PUID: 7000
      - PGID: 7000
    - restart_policy: always
