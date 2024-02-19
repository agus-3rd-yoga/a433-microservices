#FROM golang:1.15-alpine

#WORKDIR /go/src/github.com/dicodingacademy/karsajobs
#ENV GO111MODULE=on
#ENV APP_PORT=8080

#COPY go.mod .
#COPY go.sum .
#RUN go mod download

#COPY . .
#RUN mkdir /build; \
#    go build -o /build/ ./...

#EXPOSE 8080
#CMD ["/build/web"]

## Make image size smaller
FROM golang:1.15-alpine as base

WORKDIR /go/src/github.com/dicodingacademy/karsajobs
ENV GO111MODULE=on
ENV APP_PORT=8080

COPY go.mod .
COPY go.sum .

RUN go mod download
RUN go mod verify

RUN mkdir /build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /build .

FROM gcr.io/distroless/static

COPY --from=base /build .

EXPOSE 8080
CMD ["/build/web"]
