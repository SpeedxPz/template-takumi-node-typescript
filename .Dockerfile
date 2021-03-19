FROM node:12.20-buster-slim as builder

# Init
RUN apt-get update
RUN apt-get install -y .gyp python make g++ bash
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --no-cache

# Build
COPY . .
RUN npm run build

# Cleanup
RUN npm prune --production
RUN rm -rf ./false
RUN rm -rf ./node_modules/node-rdkafka/.vscode
# RUN apk del .gyp python make g++ bash

FROM node:12.20-buster-slim

WORKDIR /usr/src/app
RUN dpkg --add-architecture i386
RUN apt update
run apt install -y wine wine32 wine64 libwine libwine:i386 fonts-wine
COPY --from=builder /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=builder /usr/src/app/build /usr/src/app/build
COPY ./cdb /usr/src/app/cdb

# Startup
CMD [ "node", "./build/index.js" ]
#CMD ["node"]