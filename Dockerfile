## Kita akan menggunakan base image nodejs versi 14
FROM node:14-alpine

## Menentukan bahwa working directory untuk container 
WORKDIR /app

## Menyalin seluruh source code ke working directory di container
COPY . .

## Menentukan agar aplikasi berjalan dalam production mode dan menggunakan container bernama item-dbsebagai database host
ENV NODE_ENV=production DB_HOST=item-db

## Menginstal dependencies untuk production dan kemudian build aplikasi
RUN npm install --production --unsafe-perm && npm run build

## Ekspos port yang digunakan oleh aplikasi 
EXPOSE 8080/tcp

## Menjalankan container
CMD [ "npm", "start" ]