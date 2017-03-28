docker-s3fs
===========

**[S3fs][s3fs]** docker build for version 1.80. 

This requires Docker engine >= 1.10.


Example `docker-compose.yml`:

```yaml
---
version: "2"
services:
  s3fs:
    image: "camptocamp/s3fs"
    cap_add:
      - SYS_ADMIN
      - MKNOD
    privileged: true
    devices:
      - "/dev/fuse"
    environment:
      BUCKETNAME: "<YOUR_BUCKET>"
      AWSACCESSKEYID: "<YOUR_ACCESS_KEY>"
      AWSSECRETACCESSKEY: "<YOUR_PRIVATE_KEY>"
    volumes:
      - "/var/lib/s3fs/mytest:/home/shared/s3:shared"
    tty: true
  
  web:
    image: nginx
    ports:
      - 8080:80
    volumes:
      - "/var/lib/s3fs/mytest:/usr/share/nginx/html:shared,ro"
```
