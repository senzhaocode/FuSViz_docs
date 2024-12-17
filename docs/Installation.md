## Installation

### Prerequisite for FuSViz running

A minimum of **4GB** physical memory is required for running *FuSViz* in user's machine (we recommend physical memory **>= 8GB**). NOTE: insufficient memory allocation can result in a slow response, the screen hanging on, or even a software crash.

### Deploy with docker/podman

#### Install Docker/Podman engine in your OS platform

+ Install [Docker on Linux](https://docs.docker.com/engine/installation/linux/)
+ Install [Docker on MacOS](https://docs.docker.com/engine/installation/mac/)
+ Install [Docker on Windows](https://docs.docker.com/docker-for-windows/) (NOTE: We have not yet done enough testing on the Windows platform, so we would like to recieve more feedback on it)

#### Pull pre-built FuSViz image (release version) from docker hub

Run `docker pull --platform=linux/amd64 senzhao/fusviz_shiny_app:1.8.0`, then check the image by typing `docker images`

Optional: if user would like to build image (developmental version), download soruce code and change to directory `cd ~/FuSViz-master`; run `docker build --platform=linux/amd64 --rm -t senzhao/fusviz_shiny_app:latest -f Dockerfile .`.

#### Launch FuSViz app

Run `docker run --platform=linux/amd64 --rm -p 4000:3838 senzhao/fusviz_shiny_app:1.8.0`; then open web browser and input address `127.0.0.1:4000`. If TCP port 4000 on `127.0.0.1` of the host is occupied, users can use other port values to bind port 3838 of the container.

NOTE: the following browsers have been tested and are supported well

+ Safari (version >= 14.0)
+ Mozilla Firefox (version >= 83.0)
+ Google Chrome (version >= 87.0.4280.67 official build x86_64)
+ Microsoft Edge (version >= 90)

### Deploy with singularity/apptainer for linux distribution

A apptainer/singularity container of *FuSViz* is available for [dowload](https://fusviz.s3.eu-north-1.amazonaws.com/fusviz_v1.8.0.sif), and we recommend run it using singularity version (>= 3.7.3):

`singularity run fusviz_v1.8.0.sif 4000`, then open web browser and input address.

NOTE: the *FuSViz* apptainer/singularity container is specific for running under **Linux OS (e.g. Debian, Ubuntu, Redhat and CentOS)**, which is incompatible with **Apple M1/M2 machine**. Users have to use the **Docker/Podman** container to run *FuSViz* under Mac OS.

### Deploy without container

#### Requirement

*FuSViz* is a shiny app and requires R working environment:

+ __R (>=4.0.0)__: https://www.r-project.org/; [RStudio](https://rstudio.com/products/rstudio/download/#download) is recommended but not mandatory. 
+ For windows users, if an earlier version of R (< 4.0) is present in the system, please uninstall it firstly and make sure only R >=4.0 is available.

#### Installation

	if (! require('remotes')) install.packages('remotes')
	remotes::install_github('senzhaocode/FuSViz')

#### IMPORTANT NOTE for Linux OS

**Some libraries need to be installed properly before setup FuSViz:**

1. Install software library [OpenSSL](https://www.openssl.org) - a dependency of R package [openssl](https://cran.r-project.org/web/packages/openssl/index.html)

	  * For **Debian or Ubuntu**: `sudo apt-get install -y libssl-dev`; For **Fedora, CentOS or RHEL**: `sudo yum install openssl-devel`
	  * If root privillege is not available, users have to download [source code](https://github.com/openssl/openssl) and install at $HOME directory. For example,
		
			./Configure --prefix=/OpenSSL_path --openssldir=/OpenSSL_path/ssl
			make && make install
			C_INCLUDE_PATH=/OpenSSL_path/include
			export C_INCLUDE_PATH
			LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/OpenSSL_path/lib
			export LD_LIBRARY_PATH
			LIBRARY_PATH=$LIBRARY_PATH:/OpenSSL_path/lib
			export LD_LIBRARY_PATH

	  * Install R package [openssl](https://cran.r-project.org/web/packages/openssl/index.html): `install.packages("openssl")`

2. Install software library [libxml2](http://xmlsoft.org) - a dependency of R package [xml2](https://cran.r-project.org/web/packages/XML/index.html)

	  * For **Debian or Ubuntu**: `sudo apt-get install libxml2-dev`; For **Fedora, CentOS or RHEL**: `sudo yum install libxml2-devel`
	  * If root privillege is not available, users have to download [source code](http://xmlsoft.org/downloads.html) and install at $HOME directory. For example,
	
			./configure --prefix=/libxml2_path 
			# if ./configure file does not exist, please run ./autogen.sh --prefix=/libxml2_path instead.
			make && make install
			C_INCLUDE_PATH=/libxml2_path/include
			export C_INCLUDE_PATH
			CPLUS_INCLUDE_PATH=/libxml2_path/include
			export CPLUS_INCLUDE_PATH
			LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/libxml2_path/lib
			export LD_LIBRARY_PATH
			LIBRARY_PATH=$LIBRARY_PATH:/libxml2_path/lib
			export LD_LIBRARY_PATH

	  * Install R package [xml2](https://cran.r-project.org/web/packages/XML/index.html): `install.packages("xml2")`

3. Install software library [libjpeg](https://ijg.org) - a dependency of R package [jpeg](https://cran.r-project.org/web/packages/jpeg/index.html)

	  * For **Debian or Ubuntu**: `sudo apt-get install libjpeg-dev`; For **Fedora, CentOS or RHEL**: `sudo yum install libjpeg-turbo-devel`
	  * If root privillege is not available, users have to download [source code](https://ijg.org) and install at $HOME directory. For example,

			./Configure --prefix=/libjpeg_path --libdir=/libjpeg_path/lib --includedir=/libjpeg_path/include
			make && make install
			C_INCLUDE_PATH=/libjpeg_path/include
			export C_INCLUDE_PATH
			LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/libjpeg_path/lib
			export LD_LIBRARY_PATH
			LIBRARY_PATH=$LIBRARY_PATH:/libjpeg_path/lib
			export LD_LIBRARY_PATH

	  * Install R package [jpeg](https://cran.r-project.org/web/packages/jpeg/index.html): `install.packages("jpeg")`

4. Install software library [libpng](https://libpng.sourceforge.io) - a dependency of R package [png](https://cran.r-project.org/web/packages/png/index.html)

	  * For **Debian or Ubuntu**: `sudo apt-get install libpng-dev`; For **Fedora, CentOS or RHEL**: `sudo yum install libpng-devel`
	  * If root privillege is not available, users have to download [source code](https://libpng.sourceforge.io) and install at $HOME directory. For example,

			./Configure --prefix=/libpng_path
			make && make install
			C_INCLUDE_PATH=/libpng_path/include
			export C_INCLUDE_PATH
			LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/libpng_path/lib
			export LD_LIBRARY_PATH
			LIBRARY_PATH=$LIBRARY_PATH:/libpng_path/lib
			export LD_LIBRARY_PATH

	  * Install R package [png](https://cran.r-project.org/web/packages/png/index.html): `install.packages("png")`

5. Install software library [libcurl](https://curl.se/libcurl/) - a dependency of R package [RCurl](https://cran.r-project.org/web/packages/RCurl/index.html)

	  * For **Debian or Ubuntu**: `sudo apt install libcurl4-openssl-dev`

#### Launch FuSViz app via localhost

	source(file.path(system.file("app", package = "FuSViz"), "global.R"), local = TRUE, chdir = TRUE)
	FuSViz_app()

### Host FuSViz on a single server

Users is able to host *FuSViz* Shiny application at server end (only linux OS distributions are supported) using Shiny Server.
Please follow the installation and adminstration of [Shiny Server](https://www.rstudio.com/products/shiny/download-server/)
