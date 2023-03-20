FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-serverjre:1.0.0 as builder

COPY apache*.tar CHIPSviewer*.tar ./

RUN tar -xvf apache*.tar && \
    cd apache && \
    tar -xvf ../CHIPSviewer*.tar

FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-apache:1.2.0

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
