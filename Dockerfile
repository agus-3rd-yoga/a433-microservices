FROM node:alpine
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install && yarn cache clean
COPY . .
EXPOSE 3000
ENTRYPOINT ["yarn", "run", "dev"]