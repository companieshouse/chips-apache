FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-oraclelinux:2.0.1 AS builder

COPY apache*.tar CHIPSviewer*.tar ./

RUN tar -xvf apache*.tar && \
    tar -xvf CHIPSviewer*.tar -C apache

FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-apache:2.0.1

# Copy favicon.ico
COPY favicon.ico htdocs

# Add section of Apache config for the CHIPS app
COPY chips-http.conf conf

# Include the new config in the main config file and enable expires_module
RUN echo "Include conf/chips-http.conf" >> conf/httpd.conf && \
    sed -i 's/^#LoadModule expires_module/LoadModule expires_module/' conf/httpd.conf

# Copy over maintenance page
COPY maintenance htdocs/maintenance/

# Copy over static content from the builder image
COPY --from=builder apache htdocs/chips/
