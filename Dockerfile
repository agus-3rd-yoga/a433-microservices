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

FROM node:alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# STAGE 2

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"] 
