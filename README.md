# gitpod-bug-repro
This is a demonstration repo for reproducing https://github.com/gitpod-io/gitpod/issues/3174

The image is already pushed, so you don't even have to build it.

To demonstrate the bug, 

1. Enable [feature preview](https://gitpod.io/settings)
2. Open this repository with https://gitpod.io/#https://github.com/rfay/gitpod-bug-repro
3. `sudo docker-up`
4. In another terminal, `docker run -it --rm randyfay/gitpod-bug-repro ls -lR /var/tmp`. You'll see 
```
$ docker run -it --rm randyfay/gitpod-bug-repro ls -lR /var/tmp
/var/tmp:
total 8
drwxrwxrwx 2 www-data root 4096 Feb 17 21:16 dir-with-perms
drwxr-xr-x 2 root     root 4096 Feb 17 21:28 filebits

/var/tmp/dir-with-perms:
total 0

/var/tmp/filebits:
total 0
-rwsr-xr-x 1 root root 0 Feb 17 21:28 setuid
-rwxrwxrwx 1 root root 0 Feb 17 21:28 sevens
---------- 1 root root 0 Feb 17 21:28 zeroes
```
5. Now stop the gitpod workspace and then start it again.
6. `sudo docker-up`
7. `docker run -it --rm randyfay/gitpod-bug-repro ls -lR /var/tmp` now shows completely different permissions and ownership:
```bash
$ docker run -it --rm randyfay/gitpod-bug-repro ls -lR /var/tmp
/var/tmp:
total 8
drwxr-xr-x 2 www-data root 4096 Feb 17 21:16 dir-with-perms
drwxr-xr-x 2 root     root 4096 Feb 17 21:28 filebits

/var/tmp/dir-with-perms:
total 0

/var/tmp/filebits:
total 0
-rwxr-xr-x 1 root root 0 Feb 17 21:28 setuid
-rwxr-xr-x 1 root root 0 Feb 17 21:28 sevens
---------- 1 root root 0 Feb 17 21:28 zeroes
```

You'll note that 
* /var/tmp/dir-with-perms was 777, now it's 755
* /var/tmp/filebits/setuid has lost its setuid bit
* /var/tmp/filebits/sevens has lost its 777 and gone to 755

Interestingly though, /var/tmp/filebits/zeroes still has its 000 perms. 

There may be other instances of permissions loss. It's not clear to me why the directory permissions are mucked with, but the some file perms don't seem to be.

As I guess we should expect, this can be worked around by deleting the image and re-pulling it. 
`docker rmi randyfay/gitpod-bug-repro:latest && docker pull randyfay/gitpod-bug-repro:latest` will restore the correct filesystem and behavior.