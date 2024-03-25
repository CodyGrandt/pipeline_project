# 1) Installs dependencies and builds the app in a build enviroment.
FROM ubuntu:latest AS build-env
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# 2) Clones Flutter using the link.
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# 3) Sets the path of where Flutter will be located and built.
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# 4) Runs flutter doctor to ensure flutter is working properly.
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# 5) Copies the files to the container and instructs flutter to build the container.
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get
RUN flutter build web

# 6) Creates the runtime image.
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html