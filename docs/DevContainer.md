# DevContainer Environment

## Introduction
* A **DevContainer** is essentially a containerized development environment.  This means that All of the tools, dependencies, and configurations needed for a specific project (in our case, our web application) are stored in a container.
    * The main goal of utilizing DevContainers is to eliminate the "*it works on my machine*" issue. 
    * By providing all of the files necessary in working on a specific project into a container, deploying these files to a version control software (in my case, GitHub), and running this container on a program such as Docker, each collaborator can easily be deployed to the exact same environment, eliminating compatability issues and streamlining the development process.
    * In our use case, this is extremely important when collaborating with the Professor, to which they can open our Flutter web applications in the exact same environment as we do, so they can experience and help with the exact same issues without needing to have access to the students device.

## Configuration
* Firstly, for configuring your DevContainer, it is recommended that you also use a Dockerfile to keep the DevContainer clean.  To do so, ensure you have a Dockerfile created and implement something similar to:
```
{
   "name" : "insertDesiredNameHere",
   "dockerFile" : "Dockerfile",
```
* This specifies that a separate Dockerfile will be used for specifications.
* One of the most important aspects of a DevContainer is your base **image**, which is essentially template, and in this case a Docker template image for flutter applications.  Implementing a basic image can be done straight inside the DevContainer file, and should look similar to:
```
"image": "google/dart",
```
* However, through the use of a Dockerfile, this process can be designed more specifically for your needs.
* Specific settings and extensions can also be specified in your DevContainer, installing exactly what is needed for the development process.  In my DevContainer, I have a specific setting for ensuring that the default terminal used is bash, which was done as shown:
```
"vscode" : {

   "settings" : {

      "terminal.integerated.shell.linux" : "/bin/bash"

   },
}
```
* I also have two extensions to be installed - Dart and flutter support, which can be done as shown:
```
"vscode" : {

   "extensions" : [

      "Dart-Code.dart-code",
      "Dart-Code.flutter"

   ]
}
```
* I also have a post create command to have flutter create a test project, which can be done as shown:
```
"postCreateCommand" : "flutter create test_project"
```
## Integration with VSCode
* VSCode has many tools to aid in the creation of DevContainers.
* First off, VSCode allows you easily clone a GitHub repository, allowing you to open all of the files within a repository on your own machine.  You can then carry out any GitHub function, such as staging or committing changes back to the repository once you have done so.  This allows for very simple and efficient source control directly within VSCode.
* VSCode has many extensions to aid the user in the DevContainer creation process.  The following are just some of the many useful tools:
   * Docker extension: This extension allows you to easily manage, create, and/or debug your container, without the need of moving between applications.
   * DevContainers extension: This is the most important extension to simplify DevContainer creation.  This application has many DevContainer tools, however the most important one is "*Dev Containers: Add DevContainer Configuration Files*"  This command analyzes the most used langauages in your directory to suggest DevContainers based on these different languages, however you can select whichever you desire.  You can then select your desired build version and any features you would like your DevContainer to do.  Once these steps are completed, the extension will then build your newly specifized DevContainer.
## Usage
* In order to start using our DevContainer, first we need to ensure a couple of tasks are completed.
1. We need to ensure that VSCode is open and running.
2. We need to ensure that Docker is open and running in the background.
3. We need to have our current flutter project open.  In my case, my project is saved in GitHub, so I will use the source control functionality to copy all of my files from my GitHub repository for the specific project onto a file on my machine.  Then I will open that file in VSCode and have access to all of my project files.
* Once all of these conditions are met, we can now begin setting up and running the DevContainer environment.
* Open the command palete and select "*Dev Containers: Reopen in Container.*" This will build the devcontainer environment based on the DevContainer file.
* Once this is completed, you can now begin editing the code within this environment.  Note that all standard VSCode functionality works within this environment, such as debugging tools.
* Once you are done editing your project, we can now begin running the application.  To do this, we need to open VSCode's terminal and ensure that the terminal is in the correct path as your application.  For instance, when I copied over my files in testing, the terminal was defaulted to one path too short to be in the correct path.  To correct this, you type the following into the terminal:
```
cd default_flutter_app (or whatever your path file is called)
```
* Once we are in the correct path, we can now run our flutter application.  To run our flutter application, we can use the command:
```
flutter run
```
* If working successfully, this action should prompt the user to enter the desired application destination (chrome, edge, windows app, etc.)  For our purposes, our main focus is to ensure this application works on the web, so I use chrome as a tester.  A new chrome tab should be created with the flutter web application running and working.
* If you would like to have this web app running on a Docker container, then use the following commands:
```
docker build -t desiredNameHere .
docker run -d -p XXXX:YY --name desiredNameHere desiredNameHere .
```
* This will build a local web server running the flutter application off of the Docker container.  Note that the XXXX:YY above are placeholders for your desired port number.  For testing, I use the numbers 8089:89.
* Once you are finished, you can close VSCode as the files will save in the devcontainer on your machine, or you can commit and push these changes back into the GitHub repository.
## Challenges and Solutions
* One challenge I faced in the beginning was committing my changes to GitHub.  For some reason, the commit would just load forever and never commit.  To solve this problem, I discovered that using the command `git commit -m 'insertmessagehere'`  This finally committed my changes to GitHub as expected.
* Another challenge I faced when building my DevContainer was that my DevContainer could not find my source code when I was using a .devcontainer file to house my DevContainer and Dockerfile.  While not the best solution stylistically, currently I have my Dockerfile and DevContainer directly in the same folder as my app source code.  This allows the DevContainer to find my code.
## Conclusion
* While DevContainers may seem complicated and intimidating, spending the time to setup develop and implement these containers will greatly increase productivity levels.  Implementing DevContainers leads to cutting out compatability issues between collaborators as well as allowing all collaborators to work from their own devices.  This production is streamlined even more when Docker and source control software are used.
