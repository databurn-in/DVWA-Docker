# DVWA Docker

The problem with other dockerized [DVWA](https://github.com/digininja/DVWA) projects is that the MariaDB is not exposed to the host. So, it can't be connected through a database client from host to play around with the DVWA database directly. 

This projects downloads the latest DVWA project while building the image and the DB can be connect from the host machine directly.

## How to use

 - Clone this repo and `cd` into it.
 - To build the image:
```bash
docker build -t dvwa-docker . 
```
 - To run the container:
```bash
docker run -it -p 80:80 -p 3306:3306 dvwa-docker
```
That's it!

## Credentials

 - For logging in into DVWA web app

**username**: admin

**password**: password

 - To connect to the MariaDB database (from host machine):

**server host**: localhost

**server port**: 3306 (depends on how you map this in `docker run`)

**database**: dvwa

**username**: dvwa

**password**: p@ssw0rd

Enjoy!

## License
MIT

