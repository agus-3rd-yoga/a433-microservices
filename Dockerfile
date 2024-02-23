## STAGE 1
# Set base image that we want to use (customized based on source, golang is default for go source)
FROM golang:alpine as base

# Set default location app/container starting point for deployment
WORKDIR /go/src/github.com/dicodingacademy/karsajobs

# Set environment variable baked to container
ENV GO111MODULE=on
ENV APP_PORT=8080
ENV CGO_ENABLED=0

# Copies sources to working location (WORKDIR)
COPY go.mod .
COPY go.sum .

# Standard command for golang to install deps
RUN go mod download && go mod verify

# Copies fully deployed source to working location (WORKDIR)
COPY . .

# Create final binary/package from fully deployed source
RUN mkdir /build; go build -o /build/ ./...

## STAGE 2
# Set base image for web server
FROM gcr.io/distroless/static

# Copies all final binary/package to customized web server directory
COPY --from=base /build ./build

# Set port access for traffic
EXPOSE 8080

# Set default command for running web server from final binary/package directory
CMD ["/build/web"]
