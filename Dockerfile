## STAGE 1
# Set base image that we want to use for source (customized based on source, node is default for javascript source)
FROM node:16-alpine AS build

# Set default location app/container starting point for deployment
WORKDIR /app

# Copies all source to working location (WORKDIR)
COPY package*.json ./

# Standard command for node to install deps
RUN npm install

# Copies fully deployed source to working location (WORKDIR)
COPY . .

# Create final binary/package from fully deployed source
RUN npm run build

## STAGE 2
# Set base image for web server
FROM nginx:alpine

# Copies all final package/source to default directory service of web server
COPY --from=build /app/dist /usr/share/nginx/html

# Set port access for traffic
EXPOSE 8000

# Set default command to running web server
CMD ["nginx", "-g", "daemon off;"] 
