# CSC 325 Project Report: Building a CI/CD Pipeline for a Flutter Application

## Introduction 
* **Continuous Integration/Continuous Deployment (CI/CD) Pipelines** are crucial to modern software development practices.  
* To practice **Continuous Integration (CI)**, developers must utilize a **Version Control System (VCS)** such as GitHub and commit their code changes into a central repository.  From there, each commit to the repository triggers an automated build and test process to detect integration errors early in the deployment process.  
* **Continuous Deployment (CD)** extends Continuous Integration by automatically deploying code changes to production or staging environments after passing through and successfully completing the Continuous Integration process.  The purpose of Continuous Deployment is to automate the entire software release process in order to improve efficiency and to reduce human error.  In practicing CI/CD, the more automation the better.
* The process of developing code and committing changes to the central repository is streamlined through the development and use of **DevContainers** and **Dockerfiles** (*See explanation below).*

## DevContainer Environment

* A **DevContainer** is essentially a containerized development environment.  This means that all of the tools, dependencies, and configurations needed for a specific project (*in our case, our web application*) are stored in a container.
    * The main goal of utilizing DevContainers is to eliminate the "*it works on my machine*" issue. 
    * By providing all of the files necessary in working on a specific project into a container, deploying these files to a version control software (in my case, GitHub), and running this container on a program such as Docker (*learn more about Docker [here](https://www.docker.com).*), each collaborator can easily be deployed to the exact same environment, eliminating compatability issues and streamlining the development process.
    * In our use case, this is extremely important when collaborating with the Professor, to which they can open our Flutter web applications in the exact same environment as we do, so they can experience and help with the exact same issues without needing to have access to the students device.

### DevContainer Configuration
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
### DevContainer Usage
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

## Source Code Version Control Tools
*
*
*
## Version Control System Used
*
*
*
## CI/CD Pipeline Environment
* In order to support agile software development and deployment, the infrastructure of the CI/CD pipeline needs to be hosted on a **cloud-based platform**.  Depending on the CI/CD Pipeline tools used, the infrastructure could be hosted on Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP).  This project utilizes GitHub Actions (*refer to the CI/CD  Tools section to learn why*) which is hosted using the **Microsoft Azure** cloud platform, which has the GitHub Actions runner application installed.
* GitHub Actions provides runners that can be used to run jobs, or the user can host their own runners.  Each GitHub-hosted runner is a new Virtual Machine hosted by GitHub, and is available with **Ubuntu Linux, Windows, or MacOS operating Systems**. [Click to learn more about GitHub-hosted Runners](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners%23:~:text%3DGitHub%2520provides%2520runners%2520that%2520you,Windows%252C%2520or%2520macOS%2520operating%2520systems.&ved=2ahUKEwiu3tmb-KaFAxWW4MkDHQ5aCv4QFnoECA4QAw&usg=AOvVaw24zN_xo0hfHe6UtdziPKUi)
* A **Virtual Private Cloud (VPC)** provides an isolated section of the cloud where resources like virtual machines, containers, and services reside.  It allows you to define your network settings, including IP address ranges, subnets, route tables, and getaways.  CI/CD Pipelines operate within a VPC to provide network isolation, security, and control over network resources.
    * **Subnets** are used to partition the VPC into smaller segments for organization and resource isolation.  
    * **Routing Tables** define how traffic is routed between subnets and to external networks.
    * **Security groups and network ACLs** enforce security policies by controlling inbound and outbound traffic to instances and resources within the VPC.
## CI/CD Tools
* The tools used to create the CI/CD Pipeline for this project was through **[GitHub Actions](https://github.com/features/actions)**.  This was done for a number of reasons, however there are also some drawbacks to this tool:
### GitHub Actions Benefits
1. GitHub Actions allows  a CI/CD pipeline to be integrated directly into a GitHub repository.  This was the most convenient choice for implementing a pipeline since the **Version Control System (VSC)** chosen for this project had already been GitHub.
2. GitHub Actions workflows are **stored directly in the repositories**, allowing for carefree implementation and access.  Also, since the workflows belong in the same repository, they are also versioned along the repository's code, meaning changes to the workflows can be tracked, reverted, etc. depending on the needs of the developer(s).
3. GitHub Actions allows for **automatic creation and implementation** of a CI/CD pipeline based on the template selected.  These workflows can be configured and created based on the user's needs and automatically implements within the user's repository.  While this workflow is not guaranteed to work directly upon creation, it does provide a very helpful starting point the user can proceed from.
4. GitHub Actions is **free** for the base tier for public repositories, allowing for CI/CD automation without extra costs.  Despite this, GitHub Actions also allows for simple scalability and performance enhancements on pipelines for large projects.
5. Since the workflows are stored directly in the project repository, they can be accessed and edited inside VSCode just like any other project file.  This allows for the workflow to be edited and pushed back into the repository 
### GitHub Actions Limitations
1. GitHub Actions provides predefied execution environments for workflows, including Linux, Windows, and MacOS runners.  While these cover most use cases, users may encounter limitations if they require highly specialized or custom execution environments.
2. Since GitHub Actions is a subset of GitHub, any downtime or disruptions in the availibility of GitHub will henceforth effect GitHub Actions as well.
3. GitHub Actions imposes resource constraints, such as limitations on ongoing workflows, workflow runtime, and usage minutes for self-hosted runners.  Organizations with high build volumes will need to manage their usage or upgrade to a higher tier plan.
4. While GitHub Actions supports self-hosted runners for custom execution environments, this feature set may be more limited compared to cloud-hosted runners, especially in complex or distributed environments.
### CI/CD Automation Process
The Following demostrates the automatic process the CI/CD pipeline follows to deploy:
1. The pipeline is automatically triggered when changes are made to the source code.  Examples of this include code commits, pull requests, etc.  Once the CI/CD pipeline is triggered, the pipeline begins by carrying out the steps in the workflow (YAML) file.
2. The Source Code from the repository is **Checked Out**, or duplicated to a designated workspace for further processing.  For this project, this is designated in the workflow by the following:
```
name: checkout code
      uses: actions/checkout@v4

    - uses: subosito/flutter-action@v1
      with:
        channel: 'stable'
```
3. The necessary dependencies for developing and running flutter applications are installed.  For this project, this is designated in the workflow by the following:
```
name: install dependencies
      working-directory: ./default_flutter_app
      run: flutter pub get
```
4. Once the source code is checked out and the necessary dependencies are installed, then **Unit Testing** is carried out to verify the correctness of individual components or units of code in isolation.  The pipeline runs these automatic tests in order to verify the functionality of the code.  For this project, this is designated in the workflow by the following:
```
name: run test
      working-directory: ./default_flutter_app
      run: flutter test
```
   * **Integration Testing** is also carried out to verify the interactions between different components or modules of the flutter application.
5. Once the code has been tested and verified to be working, then the complete code can be **compiled and built**.  For this project, this is designated in the workflow by the following:
```
name: build flutter web
      working-directory: ./default_flutter_app
      run: flutter build web
```
6. Once the flutter application has been successfully built, then it can be deployed.  This project deploys the flutter application to a GitHub Pages website, which can be found [HERE](https://codygrandt.github.io/pipeline_project/).  For this project, this is designated in the workflow by the following:
```
name: deploy
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./default_flutter_app/build/web/
```
   
## Deployment Environment
*
*
*
## Flutter Web Application
*
*
*
## Conclusion
*
*
*