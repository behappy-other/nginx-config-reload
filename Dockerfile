FROM golang:1.21.3 as build
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GOPROXY=https://goproxy.cn,direct
WORKDIR /go/src/app
COPY . .
RUN go build -a -o nginx-reloader .

FROM nginx:1.25.3
COPY --from=build /go/src/app/nginx-reloader /nginx-reloader
CMD ["/nginx-reloader"]
