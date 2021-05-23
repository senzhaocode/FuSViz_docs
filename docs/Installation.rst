Installation
------------

Prerequisites
~~~~~~~~~~~~~

FuSViz is a shiny app and requires R working environment:

-  **R (>=4.0.0)**: https://www.r-project.org/;
   `RStudio <https://rstudio.com/products/rstudio/download/#download>`__
   is recommended but not mandatory.
-  For windows users, if an earlier version of R (< 4.0) is present in
   the system, please uninstall it firstly and make sure only R >=4.0 is
   available.

Installation
~~~~~~~~~~~~

::

    if (! require('remotes')) install.packages('remotes')
    remotes::install_github('senzhaocode/FuSViz')

IMPORTANT NOTE for Linux OS
^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Some libraries need to be installed properly before setup FuSViz:**

1. Install software library `OpenSSL <https://www.openssl.org>`__ - a
   dependency of R package
   `openssl <https://cran.r-project.org/web/packages/openssl/index.html>`__

   -  For **Debian or Ubuntu**: ``sudo apt-get install -y libssl-dev``;
      For **Fedora, CentOS or RHEL**: ``sudo yum install openssl-devel``
   -  If root privillege is not available, users have to download
      `source code <https://github.com/openssl/openssl>`__ and install
      at $HOME directory. For example,

      ::

          ./Configure --prefix=/OpenSSL_path --openssldir=/OpenSSL_path/ssl
          make && make install
          C_INCLUDE_PATH=/OpenSSL_path/include
          export C_INCLUDE_PATH
          LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/OpenSSL_path/lib
          export LD_LIBRARY_PATH

   -  Install R package
      `openssl <https://cran.r-project.org/web/packages/openssl/index.html>`__:
      ``install.packages("openssl")``

2. Install software library `libxml2 <http://xmlsoft.org>`__ - a
   dependency of R package
   `xml2 <https://cran.r-project.org/web/packages/XML/index.html>`__

   -  For **Debian or Ubuntu**: ``sudo apt-get install libxml2-dev``;
      For **Fedora, CentOS or RHEL**: ``sudo yum install libxml2-devel``
   -  If root privillege is not available, users have to download
      `source code <http://xmlsoft.org/downloads.html>`__ and install at
      $HOME directory. For example,

      ::

          ./configure --prefix=/libxml2_path # if ./configure file does not exist, please run ./autogen.sh --prefix=/libxml2_path instead.
          make && make install
          C_INCLUDE_PATH=/libxml2_path/include
          export C_INCLUDE_PATH
          CPLUS_INCLUDE_PATH=/libxml2_path/include
          export CPLUS_INCLUDE_PATH
          LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/libxml2_path/lib
          export LD_LIBRARY_PATH

   -  Install R package
      `jpeg <https://cran.r-project.org/web/packages/jpeg/index.html>`__:
      ``install.packages("jpeg")``

3. Install software library `libjpeg <https://ijg.org>`__ - a dependency
   of R package
   `jpeg <https://cran.r-project.org/web/packages/jpeg/index.html>`__

   -  For **Debian or Ubuntu**: ``sudo apt-get install libjpeg-dev``;
      For **Fedora, CentOS or RHEL**:
      ``sudo yum install libjpeg-turbo-devel``
   -  If root privillege is not available, users have to download
      `source code <https://ijg.org>`__ and install at $HOME directory.
      For example,

      ::

          ./Configure --prefix=/libjpeg_path --libdir=/libjpeg_path/lib --includedir=/libjpeg_path/include
          make && make install
          C_INCLUDE_PATH=/libjpeg_path/include
          export C_INCLUDE_PATH
          LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/libjpeg_path/lib
          export LD_LIBRARY_PATH

   -  Install R package
      `jpeg <https://cran.r-project.org/web/packages/jpeg/index.html>`__:
      ``install.packages("jpeg")``

4. Install software library `libpng <https://libpng.sourceforge.io>`__ -
   a dependency of R package
   `png <https://cran.r-project.org/web/packages/png/index.html>`__

   -  For **Debian or Ubuntu**: ``sudo apt-get install libpng-dev``; For
      **Fedora, CentOS or RHEL**: ``sudo yum install libpng-devel``
   -  If root privillege is not available, users have to download
      `source code <https://libpng.sourceforge.io>`__ and install at
      $HOME directory. For example,

      ::

          ./Configure --prefix=/libpng_path
          make && make install
          C_INCLUDE_PATH=/libpng_path/include
          export C_INCLUDE_PATH
          LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/libpng_path/lib
          export LD_LIBRARY_PATH

   -  Install R package
      `png <https://cran.r-project.org/web/packages/png/index.html>`__:
      ``install.packages("png")``

5. Install software library `libcurl <https://curl.se/libcurl/>`__ - a
   dependency of R package
   `RCurl <https://cran.r-project.org/web/packages/RCurl/index.html>`__

   -  Need for **Debian or Ubuntu**:
      ``sudo apt install libcurl4-openssl-dev``

Launch FuSViz app using localhost
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    source(file.path(system.file("app", package = "FuSViz"), "global.R"), local = TRUE, chdir = TRUE)
    FuSViz_app()

**NOTE**: the following browsers have been tested and are supported well

-  Safari (version >= 14.0)
-  Mozilla Firefox (version >= 83.0)
-  Google Chrome (version >= 87.0.4280.67 official build x86\_64)
-  Windows IE (version >= 10) may work, but does not guarantee

Host on a single server (online mode)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Users could host FuSViz Shiny application at server end (only linux OS
distributions are supported) using Shiny Server. Please follow the
installation and adminstration of `Shiny
Server <https://www.rstudio.com/products/shiny/download-server/>`__

Online availability
~~~~~~~~~~~~~~~~~~~

FuSViz shiny app is free available at XXXXXXXXXXXXXX
