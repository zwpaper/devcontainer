# devdocker
Dev Env in docker

# Usage

```
alias devbuild="docker run -d -p 0.0.0.0:22:22 --name dodev -h dodev -v /home/paper:/data zwpaper/devdocker"
alias devstart="docker start dodev"
alias devattach="docker attach dodev"
```