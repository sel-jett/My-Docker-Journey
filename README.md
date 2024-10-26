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
