FROM golang:alpine AS builder

WORKDIR /desafio-go/app/
COPY main.go .

RUN apk add upx

RUN go build -ldflags "-s -w" main.go && \
    upx --brute main

##

FROM busybox

WORKDIR /desafio-go/app/

COPY --from=builder /desafio-go/app/main .
ENTRYPOINT ["./main"]