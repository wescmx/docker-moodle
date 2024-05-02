### Minimal docker configuration to run Moodle

### Installation guide

```sh
$ git clone git@github.com:wescmx/docker-moodle.git

$ cd docker-moodle

$ docker-compose up -d
```

### Getting started

```sh
$ git clone https://github.com/moodle/moodle.git src/.

$ git checkout MOODLE_401_STABLE
```

Access the application at: `127.0.0.1`

### Executing commands

```sh
$ docker-compose run --rm composer --version

$ docker-compose run --rm php -v

$ docker-compose run --rm npm -v
```

### Moodle data directory

```sh
/mnt/moodledata/moodle
```

This can be changed here: [apache.dockerfile](./.docker/apache/apache.dockerfile)

```sh
# Create the moodledata directory
RUN mkdir -p /mnt/moodledata/moodle \
    && chown -R www-data:www-data /mnt/moodledata/moodle \
    && chmod -R 777 /mnt/moodledata/moodle
```
