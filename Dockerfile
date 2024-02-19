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

COPY . .

RUN npm run build

# STAGE 2

FROM nginx:stable-alpine

RUN ls -lah;sleep 5

COPY --from=build /build /usr/share/nginx/html

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"] 
