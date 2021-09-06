# chips-apache
Docker build for chips-apache image


This build extends the ch-apache image to add the CHIPS application static content (images, css, javascript and letter templates etc).

The chips-apache container is designed to direct application traffic to the WebLogic managed server instances and administration console traffic to the WebLogic administration server.  It expects that the requests received by the container are HTTP, but were originally sent by the client browser as HTTPS, with the SSL terminated at a load balancer before the traffic is received by the container.  Therefore, this container can only be used with a load balancer (an AWS Application Load Balancer in our case).

Apache is configured to listen on port 80 for application traffic and port 81 for administration console traffic.

### Building the image

The build requires that a standard CHIPS apache content release tar (e.g. apache-#.#.#-rc#.tar) is placed in the root folder of the repo.  Then, to build the image, run:

```
docker build -t chips-apache .
```
