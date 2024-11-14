# Test your bash script using chroot and docker container

This project use docker to create `chroot` env for test your `bash` scripts.

## Usage

Place rout script in `scripts` folder for example `my_test.sh` and put content for exmaple:

```shell
#!/bin/bash

echo "My script works!"
```
then run docker:

```shell
docker compose up --build
```

Explanation.

In `compsoe.yaml` is volume mounted `./scripts:/home/tester/test_root/scripts` and as `command` is provided script name `my_test.sh`.

Docker container by dfault run entry point that run chroot and as command put `test.sh` script from `.docket/box/` directory.

