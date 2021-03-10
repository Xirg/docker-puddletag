# docker-puddletag
puddletag based on linuxservers baseimage-guacgui


# Docker compose example
```yml
---
version: "2"
services:
  puddletag:
    image: Xirg/docker-puddletag
    container_name: puddletag
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - APPNAME=puddletag
      - GUAC_USER=abc #optional
      - GUAC_PASS=5f4dcc3b5aa765d61d8327deb882cf99
      - UMASK_SET=022 #optional
      - $CLI_ARGS= #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 8080:8080
      - 3389:3389
    restart: unless-stopped
```