=====
Build
=====

This section refers to the ``build`` directory which contains code and other files for building the Docker images used
to run the Agave auth infrastructure.


Building the Auth Base Images
=============================

In order to facilitate multi-purpose use, the auth base images are built with configuration file templates in the Jinja2 format. The templates
are listed and compiled at run time using a simple template compilation system provided in the image ``agaveplatform/template_compiler``. As a result,
many base images either directly or indirectly decend from this image. The Dockerfile for ``agaveplatform/template_compiler`` is contained at the root of
the ``base_images`` directory. It's image must be built first before any other images can be built.

The template system expects two special files to be loaded into the container. First is a file called ``/templates`` at the root of the container. This should be a 
text file that contains a list of file paths (relative to the container) that should be compiled. Second is a file called ``/values.yml``, also a text file at the
root of the container, that contains the key/value pairs that should be used to compile the temaples. It is a standard yaml file and as such can be commented, etc.

The various auth base images are all built using standard Dockerfiles in their respective directories within the ``base_images`` directory.

Building the Persistence Images
===============================



Building the Core Science API Images
====================================

The base core images are all built from standard Dockerfiles residing in their respective repositories on github. We refer to the documentation in the `science-apis`_.

.. _science-apis: https://github.com/agaveplatform/science-apis