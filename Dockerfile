# Sets base image that we want to use for source (customized based on sources, node is default for javascript source)
FROM node:14.21-alpine as builder

# Sets default location app/container starting point for deployment
WORKDIR /app

# Copies all source to working location (WORKDIR)
COPY package*.json ./

# Runs default command for node to install required deps
RUN npm install

# Copies fully deployed source to working location (WORKDIR)
COPY . .

# Creates final binary/package from fully deployed source
RUN npm run build

# Sets port access for traffic
EXPOSE 8000

# Runs  default command for starting app/container
CMD [ "npm", "run", "serve" ]
