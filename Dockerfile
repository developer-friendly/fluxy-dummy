FROM golang:1.24 AS builder

WORKDIR /app

ENV GO111MODULE=on \
    CGO_ENABLED=0

COPY . .

RUN go mod tidy && go build -o fluxy-dummy

FROM scratch AS final

ENV GIN_MODE=release

COPY --from=builder /app/fluxy-dummy /fluxy-dummy

ENTRYPOINT ["/fluxy-dummy"]
