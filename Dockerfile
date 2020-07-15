FROM golang:alpine as builder
RUN mkdir /app
ADD . /app/
WORKDIR /app

# Build binary
RUN CGO_ENABLED=0 GOOS=linux go build -v -o ulmaceae

##########################################################
# build runtime image
##########################################################
FROM alpine:3.12

LABEL maintainer="Bill.Theocharoulas@ibm.com"

WORKDIR /app

COPY --from=builder /app/ulmaceae /app/

# Run app
CMD ["/app/ulmaceae"]
