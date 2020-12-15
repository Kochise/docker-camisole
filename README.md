# docker-camisole
Docker for `camisole`

`camisole` is a compiler isolation framework that allows sandboxed compilation of various programming languages.

Source : https://github.com/Kochise/docker-camisole

## installation

Install `docker` :

```bash
docker pull library/debian:buster-slim
docker build . --network host -t camisole
```

Typical download/docker size is 3.7 GB.

## usage

Run the `docker` :

```bash
docker run --network host -it --rm --privileged --detach camisole
```

Test `camisole` :

```bash
curl http://localhost:42920/run -d '{"lang": "python", "source": "print(42)"}'
```

## greetings

Based on https://github.com/prologin/camisole<br>
