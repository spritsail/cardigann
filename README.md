[hub]: https://hub.docker.com/r/spritsail/cardigann
[git]: https://github.com/spritsail/cardigann
[drone]: https://drone.spritsail.io/spritsail/cardigann
[mbdg]: https://microbadger.com/images/spritsail/cardigann

# [Spritsail/Cardigann][hub]
[![Layers](https://images.microbadger.com/badges/image/spritsail/cardigann.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/spritsail/cardigann.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/spritsail/cardigann.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/spritsail/cardigann.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/spritsail/cardigann.svg)][hub]
[![Build Status](https://drone.spritsail.io/api/badges/spritsail/cardigann/status.svg)][drone]

A server for adding extra indexers to Sonarr, SickRage and CouchPotato via [Torznab](https://github.com/Sonarr/Sonarr/wiki/Implementing-a-Torznab-indexer) and [TorrentPotato](https://github.com/CouchPotato/CouchPotatoServer/wiki/Couchpotato-torrent-provider) proxies. Behind the scenes Cardigann logs in and runs searches and then transforms the results into a compatible format.

This image uses a user with UID 913. Make sure this user has write access to the `/config` folder.

## Example Run Command

```bash
docker run -d --restart=on-error:10 --name cardigann -v /host/path/to/config:/config -p 5076:5076 spritsail/cardigann
```
