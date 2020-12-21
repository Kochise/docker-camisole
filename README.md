# docker-camisole
Docker for `camisole`

`camisole` is a compiler isolation framework that allows sandboxed compilation of various programming languages.

Source : https://github.com/Kochise/docker-camisole

![docker-camisole](https://raw.githubusercontent.com/Kochise/docker-camisole/main/docker-camisole_200.gif?raw=true)

## installation

Install `docker` :

```bash
apt-get install -y docker
```

Compile the `image` :

```bash
docker pull library/debian:buster-slim
docker build . --network host -t camisole
```

Typical download/image size is 3.7 GB.

## usage

Run the `container` :

```bash
docker run --network host -it --rm --privileged --detach camisole
```

Test `camisole` :

```bash
curl http://localhost:42920/run -d '{"lang": "python", "source": "print(42)"}'

curl http://localhost:42920/run -d '{"lang": "C", "source": "#include <stdio.h>\n int main() { printf(\"Hello World\"); return 0; }"}'

curl http://localhost:42920/run -d '{"lang": "lua", "source": "print(\"Hello World\")"}'
```

## greetings

Based on https://github.com/prologin/camisole<br>
