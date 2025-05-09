# Basic Docker Commands: A Deep Dive

Let’s start with the fundamental Docker command: docker run hello-world. This command illustrates how the Docker CLI interacts with the Docker server to retrieve the necessary image.

Here’s a breakdown of the process:

    Docker CLI: Sends a request to the Docker server to run the specified image (hello-world).
    Docker Hub: If the image is not available locally, Docker Hub (a repository of pre-made images) is queried to fetch it.
    Image Retrieval: Docker Hub provides the image, which is then used to run a container.

The image below shows how this interaction is displayed in the Docker CLI:
<img width="2524" alt="Screen Shot 2024-09-16 at 2 28 29 PM" src="https://github.com/user-attachments/assets/14fe4b02-1a00-4c53-b990-e1febc8ecd60">

One thing you might notice is that when running docker run hello-world again, you won’t see a message about “can't find the image locally.” This is because Docker caches the image after the first retrieval, so it doesn't need to fetch it from Docker Hub again.

# What is a Container?

To understand what a container is, we need to overview our system:

<img width="1775" alt="Screen Shot 2024-09-16 at 2 53 19 PM" src="https://github.com/user-attachments/assets/de2fd5b9-a0be-4c7a-b483-9101eae5408a">

The image shows a problem where we can't run Node.js because we don't have Python v3, and we can't have both Python v3 and Python v2 on the same hard drive. The solution is Namespacing.
Namespacing

<img width="1317" alt="Screen Shot 2024-09-16 at 3 04 22 PM" src="https://github.com/user-attachments/assets/e828cedf-ce1f-4532-af99-92240d1933ae">

Namespacing allows us to segment the hard drive, so the kernel can manage which version of Python to use based on the application’s request. For instance, Chrome might request Python v2, while Node.js requests Python v3.

The entire process of segmenting resources based on the process is called Namespacing and controle groups:

Controle groups: Limit amount of resources used per process.
Namespacing: Isolating resources per process (or group of processes).
     

        Namespacing : isolating resources per process (or group of process).

         ---------------                       -----------------------------------------------------
        |               |                     | Processes | Hard Drive | Network                    |
        |  Namescpacing | ------------------> |-----------------------------------------------------|
        |               |                     | Users     | Hostnames  | Iner process communication |
         ---------------                       -----------------------------------------------------

  
so now that we have a basic idea of how our system work, we can define a container as set of processes that has a grouping of ressources speceficly assigned to it

<img width="1389" alt="Screen Shot 2024-09-16 at 3 33 03 PM" src="https://github.com/user-attachments/assets/845c81ad-e8ee-4f9d-8042-304dc3fbcb30">

# Relations between images and containers :

 <img width="1339" alt="Screen Shot 2024-09-16 at 2 52 26 PM" src="https://github.com/user-attachments/assets/b4c34163-a455-40e1-a26c-a008864bda52">


 <img width="2340" alt="Screen Shot 2024-10-26 at 10 56 22 AM" src="https://github.com/user-attachments/assets/c2911b8f-4d70-4955-b833-dc5e148cad8a">

image : FS Snapshot, (a copy paste of a very specific of directories or files, so as the image shows we might have an image that contains just chrome and Python with a specific starting command)

   so here is what happens when we take an image and turn it into a container, first off the kernel will isolate a little section of the hard drive and make it avaliable to just this conatiner, then the File snapshot inside this image will be taken and placed whit in that little segment of the harddrive, Finally when we execute the starting command (Run Chrome), the n chrome is invoked and we create a an instance of that process that will be isolated into that set of resources inside the comntainer
<img width="857" alt="Screen Shot 2024-10-26 at 11 04 22 AM" src="https://github.com/user-attachments/assets/d11e4574-d546-4d87-b7b1-06a95b3cff38">

# How's Docker running on your Computer ?
 
<img width="1465" alt="Screen Shot 2024-10-26 at 11 16 16 AM" src="https://github.com/user-attachments/assets/ffc06fa3-966a-4746-bc38-1c5fb6997e8b">

Those important 2 freatures that I lastly meantioned are unfortunatly not avaliable at every operating system, indeed they are specific to the Linux Operating system

 When we installed Docker in Mac, we Installed a Linux Virtual Machine, so as long as Docker is running, we technicly have Linux VM running. So inside that linux VM we will have our containers running, and with that Linux kernel that will be in charge of isolating access and limiting access to different hardware resources on that computer  
<img width="945" alt="Screen Shot 2024-10-26 at 11 21 29 AM" src="https://github.com/user-attachments/assets/809345cd-7a77-4a16-9941-8b9c5f46a761">

   And we will notice that in the OS entry by running
   
            $- docker version
