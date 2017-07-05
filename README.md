# devdocker
Dev Env in docker

Software installed in docker read only, code and settings(dot files) store as volumes, changable.

Use a Dockerfile to create docker with software installed
Use a docker compose to set hostname, expose ports, and add volumes.

## Contents
### fedora
[fedora](https://getfedora.org/)

I use the `rawhide`, It has pretty new software in repo, it is good for create a docker

### mosh
[mosh](https://mosh.org/)
[github](https://github.com/mobile-shell/mosh)

It help me auto connect to my dev env everytime when I got back to internet.

### emacs
[emacs](https://www.gnu.org/software/emacs/)

The world's best editor

### go 1.8
[golang](https://golang.org)
[github](https://github.com/golang/go)

My life support...

# Usage

```
# build the image
docker-compose build
# startup
docker-compose up -d
# connect to it
mosh root@ip --ssh="ssh -p 2413" -p 60020:60030'
```

I alias the mosh command, as I may use it many times:

```
dev='mosh root@ip --ssh="ssh -p 2413" -p 60020:60030'
```