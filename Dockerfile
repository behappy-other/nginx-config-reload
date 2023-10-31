FROM golang:1.21.3 as build
ENV GOPROXY https://goproxy.io
ENV CGO_ENABLED 0
ENV GOOS linux
RUN go get github.com/fsnotify/fsnotify
RUN go get github.com/shirou/gopsutil/process
RUN mkdir -p /go/src/app
ADD main.go /go/src/app/
WORKDIR /go/src/app
RUN go build -a -o nginx-reloader .

FROM nginx:1.25.3-alpine
COPY --from=build /go/src/app/nginx-reloader /nginx-reloader
CMD ["/nginx-reloader"]
