FROM golang:1.14.3 as builder

#avoid root


#avoid root


WORKDIR /app
COPY . /app

RUN CGO_ENABLED=1 GO111MODULES=on go build -ldflags="-s -w" .

FROM golang:1.14.3

#avoid rootless


WORKDIR /app
COPY --from=builder /app/evil-go-app /app

EXPOSE 8080

#avoid rootless

ENTRYPOINT ["/app/evil-go-app"]