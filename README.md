# Akeneo

This project is a docker container for [Akeneo PIM](http://www.akeneo.com/what-is-a-pim/).

## Using the container

### Pulling the image from docker hub

  ```
  $ docker pull crapougnax/akeneo
  ```

### Linking the image in a Dockerfile

  ```
  FROM: crapougnax/akeneo
  ...
  ...
  ```

### Building the image

The container accepts the following environment variables
  - DB_HOST
  - DB_PORT
  - DB_NAME
  - DB_USER
  - DB_PASSWORD

  ```
  $ docker build --build-arg GH_OAUTH=<your github deployment key>  -t crapougnax/akeneo .
  ```

### Launching the container

  ```
  $ docker run -d
  -e DB_HOST=db
  -e DB_PORT=3306
  -e DB_NAME=akeneo
  -e DB_USER=root
  -e DB_PASSWORD=root
  -p 80:80
  crapougnax/akeneo
  ```

### Using with docker-compose

See my repo crapougnax/docker-pim.

### Using with kubernetes

Coming as soon as possible!

