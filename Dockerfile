FROM node:6.11-alpine as build

RUN apk add --no-cache nginx git python build-base curl

VOLUME ["/var/log/nginx/", "/data/avatar"]
EXPOSE 80

WORKDIR "/OJ_FE"
COPY ./package.json .
RUN npm install
COPY ./ .
RUN npm run build:dll
RUN npm run build

FROM registry.cn-hangzhou.aliyuncs.com/onlinejudge/oj_backend

COPY --from=build /OJ_FE/dist /app/dist
