# EMAN2 on a OSX docker
WHAT IS THIS : 
A CentOS 7 docker able to run eman2.  
Features:  
- CentOS 7 Docker Container 
- Miniconda3-4.6.14
- eman2

We start with a clean OSX 10.15.3 (Catalina).

To download docker for mac, follow the instructions (https://docs.docker.com/docker-for-mac/install/).   

## Installing the eman2-mac docker

- Choose a folder where the docker will lay.  
- Download the docker (copy this on your terminal).  
``git clone https://github.com/jucastil/eman2-mac.git``  
- Go into the docker folder **eman2-mac**.  
- Run the installation script. 
``./start-eman2-docker.sh``.\.   
This will take some time, so go for a coffe :-)

At the end, you should get the *e2display.py* windown

## Gettin in the docker

Let's say your computer is called **MyMacBook**.  
Then your docker should be called **MiMacBookeman2**.  
To access inside, type something like this:
`` docker exec -it MyMacBookeman2 /bin/bash.``.  
(the word after "it" is the name of the docker).  
You should get a shell that is inside the container.   
On *extra* you have a script to start the conda environment. Run it.    
``extra/start-e2display.sh``
