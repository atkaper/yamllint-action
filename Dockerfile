FROM python:3.9.7-alpine

RUN apk add --update --no-cache ca-certificates git
RUN pip install yamllint

USER 1000
WORKDIR /src

ADD entrypoint.sh /src/entrypoint.sh

ENTRYPOINT ["/src/entrypoint.sh"]

