FROM golang:1-alpine as builder
RUN apk update && apk add make
WORKDIR /build
ADD . .
RUN make build
RUN mkdir /root/.config/
RUN touch /root/.config/chatgpt.json
FROM alpine
COPY --from=builder /build/chatgpt-telegram /bin/chatgpt-telegram
RUN chmod +x /bin/chatgpt-telegram

ENTRYPOINT ["/bin/chatgpt-telegram"]
