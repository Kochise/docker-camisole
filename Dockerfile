FROM debian:buster-slim

MAINTAINER David KOCH
# https://docs.docker.com/engine/reference/builder/

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker
ENV TZ=UTC

SHELL ["/bin/bash", "-c", "-l"]
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#COPY userconf.sh /usr/local/bin/userconf.sh
#COPY start.sh /usr/local/bin/start.sh
COPY . /app
WORKDIR /app

RUN	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
&&	useradd -rm -d /home/mcmurphy -s /bin/bash -g root -G sudo -u 1001 mcmurphy \
&&	usermod -aG root mcmurphy \
&&	/bin/bash install_root.sh \
&&	echo Done as root...

# Set container to unicode (important for Java)
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Allows access to config files (important for Haskell and Pascal)
ENV CAMISOLE_CONF=debian.yml

USER mcmurphy

RUN	/bin/bash install_user.sh \
&&	echo Done as user...

EXPOSE 42920

STOPSIGNAL SIGRTMIN+3

ENTRYPOINT ["camisole", "serve"]
#ENTRYPOINT ["python3", "-m camisole serve"]
#ENTRYPOINT ["/bin/bash", "-c"]

#CMD ["/bin/bash", "/usr/local/bin/start.sh"]

# --- bash help ----------------------------------------------------------------

# Creating the container
#sudo docker pull library/debian:buster-slim
#sudo docker build . --network host -t camisole

# Running the container
#sudo docker run --network host -it --rm --privileged --detach camisole
#sudo docker run --network host -it --rm --privileged --entrypoint bash camisole
#sudo docker run --network host -it --rm --privileged --entrypoint bash -u 0 camisole pwck

# Testing the container
#curl http://localhost:42920/run -d '{"lang": "python", "source": "print(42)"}'
#curl --url http://localhost:42920/run --data '{"lang": "python", "source": "print(42)"}' --request POST --header 'content-type: application/json'
#curl http://localhost:42920/run -d '{"lang": "C", "source": "#include <stdio.h>\n int main() { printf(\"Hello World\"); return 0; }"}'
#curl http://localhost:42920/run -d '{"lang": "lua", "source": "print(\"Hello World\")"}'

#http POST localhost:42920/run lang=python tests:='[{"stdin": "foo"}]' source=@script.py

# Deleting the container
#sudo docker stop camisole
#sudo docker rm camisole

#sudo docker stop $(docker ps -aq)
#sudo docker rm $(docker ps -aq)

#sudo docker container prune
#sudo docker image prune
#sudo docker system prune

#sudo docker image ls
#sudo docker image rm ${HASH}
#sudo docker image prune
