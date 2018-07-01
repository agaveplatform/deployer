## Building Images

All of the Agave Platform's components run within Docker containers. The containers are all built independently with vanilla configurations and pushed into the Docker Hub public registry. This section serves as a point of reference for build instructions for the different infrastructure components.

### Auth Components


In order to facilitate multi-purpose use, the auth base images are built with configuration file templates in the Jinja2 format. The templates are listed and compiled at run time using a simple template compilation system provided in the image `agaveplatform/template_compiler`. As a result, many of the auth base images either directly or indirectly decend from this image. The Dockerfile for `agaveplatform/template_compiler` is contained within the `template_compiler` folder of the [Agave base images repository](https://github.com/agaveplatform/base-images). Its image must be built first before any other images can be built.

The template system expects two special files to be loaded into the container. First is the `/templates` file at the root of the container. This should be a text file that contains a list of file paths (relative to the container) that should be compiled. Second the `/values.yml` file, also at the root of the container, containing the key/value pairs that should be used to compile the temaples. It is a standard yaml file and as such can be commented, etc.

#### APIM
The APIM image is built from the Dockerfile in the [agaveplatform/apim](https://github.com/agaveplatform/apim) respository.

```eval_rst
.. warning:: **Note:** This is a particularly large repository due to the size of the APIM binary distribution needed to build the image.
```

#### Profiles API
The Profiles service is built from the Dockerfile in the [agaveplatform/pyprofiles-api](https://github.com/agaveplatform/pyprofiles-api) repository.

#### Clients API
The Clients service is built from the Dockerfile in the [agaveplatform/clients-api](https://github.com/agaveplatform/pyprofiles-api) repository.



### Persistence Components

The persistence images all derive from their respective trusted images within the Docker Hub Marketplace. The versions of the images in the [Agave base images repository](https://github.com/agaveplatform/base-images) have custom entrypoints added to enable configuration through consistent environment variables. The Dockerfiles for each of the persistence images is located within the respective folder within the [Agave base images repository](https://github.com/agaveplatform/base-images).

#### MySQL/MariaDB
The MySQL image is actually based on MariaDB. MariaDB is a drop-in replacement for MySQL with several attractive features around thread pooling, JSON performance, clustering, and alternative storage engines.

#### MongoDB
The MongoDB images are based on the 2.6 and 3.6 versions of the [official Mongo image](https://hub.docker.com/_/mongo/). Both version are extended to support creation of multiple databases, implicit security, and environment based account creation.

#### beanstalkd
The beanstalkd image is a stock installation of beanstalkd on Alpine linux.

#### Redis
The redis image is the default Redis image with support for password protection via environment variables.


### Science API Components

The Science APIs are implemented as a collection of polygot microservices. While each service runs independently of the others, all the services leverage a common set of libraries for connection pooling, caching, authentication, and persistence. Because of this, building individual APIs is not currently supported or recommended. Due to the complex interactions between services and contracts required for communication, the Science APIs are build, versioned, published, and deployed together from an automated build system included in the in the [Science API Github repository](https://github.com/agaveplatform/science-apis). This ensures consistency between the components and simplifies both integration and regression testing across the platform.

#### Java base image
All Java APIs run in a Tomcat 8 servlet container running Java 8. The Dockerfile adds custom libraries and configurations for log redirection, CORS, connection pooling, JCE extensions, and JMX support. Support for dynamicaly set classpath, JVM, and Tomcat environment variables are supported as well as custom debug and redirect logging options. The `agaveplatform/java-api-base` image is built from the [agaveplatform/java-api-base](https://github.com/agaveplatform/java-api-base) Github repository.

#### PHP base image
All PHP APIs are served by Apache 2.4 with PHP5.6. The Dockerfile adds support for composer, custom logging, and extensions for beanstalkd, Redis, mysqli, mongodb, etc. The `agaveplatform/php-api-base` image is built from the [agaveplatform/php-api-base](https://github.com/agaveplatform/php-api-base) Github repository.

```eval_rst
.. warning:: All PHP API will be replaced with Java implementations or updated to NGINX/PHP-FPM 7.x in the near future.
```

#### Python base image
All Python APIs extend the trusted Python 3.6 image in the Docker Hub and use the long term support version of uwsgi to expose the API via an external application server. Each Agave Python API  builds from scratch starting with the `python:3.6` image. See the Dockerfiles in the relevant API repositories for details.

