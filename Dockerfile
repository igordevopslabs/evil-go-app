FROM golang:1.14.3 as builder

ENV USER=appuser
ENV UID=10001 

RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"

WORKDIR /app
COPY . /app

RUN CGO_ENABLED=1 GO111MODULES=on go build -ldflags="-s -w" .

FROM golang:1.14.3

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

WORKDIR /app
COPY --from=builder /app/evil-go-app /app

EXPOSE 8080

ENTRYPOINT ["/app/evil-go-app"]