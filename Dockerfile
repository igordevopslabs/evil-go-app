FROM golang:1.14.3 as builder

WORKDIR /app
COPY . /app

RUN CGO_ENABLED=1 GO111MODULES=on go build -ldflags="-s -w" .

FROM gcr.io/distroless/base

WORKDIR /app
COPY --from=builder /app/evil-go-app /app

EXPOSE 8080

ENTRYPOINT ["/app/evil-go-app"]