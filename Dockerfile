# Set base image that we want to use for source (customized based on source, node is default for javascript source)
FROM node:alpine AS builder

# Set default location app/container starting point for deployment
WORKDIR /app

# Copies all source to working location (WORKDIR)
COPY package*.json ./

# Standard command for node to install deps
RUN npm install

# Copies fully deployed source to working location (WORKDIR)
COPY . .

# Set port access for traffic
EXPOSE 3001

# Set default command to running web server
CMD ["node", "index.js"]