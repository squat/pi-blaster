FROM alpine:3.11 as builder
RUN apk add --update build-base autoconf automake linux-headers
COPY . /pi-blaster
WORKDIR /pi-blaster
RUN ./autogen.sh
RUN ./configure
RUN make

FROM alpine:3.11
COPY --from=builder /pi-blaster/pi-blaster /usr/local/bin/pi-blaster
CMD ["/usr/local/bin/pi-blaster", "--foreground"]
