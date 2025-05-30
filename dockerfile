FROM golang:1.24 AS build 

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=build main .

EXPOSE 8080

ENTRYPOINT ["./main"]