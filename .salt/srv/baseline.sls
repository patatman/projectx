create-user-openfloxr:
  user.present:
    - name: openfloxr
    - uid: 7000
    - fullname: OpenFloxr PowerUser

create-directory-structure:
  file.directory:
    - user: openfloxr
    - mode: 750
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - names:
      - /data/docker
      - /data/media/tv
      - /data/media/movies
      - /data/media/music
      - /data/media/comics
      - /data/downloads/complete
      - /data/downloads/incomplete
      - /data/downloads/torrents
      - /data/downloads/torrents/watch
