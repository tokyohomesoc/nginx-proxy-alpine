# nginx-proxy-alpine [![Build Status](https://travis-ci.org/tokyohomesoc/nginx-proxy-alpine.svg?branch=master)](https://travis-ci.org/tokyohomesoc/nginx-proxy-alpine)

# HOU TO
```yaml
version: '2'
services: 
  nginx-proxy-alpine:
      image: tokyohomesoc/nginx-proxy-alpine
      container_name: nginx-proxy-alpine
      restart: always
      hostname: nginx-proxy-alpine
      ports:
      -  "80:80"
      - "443:443"
      volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - /home/rancher/nginx/certs:/etc/nginx/certs:ro
      - /home/rancher/nginx/conf.d:/etc/nginx/conf.d
      - /home/rancher/nginx/vhost.d:/etc/nginx/vhost.d
      - /home/rancher/nginx/html:/usr/share/nginx/html
  docker-gen:
    image: jwilder/docker-gen
    container_name: docker-gen
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
    volumes_from: 
      - nginx-proxy-alpine
    command: ["-notify-sighup", "nginx-proxy-alpine", "-watch", "-wait", "5s:30s", "/app/nginx.tmpl", "/etc/nginx/conf.d/default.conf"]
```
## LICENSE

```
MIT License

Copyright (c) 2016-2017 Tokyo Home Security Operation Center

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```