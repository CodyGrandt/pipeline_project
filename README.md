# CSC 325 CI/CD Pipeline Project 

## Part 1: How to setup and use the containerized development environment

1. First, we need to ensure that Docker is downloaded and running properly on the machine.
* Docker Desktop can be downloaded from this link: https://www.docker.com/products/docker-desktop/ 
* Ensure that you are signed in.
* NOTE: If the user wants to understand the basics of containers, feel free to follow the tutorials from the learning center in Docker.

2. Once Docker is setup, we now need ensure that VSCode is downloaded and setup properly.
* VSCode can be downloaded from the following link: https://code.visualstudio.com/
* Follow the setup instructions as prompted.

3. Once VSCode is setup properly, we can now begin copying over our files.
* Open VSCode.
* Click on either the first tab on the left side of the screen, called the explorer, and click on clone repository.  This can also be done by clicking on the third tab down on the left which is the dedicated source control section. It will have the same options of either open folder or clone repository, and again we want to clone a repository.
* NOTE: If you already have workspaces and such open in VSCode, the simplest method to reset is to click on the file tab in the top left of the screen, then click on new window.  This will open a new instance of VSCode with nothing open.
* When clicking on clone repository, you will be prompted to enter either a URL to the repository or browse through your own repositories if you have your GitHub account connected.  We will be using the URL.  Here is the URL for my repository: https://github.com/CodyGrandt/pipeline_project
* Submitting the link will then prompt the user to select a location to download the files; choose wherever you wish these files to be downloaded.  For testing purposes, consider creating a temp folder somwhere on your machine.
* This will begin the download and once completed, all of the necessary files will have been downloaded to the designated location, and that same location will have been opened through VSCode.  Your VSCode should now have the project open.

4. With the files properly copied over, we can now begin setting up the containerized development environment.
* Pull up the terminal through VSCode.  This should be at the bottom of VSCode by default.  Note that there are multiple tabs on that section of VSCode, such as Problems, Output, etc. Ensure you are on the Terminal section.  For my machine, the terminal sometimes disappears or shrinks down to the bottom, a fix to this it to just grab the bottom of the screen and drag the Terminal back up to a desired spot.
* In the terminal, cd into the location of the flutter app using the command: cd default_flutter_app
* Once in this directory, we are going to run the flutter app normally to fix any errors appearing in the app files after being copied over.  To do this, we will use the command: flutter build web
* Once this command finishes, you can run the command: flutter run if you wish to see the app working normally.

5. We will now setup the containerized development environment.
* Once again, ensure that Docker is running.
* we will now run the command: docker build -t insertnamehere . 
* NOTE: you must add the period after this command. Also, feel free to give it any name of your choosing.
* This process will take some time to run the first time.
* Once this process is done, we can now run this container using the command: docker run -d -p ####:## --name samenameasbefore samenameasbefore
* For the section ####:## this the port number that your container will run on.  This can be many different numbers, however the one must used for testing purposes is something like 8080:80.  For the samenameasbefore, ensure that you fill this in with the same name you did for building the docker environment in the previous step above.
* EXAMPLE: If I ran the command: docker built -t pipeline_project .
Then the next command using the "default" port would be: docker run -d -p 8080:80 pipeline_project pipeline_project
Once this command is executed, it will return a random assortment of letters and numbers such as: 92c3e93dea4abfa3284267a848d9a2bf07b326cfbbf571ef803c318d41579317
Once this is done, you should now notice a new container and image in your Docker.  By clicking on the port, a webpage to that port will be opened with the flutter app being on the webpage.

SOURCES
https://github.com/lucashilles/flutter-dev-container
https://dev.to/matsp/develop-flutter-in-a-vs-code-devcontainer-350g
https://hasnainm.hashnode.dev/flutter-web-app-to-a-docker-container
https://medium.com/@kevinwilliams.dev/building-a-flutter-web-container-3b13f4b2bd0c
https://stackoverflow.com/questions/75244108/why-is-the-commit-operation-taking-forever-in-visual-studio-code
https://www.youtube.com/watch?v=SDa3v4Quj7Y&t=1520s
https://www.youtube.com/watch?v=b1RavPr_878&t=212s
https://www.youtube.com/watch?v=b1RavPr_878&t=212s
