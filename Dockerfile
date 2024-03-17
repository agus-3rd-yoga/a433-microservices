FROM node:alpine
WORKDIR /app
COPY . .
ENV NODE_ENV=production DB_HOST=item-db
RUN npm install && npm run build
EXPOSE 8080/tcp
ENTRYPOINT [ "npm", "start" ]