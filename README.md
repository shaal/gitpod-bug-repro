# gitpod-bug-repro
This is a demonstration repo for reproducing https://github.com/gitpod-io/gitpod/issues/3174

The image is already pushed, so you don't even have to build it.

To demonstrate the bug, 

1. Enable [feature preview](https://gitpod.io/settings)
2. Open this repository with https://gitpod.io/#https://github.com/rfay/gitpod-bug-repro
3. `sudo docker-up`
4. In another terminal, `docker run -it --rm randyfay/gitpod-bug-repro ls -lR /var/tmp`. You'll see 
```
$ docker run -it --rm randyfay/gitpod-bug-repro:latest ls -lR /var/tmp
/var/tmp:
total 8
drwxrwxrwx 2 www-data root 4096 Feb 17 21:08 dir-with-perms
drwxr-xr-x 2 root     root 4096 Feb 17 21:08 filebits

/var/tmp/dir-with-perms:
total 0

/var/tmp/filebits:
total 0
-rwsr-xr-x 1 root root 0 Feb 17 21:08 setuid
---------- 1 root root 0 Feb 17 21:08 zeroes
```
5. Now stop the gitpod workspace and then start it again.
6. `docker run -it --rm randyfay/gitpod-bug-repro` now shows completely different permissions and ownership: