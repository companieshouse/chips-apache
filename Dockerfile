FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-serverjre:1.0.0 as builder

COPY apache*.tar .

RUN tar -xvf apache*.tar

FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-apache:1.1.0

# Add section of Apache config for the CHIPS app
COPY chips-http.conf conf

# Include the new config in the main config file
RUN echo "Include conf/chips-http.conf" >> conf/httpd.conf

# Copy over static content from the builder image
COPY --from=builder apache htdocs/chips/
