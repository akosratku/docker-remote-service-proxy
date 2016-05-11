## What is this?

Docker container for seamless integration of remote services, short name: `drsp`.

## Usage

##### Starting a container that will serve `http://example.org` on port 7500

`docker run --name=proxy -d -p 7500:7500 akosratku/drsp 7500=http://example.org`


##### Starting a container that will serve localhost:8080 on port 8080 and `http://example.org` on port 6000

Note: `--add-host` below adds the current ip of en0 as localhost to the proxy container. This snippet is OSX specific if you are on any other OS change `$(ipconfig getifaddr en0)` to obtain the ip address.

`docker run --add-host=localhost:$(ipconfig getifaddr en0) -p 7500:7500 -p 6000:6000 -d akosratku/drsp 7500=http://localhost:8080 6000=http://example.org`


### Docker compose

```
proxy:
  image: akosratku/drsp
  command: 7500=http://localhost:8080
  extra_hosts:
    - "localhost:192.168.0.1"
  ports:
    - "7500:7500"
```

#### Development with `drsp`

You can switch any service in your `docker-compose.yml` to drsp so you can debug and develop more easily. Create a `docker-compose.override.yml` file and overwrite the service you wish to serve from outside of `docker-compose` (e.g. from your IDE).

## Debug

`drsp` is using nginx for proxying. After start if you inspect the container with `docker logs <CONTAINER_ID>` you will see the generated `nginx.conf`.
