FROM golang:1-alpine as builder
RUN apk update && apk add make
WORKDIR /build
ADD . .
RUN make build

FROM alpine
COPY --from=builder /build/chatgpt-telegram /bin/chatgpt-telegram
RUN chmod +x /bin/chatgpt-telegram
RUN mkdir /root/.config/
RUN touch /root/.config/chatgpt.json
RUN chmod +x /root/.config
ENTRYPOINT ["/bin/chatgpt-telegram"]
