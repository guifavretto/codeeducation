FROM golang:alpine AS builder

WORKDIR $GOPATH/src/app
COPY go.mod ./
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -o /go/bin/docker-challenge-go .


FROM scratch
WORKDIR /app

COPY --from=builder /go/bin/docker-challenge-go .
ENTRYPOINT [ "./docker-challenge-go" ]