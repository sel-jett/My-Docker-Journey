# Basic Docker Commands: A Deep Dive

Let’s start with the fundamental Docker command: ```docker run hello-world```. This command illustrates how the Docker CLI interacts with the Docker server to retrieve the necessary image.

Here’s a breakdown of the process:

    Docker CLI: Sends a request to the Docker server to run the specified image (hello-world).
    Docker Hub: If the image is not available locally, Docker Hub (a repository of pre-made images) is queried to fetch it.
    Image Retrieval: Docker Hub provides the image, which is then used to run a container.

The image below shows how this interaction is displayed in the Docker CLI.
<img width="2524" alt="Screen Shot 2024-09-16 at 2 28 29 PM" src="https://github.com/user-attachments/assets/14fe4b02-1a00-4c53-b990-e1febc8ecd60">

. one thing you might notice is that when running ```docker run hello-world``` again, you wont see ``can't find the image localy`` so the idea is when fetching an image the first time, docker server store in an image cache so he wont fetch it from docker hub again.

# What a container is.
 to understand what a container is we need to do an overview over our system
 <img width="1775" alt="Screen Shot 2024-09-16 at 2 53 19 PM" src="https://github.com/user-attachments/assets/de2fd5b9-a0be-4c7a-b483-9101eae5408a">

<img width="776" alt="Screen Shot 2024-09-16 at 2 59 39 PM" src="https://github.com/user-attachments/assets/6a4ef63b-c028-4ce8-a843-76103ef800c4">
 the image shows a probleme that we can't run nodejs becose we dont have python v3, and we can't have pyhton v3 and python v2 in the same hard drive
 so the solution is ```Namespacing```

     Namespacing

<img width="1317" alt="Screen Shot 2024-09-16 at 3 04 22 PM" src="https://github.com/user-attachments/assets/e828cedf-ce1f-4532-af99-92240d1933ae">

 . So now that everything is segmented in the harddrive, The kernel now will so a bit of processing by saying if chrome is requesting python, give her python v2, if node => python v3

 <img width="1683" alt="Screen Shot 2024-09-16 at 3 09 14 PM" src="https://github.com/user-attachments/assets/454509c6-2a02-4264-9bfa-e1e809a0b12a">
 so this entire process of segmenting the hard drive based on the process is called "Namescpacing"
     Namespacing : isolating resources per process (or group of process).
  ---------------                       -----------------------------------------------------
 |               |                     | Processes | Hard Drive | Network                    |
 |  Namescpacing | ------------------> |-----------------------------------------------------|
 |               |                     | Users     | Hostnames  | Iner process communication |
  ---------------                       -----------------------------------------------------

  
