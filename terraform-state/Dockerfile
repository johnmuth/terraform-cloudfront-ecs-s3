FROM hashicorp/terraform:light

ARG aws_access_key_id
ENV AWS_ACCESS_KEY_ID=$aws_access_key_id
ARG aws_secret_access_key
ENV AWS_SECRET_ACCESS_KEY=$aws_secret_access_key

WORKDIR /app
COPY . /app
RUN ["terraform", "init"]
CMD [ "apply"]
