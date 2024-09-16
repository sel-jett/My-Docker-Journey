# Basic Docker Commands: A Deep Dive

Let’s start with the fundamental Docker command: "docker run hello-world". This command illustrates how the Docker CLI interacts with the Docker server to retrieve the necessary image.

Here’s a breakdown of the process:

    Docker CLI: Sends a request to the Docker server to run the specified image (hello-world).
    Docker Hub: If the image is not available locally, Docker Hub (a repository of pre-made images) is queried to fetch it.
    Image Retrieval: Docker Hub provides the image, which is then used to run a container.

The image below shows how this interaction is displayed in the Docker CLI.
<img width="2524" alt="Screen Shot 2024-09-16 at 2 28 29 PM" src="https://github.com/user-attachments/assets/14fe4b02-1a00-4c53-b990-e1febc8ecd60">
