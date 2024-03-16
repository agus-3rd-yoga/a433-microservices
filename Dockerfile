#FROM node:16.17.0-alpine as builder
#FROM node:alpine as builder
#WORKDIR /app
#COPY ./package.json .
#COPY ./yarn.lock .
#RUN yarn install
#COPY . .
#ARG TMDB_V3_API_KEY
#ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
#ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
#RUN yarn build
#RUN yarn run dev

#FROM nginx:stable-alpine
#WORKDIR /usr/share/nginx/html
#RUN rm -rf ./*
#COPY --from=builder /app .
#EXPOSE 80
#CMD ["yarn","run","dev"]
#ENTRYPOINT ["nginx", "-g", "daemon off;"]

FROM node:alpine AS builder
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
EXPOSE 3000
CMD ["yarn", "run", "dev"]