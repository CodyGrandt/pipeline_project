# DevContainer Environment

## Introduction
* A **DevContainer** is essentially a containerized development environment.  This means that All of the tools, dependencies, and configurations needed for a specific project (in our case, our web application) are stored in a container.
    * The main goal of utilizing DevContainers is to eliminate the "*it works on my machine*" issue. 
    * By providing all of the files necessary in working on a specific project into a container, deploying these files to a version control software (in my case, GitHub), and running this container on a program such as Docker, each collaborator can easily be deployed to the exact same environment, eliminating compatability issues and streamlining the development process.
    * In our use case, this is extremely important when collaborating with the Professor, to which they can open our Flutter web applications in the exact same environment as we do, so they can experience and help with the exact same issues without needing to have access to the students device.

## Configuration
* 
## Integration with VSCode
* VSCode has many tools to aid in the creation of DevContainers.
* First off, VSCode allows you easily clone a GitHub repository, allowing you to open all of the files within a repository on your own machine.  You can then carry out any GitHub function, such as staging or committing changes back to the repository once you have done so.  This allows for very simple and efficient source control directly within VSCode.
* VSCode has many extensions to aid the user in the DevContainer creation process.  The following are just some of the many useful tools:
   * Docker extension: This extension allows you to easily manage, create, and/or debug your container, without the need of moving between applications.
   * DevContainers extension: This is the most important extension to simplify DevContainer creation.  This application has many DevContainer tools, however the most important one is "*Dev Containers: Add DevContainer Configuration Files*"  This command analyzes the most used langauages in your directory to suggest DevContainers based on these different languages, however you can select whichever you desire.  You can then select your desired build version and any features you would like your DevContainer to do.  Once these steps are completed, the extension will then build your newly specifized DevContainer.
## Usage
* In order to setup the DevContainer and Docker for the first time, please refer to the README in this directory.
* 
## Challenges and Solutions
* One challenge I faced in the beginning was committing my changes to GitHub.  For some reason, the commit would just load forever and never commit.  To solve this problem, I discovered that using the command `git commit -m 'insertmessagehere'`  This finally committed my changes to GitHub as expected.
* Another challenge I faced when building my DevContainer was that my DevContainer could not find my source code when I was using a .devcontainer file to house my DevContainer and Dockerfile.  While not the best solution stylistically, currently I have my Dockerfile and DevContainer directly in the same folder as my app source code.  This allows the DevContainer to find my code.
## Conclusion
