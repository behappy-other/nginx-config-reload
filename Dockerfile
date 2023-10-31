FROM golang:alpine3.16 as build
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
RUN mkdir -p /go/src/app
ADD main.go /go/src/app/
WORKDIR /go/src/app
RUN go build -a -o nginx-reloader .

FROM nginx:1.25.3-alpine
COPY --from=build /go/src/app/nginx-reloader /nginx-reloader
CMD ["/nginx-reloader"]
