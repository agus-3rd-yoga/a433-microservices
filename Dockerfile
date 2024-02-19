#FROM node:14.21-alpine as builder
#WORKDIR /app
#COPY package*.json ./
#RUN npm install
#COPY . .
#RUN npm run build
#EXPOSE 8000
#CMD [ "npm", "run", "serve" ]


## Make final image size smaller
# STAGE 1

FROM node:14-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . /app

RUN npm run build

RUN ls -lah /app

# STAGE 2

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"] 
