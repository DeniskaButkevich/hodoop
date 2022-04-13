FROM ibmjava:8-sdk-alpine

# dependencies
RUN \
 apk add --no-cache nano && \
 apk add --no-cache openssh && \
 apk add --no-cache bash && \
 apk add --no-cache dos2unix && \
 # update wget for limit-rate internet
 apk update && \
 apk add wget