<img width="579" alt="Screen Shot 2024-10-26 at 11 29 14 AM" src="https://github.com/user-attachments/assets/a62f0de3-2cde-4839-8bbf-2ad75c498970">

# Overriding Default commands ?

<img width="1653" alt="Screen Shot 2024-10-26 at 11 54 06 AM" src="https://github.com/user-attachments/assets/1997372e-8c84-4d15-a917-9bea81e80d38">

       docker run busybox ls
   <img width="579" alt="Screen Shot 2024-10-26 at 11 57 16 AM" src="https://github.com/user-attachments/assets/cc2c214b-6870-48cf-a533-be7314e7073d">

       docker run hello-world ls
   <img width="579" alt="Screen Shot 2024-10-26 at 11 59 02 AM" src="https://github.com/user-attachments/assets/0abb0a3b-34d8-42fa-b697-ec8989dfb783">

<img width="1732" alt="Screen Shot 2024-10-26 at 12 00 32 PM" src="https://github.com/user-attachments/assets/9bbd3e57-cbfa-4514-844d-8a14cb4b0f39">
   So basicly it works with busybox image because it contains the foundational elements of a Unix-like filesystem as a FS Snapshot. Unlike Hello-world which has only one file program that print this msg :

                ```Hello from Docker!
                    This message shows that your installation appears to be working correctly.

                    To generate this message, Docker took the following steps:
                    1. The Docker client contacted the Docker daemon.
                    2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
                        (amd64)
                    3. The Docker daemon created a new container from that image which runs the
                        executable that produces the output you are currently reading.
                    4. The Docker daemon streamed that output to the Docker client, which sent it
                        to your terminal.

                    To try something more ambitious, you can run an Ubuntu container with:
                    $ docker run -it ubuntu bash

                    Share images, automate workflows, and more with a free Docker ID:
                     https://hub.docker.com/

                    For more examples and ideas, visit:
                     https://docs.docker.com/get-started/


# Conatiner life cycle :
    
<img width="1354" alt="Screen Shot 2024-10-26 at 12 29 17 PM" src="https://github.com/user-attachments/assets/7e83a735-682f-43bb-9040-d5ea15ea1e1f">
And here is the difference between both of create and start :
<img width="1425" alt="Screen Shot 2024-10-26 at 12 30 27 PM" src="https://github.com/user-attachments/assets/96bf32ac-e501-40e3-9e3f-3af38b117954">
    
   . Creating a Container :
 Creating a container is taking the FS Snapshot of the image and kind of prop it to be used to create  the conatiner (still yet no process is running) ;)
<img width="1567" alt="Screen Shot 2024-10-26 at 12 32 06 PM" src="https://github.com/user-attachments/assets/8e51911f-d188-471d-a02d-2b18eb9d9db7">
    
   . Starting a Container :
 Starting a container is executing the starting command that might be running the process Hello-World.
<img width="2324" alt="Screen Shot 2024-10-26 at 12 38 50 PM" src="https://github.com/user-attachments/assets/73b2d812-3afb-47bc-a0ef-2d65410bc248">


   . Creating and Starting a container:
<img width="850" alt="Screen Shot 2024-10-26 at 12 42 55 PM" src="https://github.com/user-attachments/assets/3a34bce1-93bb-434f-8882-a33b1eb1b2ea">

   You might notice that I added "-a" after "start", So "-a" makes docker watch for the output form the container and print it on my terminal !!

   . Here's a list of commands for this chapter that musst be helpful

    $- docker ps : list all running containers
    $- docker ps --all: list all conatiners that they've been running on your computer(started or paused) and not deleted yet
    $- docker system prune : Remove All stopped conatiners, all build cache, all networks not used by atleast one container, all dangling images

   !!! Once overriding a container, start in it will always execute that overided command 

   . "docker start <container id>" a real world senario:
       imagine starting a container that takes a lot of time to load, by the time it should load you notice that nothing is printed. You'll stop the container and start it again whith -a, bu here commes a best alternative

        docker logs <container id>
        Thank me later ;)

   . Here's a full example:
   
 <img width="810" alt="Screen Shot 2024-10-26 at 3 32 04 PM" src="https://github.com/user-attachments/assets/983bb228-5379-47a0-8baf-a21f7528aaa1">

   . Stopping or Killing a Container:

       stop a container:    docker stop <Container id>
       kill a container:    docker kill <Container id>

   When stopping a conatiner a hardware signal is sent to that primary process running on that container.
    in case of "Docker Stop", we're sending a SIGTERM signal
   we use docker stop when we want to stop a container and give it time to shut it self down and do some clean up (like saving some file, etc)
    
   <img width="1529" alt="Screen Shot 2024-10-26 at 3 45 06 PM" src="https://github.com/user-attachments/assets/a11eac50-0591-455b-8311-77bbbda9dc6e">


   When Killing a container a hardware signal is sent to that primary process running omn that container.
    in case of "Docker kill", we're sending a SIGKILL signal
   We use docker kill when we want shut down immidiatly, and it get not to do any additional work
   
   <img width="1412" alt="Screen Shot 2024-10-26 at 3 53 31 PM" src="https://github.com/user-attachments/assets/cf6aad0e-9f8d-40b8-b2fd-705b5867e64d">

        One Important note is When execute Docker stop <Container id>, if the container doesn't stop in 10 seconds, Docker Automaticly send a kill signal to that specific container

# Multy Commands Container:

   First, we run a container using 'docker run redis'. When we try to use the Redis CLI, we realize that the container is already running the Redis server as its default command. Therefore, we need to specify redis-cli as an additional command so it becomes as the image shows.
   
   <img width="871" alt="Screen Shot 2024-10-26 at 4 30 29 PM" src="https://github.com/user-attachments/assets/2af1d85e-5daf-4f1f-98d4-d1068571ad75">

   . The command :

          | Reference to docker client
           ---------------------------
             / \
              |
              |  | Run another command
              |   --------------------
              |    / \
              |     |
              |     |  | Allow us to provide input to the container
              |     |   -------------------------------------------
              |     |  / \
              |     |   |
              |     |   |  
              |     |   |  | Id of a Container
              |     |   |   ---------------------
              |     |   |      / \
              |     |   |       |
              |     |   |       |        | Additional command
              |     |   |       |         -------------------
              |     |   |       |           / \
                                             |
           docker exec -it <container id> <command>


# Building a Docker Image:
<img width="1817" alt="Screen Shot 2024-10-27 at 10 11 21 AM" src="https://github.com/user-attachments/assets/adab168c-017b-4c2d-8261-c096ba0ee037">
First thing off, we start by writing a Dockerfile which is a configuration to define how our container should behave, then we pass it to the Docker cli which it's job to pass it to the docker server which will check every line of configuration of that Dockerfile and build a usable docker image

   . Steps to rwite a docker file

               Creating a Dockerfile
          |   -------------------------------
          |  | Specify a base image          |
          |   -------------------------------
          |  | Run some commands to install  |
          |  | additional programs           |
          |    ------------------------------
          |  | Specify some commands to run  |
          |  | on container startup          |
          |   -------------------------------
         \ /
        FLOW

   .With the new Build kit, much prograss is hidden when building an image which is something the legacy builder would not do.

        To see the output you will have to pass the progress flag :
        
            docker build --progress=plain .
        
        Additionally, you can pass the no-cache flag to disable any caching:
        
            docker build --no-cache --progress=plain .

        To disable Buildkit, you can just pass the following variable to the build command:

            DOCKER_BUILDKIT=0 docker build .

   Here's a Documentation to learn about Docker build, buildkit, buildx..... :
   
       https://docs.docker.com/build/

   Example of a docker image :

    # Step 1: Use an existing docker image as a base 
    FROM alpine

    # Step 2: Download and install dependency

    RUN apk add --update redis

    # Step 3: Tell the image what to do when it starts as container

    CMD ["redis-server"]

   . To run this image use 
   
    $- docker build .
    $- docker run <image id>

# What's a base image ?
   .It's a valid existing Docker image in registry or locally, it serves the base structure for what we need to do whith that container.
    in the exmaple we did, we used Alpine as the base image because we simply need apk(package manager that we need to install redis).
    
# steps of creating an image in legacy mode ( Not in buildkit !!!!!!):

    .For a better understanding use this commande : 
        $- DOCKER_BUILDKIT=0 docker build --progress plain .
  
  Here is the full steps:
  
  <img width="602" alt="Screen Shot 2024-10-27 at 3 41 10 PM" src="https://github.com/user-attachments/assets/c4b8c439-7e32-4ced-824b-fc2d8a99fbb6">

  This commande will show you all the step of craeting an image and all created intermediate containers.
      .Intermidiate containers are containers that're created to execute a steps and take a snapshot for that container before removing it
      . buildkit doesn't create intermediate containers and it's images are not videble to docker run and you can't use --rm=false !!
go search for --debugger flag.

# Commands:
  . Liste all images:

    $ docker images || docker image ls
  . Pull image:

    $ docker pull <repository>:<tag>
  . Launch a container from a docker image:

    $ docker run -it (image name) /bin/bash
    (-it means -interactive -tty)
    OR
    $ docker run -d --name (container name) --publish (port:port) (image name)
    "-d means detach" 
  . List all running processes inside a container

        $ ps -elf
        -e: every process
        -l: long format
        -f: full Format
  . List Containers:

      $ docker ps
      $ docker ps -a #(all containers)
      $ docker ps -aq #(only the IDs of all the containers)
  . Build Image out of a Dockerfile

      $ docker build -t test:latest . #(-t means tag, do the image will be named test:latest)
  . Run a container from an Image:

      $ docker run -d --name web1 publish 8080:8080 test:latest #(-d means detach)
  . Pulling from an unofficial repository:

      $ docker pull <Organisation name/Username>/<repo>:<tag>
   . Pulling from 3rd party registries (not Docker Hub):

      $ docker pull gcr.io/google-containers/git-sync:v3.1.5
   
   . Pulling all images from a repo:

      $ docker pull -a nigelpoulton/tu-demo

   . Docker --filter:

      $ docker images --filter dangling=true
      # List images created before a specific image
      $ docker images --filter "before=ubuntu:latest"

      # List images created after a specific image
      $ docker images --filter "since=alpine:3.14"

      # List images created before a specific timestamp
      $ docker images --filter "before=2023-01-01"

      # List images created since a specific timestamp
      $ docker images --filter "since=2024-01-01"

      # List images with a specific label
      $ docker images --filter "label=maintainer"
      
      # List images with specific label value
      $ docker images --filter "label=version=1.0"

      # List images with multiple labels (AND condition)
      $ docker images --filter "label=environment=production" --filter "label=app=webserver"


   . Searching Docker Hub from the CLI:

      $ docker search nigelpoulton

      # Default limit is 25 line.
      $ docker search alpine --limit 100

      $ docker search alpine --filter "is-official=true
    
  . Commands that create a Layer:
      . RUN
      . COPY
      . ADD

# Multi-architecture images:
  . manifest lists: a list of architectures supported by a particular image tag. Each supported architecture then has its own manifest that lists the layers used to build it. 
  . manifests
![image](https://github.com/user-attachments/assets/0735577a-e58b-45de-b19e-be89bf0e8493)

  . inspect the manifest list of any image on Docker Hub.

    $ docker manifest inspect golang | grep 'architecture\|os'

   . Inspect image :

      $ docker inspect ubuntu:latest

   . Digest :

      $ docker images --digests <REPOSITORY>
      $ docker rmi alpine:latest
      Untagged: alpine:latest
      Untagged: alpine@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11
      Deleted: sha256:44dd6f2230041eede4ee5e792728313e43921b3e46c1809399391535c0c0183b
      Deleted: sha256:94dd7d531fa5695c0c033dcb69f213c2b4c3b5a3ae6e497252ba88da87169c3f
      
      $ docker pull alpine@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11
      docker.io/library/alpine@sha256:02bb6f42...44c9b11: Pulling from library/alpine
      08409d417260: Pull complete
      Digest: sha256:02bb6f428431...9a33cb1af4444c9b11
      Status: Downloaded newer image for alpine@sha256:02bb6f428431...9a33cb1af4444c9b11
      docker.io/library/alpine@sha256:02bb6f428431...9a33cb1af4444c9b11

   . Run a container an remove it as it begins :

      $ docker run --rm golang go version.

   . Build your own build for different plateforms and architectures with docker buildx and docker manifest create :

      $ docker buildx build --platform linux/arm/v7 -t myimage:arm-v7 .
   . Delete image by ID :

      $ docker rmi 44dd6f223004
   . Delete multiple images :

      $ docker rmi f70734b6a266 a4d3716dbb72

   . Delete All images :

      $ docker rmi $(docker images -q) -f
   . Start a container :

      $ ddocker run -it ubuntu /bin/bash

# Self-healing containers with restart policies:
   . always
   . unless-stopped
   . on-failure


   * always: it always restarts a failed container unless itś been explicitly stopped. "--restart always"
   * unless-stopped: The main difference between the always and unless-stopped policies is that containers
                     with the --restart unless-stopped policy will not be restarted when the daemon
                     restarts if they were in the Stopped (Exited) state.
   * on-failure: restart a container with a non-zero exit code. It will also restart containers when the 
                 Docker darmon restarts, even ones that where in the stopped state.

# Volumes :
. The data created in this example is stored on the Docker hosts local filesystem. If
the Docker host fails, the data will be lost.
. Containers are designed to be immutable objects and it’s not a good practice to
write data to them
    For these reasons, Docker provides volumes. These exist outside of containers but can be
mounted into them.
  
