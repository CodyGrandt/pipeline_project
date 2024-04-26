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
* **Version Control** is vital in software development for a multitide of reasons.  The most important use of version control is as the name describes: "*version control*," means that commiting changes to your code in your desired version control system, you are then able to "*control which version*" of your code you wish to easily view or make changes to.  This eliminates the stress of accidentally losing important code, or having your code work during one version then break it at a later version.
* The use of **Version Control** is even more beneficial when collaborating in teams on a project.  Version control allows and provides a detailed history of changes made to files so you can see who made changes to a file, when they were made, and why they were made.  This is even more beneficial when the user adds commit messages to document their changes as they made and upload them.  Version control also allows for other vital documents, such as a README and even the file you are currently reading to exist, providing even more information about the project at hand.  All of the documentation previously mentioned is invaluable in software development and streamlines the development process.
* Also, through the use of a code editor such as **Visual Studio Code**, anyone with access to the repository where these files exist can easily copy all of the necessary files for software development directly from the repository onto their machine.  From there they can edit said files, then commit the changes they make directly back into the repository.  This provides quite literally the easiest and most efficient way for all team members to access all of the files needed, without having to directly ask for one member to send files to another, or any other nightmare scenario you could come up with.
### Version Control System Used
* The Version Control System (VCS) used for this project is **GitHub**.  The main reason GitHub was chosen over other Version Control Systems, such as GitLab, is that when preparing for the original DevContainer assignment,  almost every video or article seen when conducting research was utilizing GitHub. This was the VCS that Professor Munday elected to use as well.  Despite this, more research needed to be conducted before deciding on a VCS.  The main factor for choosing GitHub over other VCS came out to be:
   * **GitHub actions**.  This is a feature within GitHub that allows you to almost instantly creat, build, test, and deploy a continuous integration and continuous delivery (CI/CD) pipeline for your projects.  Since this was one of the main goals of this project, I felt that this was going to be a major help in the production process of this project.  Besides this major feature, GitHub also boasts other very useful features such as code reveiw tools, issue tracking, branching, merging, pull requests, etc., which all aid in the devlopment process.  I also felt like since GitHub was the most popular VCS, it would be more likely that another classmate or the professor would be able to help me in the event that I had an issue.  Finally, since I felt that GitHub had the cleanest and most familiar feeling user interface, I elected to use GitHub as my Version Control System.
* If interested in getting started with GitHub after reading the previous section, feel free to sign up for free at their website [here](https://github.com/).
* Once setting this up, if the user wish to begin testing making and commiting changes to this repository through VSCode, feel free to download VSCode from their website [here](https://code.visualstudio.com/download).
### Repository Setup

#### Repository Structure
* This GitHub repository has six folders in the **master** branch: .devcontainer, .github, default_flutter_app, docs, flutter_todo_app, and weather_app   Inside .github are various files associated with GitHub and version control.  Inside default_flutter_app is where the default button clicker and counter flutter app created for testing the DevContainer, Docker, etc. as well as my actual DevContainer and Dockerfiles are located.  the files for the other apps are in their respective folders.  .devcontainer contains the devcontainer and dockerfile, and the docs folder contains various markdown files for reading purposes. There is also a main README in the root directory.
* The branching strategy is to create a new branch for every new feature to be implemented or for every bug to be fixed.  This way any changes made for a specific feature/bug will be separate from the main branch to avoid changing code that already works.  Once a new feature works correctly, then this branch will be merged with the master branch.

#### Implementation With DevContainer and CI/CD Pipeline
* By creating a DevContainer and inserting it within a project directory in a VCS, any other collaborators who need to work on the project can download and use the DevContainer to have their coding environment setup exactly how the lead on the project wishes the coding environment to be setup.  This eliminates the "*It works on my machine*" issue in software development as each individual who downloads the project files and DevContainer from the VCS repository will have their coding environments opened with the exact same settings setup.
* Many of the most popular VCS have some sort of tools to aid in the creation of a **Continuous Integration/Continuous Deployment (CI/CD)** pipeline. For example, GitHub has GitHub Actions and GitLab has GitLab CI. This does as the name describes; it automates the process of testing and deploying code changes within your repository.  By utilizing these tools, in my case GitHub Actions, a CI/CD pipeline is created using a YAML file that specifies the steps to build, test, and deploy your project.

### Common Commands and Usage
```
git clone https://github.com/CodyGrandt/pipeline_project
```
* This command clones the specified repository, allowing you to save all of the files within the repository onto your machine where you can then begin to work on said project.  The exact command listed above is what I would type into the VSCode terminal in order to clone my pipeline_project repository onto my local machine.
```
git commit -m "insert desired commit message here"
```
* This command commits all changes made to the files you cloned onto your machine back into the repository.  For example, if I had my files cloned over, then added a README file, wrote some text inside of this file, then wished for this README to be inserted into my repository, then I may type a command like so into the VSCode terminal: `git commit -m "created and wrote README"`
```
git branch branch_name
```
* This command creates a new branch within your repository to allow you to begin working on a new feature for your project, without having it interfere with your already completed and working code.  The name given to the branch should be concise and represents the feature you intend on creating and implementing.  Once created, you will then need to use the following command to actually enter that branch: `git checkout branch_feature_name`.  For example, if I wished to create a new branch for multiplayer, the commands entered into the VSCode terminal look like so: `git branch multiplayer` and then `git checkout multiplayer`.
```
git merge branch_name
```
* This command merges the branch entered with the current branch.  For example, if I was in the main branch and I wished to merge my new multiplayer feature (which I had already tested to confirm that it worked), then I would type the following command into the VSCode terminal: `git merge multiplayer`
```
git revert <commit-hash>
```
* This command allows you to revert to a previous version of your repository before recent commits take place, hints the name and most important aspect of Version Control.  To do so, you must obtain the unique code assigned to each commit, then enter this command into the VSCode terminal in place of the `<commit-hash>` place holder written above.
### Collaboration Features
* Version Control is the single most beneficial tool to collaboration among team members.  By having a shared repository where all of the necessary project files are located and where team members can push their changes back into this repository, the software development process is streamlined by eliminating the need to ask other team members from files as they are all located within the repository.
* Each team member can create their own branch to work on their specific task without interfering with the main code.  Once this feature is completed, it can either be committed back into the main branch of the repository, or a **pull request** can be made.
* **A pull request** proposes changes to the main code of the project, instead of automatically committing these changes.  Team members can then *review the code* and the changes made and provide feedback before this change is made to the main code of the project.
* **Code Review** is a vital part of collaborating in the software development process.  First off, this promotes discussions within team members, and allows team members to become familiar with your section of the project.  This maintains a streamlined development process as team members stay on the same page about the goal of the project.  Also, since everyone makes mistakes, it is invaluable to have others to bounce your code off of, having them look for bugs and also ensuring that your code is up to standard in quality.  This should also be carried out once a pull request is made for a specific feature, so that the other team members can confirm that this feature should be merged with the main source code.
* Version Control is also great in aiding teams in the event of **conflict resolution** occurring.  This is when two team members make changes to the same code.  By utilizng Version Control tools such as reverting to previous commit stages, this is great for resolving conflicts that arise in the devlopment process.
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
### Development Environment Chosen
* GitHub Pages is a web hosting service provided by GitHub that hosts static websites directly from GitHub repositories. It's a convenient and free way to showcase projects, create personal websites, host documentation, and more.
* [GitHub Pages](https://pages.github.com/) was chosen for a number of reasons:
   * **easy deployment**:  websites can be deployed from GitHub Actions immediately after testing and can even be defined in the same file.  Whenever changes are pushed to the repository, GitHub Pages will automatically deploy and update the website.
   * **Version Control**: since all website files are stored in a GitHub repository, you benefit from version control features such as commit history, branching, and pull requests. This allows you to track changes to your site over time and collaborate with others on its development.
   * **Custom Domain Support**: GitHub Pages allows you to use a custom domain name for your website, giving it a professional appearance and allowing you to maintain consistent branding across your online presence.
   * **Free Hosting**: GitHub Pages provides free hosting for static websites directly from your GitHub repository. This is particularly advantageous for open-source projects and personal websites, as it eliminates the need to pay for separate hosting services.

### Setting Up GitHub Pages
To set up GitHub Pages for your Flutter application, you'll need to follow these general steps:
1. Build your Flutter application: Make sure your Flutter application is built and generates static web files. The `flutter build web` command is typically used for this purpose. Ensure that the output files are stored in a directory that you specify in the `publish_dir` parameter.
2. Create a GitHub Actions workflow: Create a `.github/workflows/deploy.yml` file (*this is combined with the test file into one main.yml file*) in your repository with the provided deployment code. This workflow will run automatically whenever changes are pushed to your repository, deploying your Flutter application to GitHub Pages.
3. Configure GitHub Pages settings: Go to your repository's Settings page on GitHub, then navigate to the "Pages" section. Select the `gh-pages` branch as the source for GitHub Pages, and make sure the root folder is set to /. This tells GitHub Pages to serve your website from the `gh-pages` branch.
4. Commit and push your changes: Commit your changes to your repository and push them to GitHub. GitHub Actions will automatically trigger the deployment workflow, and your Flutter application should be deployed to GitHub Pages shortly thereafter.

* Once these steps are completed, your Flutter application should be accessible via a URL in the format `https:// username.github.io/repository-name, where usernameis your GitHub username andrepository-name` is the name of your repository. You can share this URL with others to access your deployed Flutter application.

### Code
* For this specific project, the main.yml file contains the following code segment to deploy to GitHub Pages:
```
- name: deploy
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./default_flutter_app/build/web/
```
* `name`: This is the name of the step in your GitHub Actions workflow. In this case, it's named "deploy."
* `uses`: This specifies the GitHub Actions action that you're using for this step. `The peaceiris/actions-gh-pages@v3` action is used to deploy your application to GitHub Pages. This action automates the process of pushing your files to the gh-pages branch, which GitHub Pages uses to serve your website.
* `with`: This is used to provide input parameters to the action.
* `github_token`: This is a GitHub secret token (secrets.GITHUB_TOKEN) that GitHub automatically creates for your repository. It's used to authenticate the action with GitHub, allowing it to push changes to your repository. Make sure your repository has the appropriate permissions (usually repository scope) for this token.
* `publish_dir`: This specifies the directory where your built Flutter application files are located. In this case, it's set to ./default_flutter_app/build/web/. Adjust this path to match the actual directory structure of your Flutter project.
## Flutter Web Application

#### App Overview
* The app created for this project is a todo app.  This app was coded in flutter which is based on Dart.  This app was specifically designed as a web application, however simple adjustments made to this project would easily allow this app to be deployed to other devices, such as IOS and Android.
* This app supports the following features:
   * Addition of new todo tasks
   * deletion of current todo tasks
   * checking off and crossing out todo tasks
   * searching for tasks
* The app also demonstrates simple graphic creation and asset manipulation as seen from the displayed avatar picture in the top right of the screen.
#### App Structure
* a `main.dart`file that combines all of the other `.dart` files into one neat file to build the full todo application.
* a constants folder that contains a `colors.dart` file which contains all of the special colors utilized in this flutter app.
* a model folder that contains a `todo.dart` file which contains the model todo list that the app displays upon deployment and when a user visits the web app.  Users can then change the todo list at their desire.
* a screens folder that contains a `home.dart` file which contains the code for displaying the home screen of the flutter application.
* a widgets folder which contains a `todo_item.dart` file which defines the structure of a todo item.
#### Testing, Deployment, and Issues Faced
* This specific flutter app, the todo app, currently does not have a testing process, and therefore the `main.yml` CI/CD file needed to be modified by commenting out the testing phase of the pipeline.  
   * It is important to note that this testing phase does work properly when deploying the default flutter app found in the `default_flutter_app` directory.  To test this, one must change the `main.yml` file to access the `default_flutter_app` directory instead of the `flutter_todo_app` directory, and to uncomment out the testing phase.
      * For example:
      ```
        #  - name: run test
        #    working-directory: ./flutter_todo_app
        #    run: flutter test

      - name: deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./flutter_todo_app/build/web/
      ```
      * Found in the `main.yml` would need to be changed to the following code:
      ```
      - name: run test
        working-directory: ./default_flutter_app
        run: flutter test

      - name: deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./default_flutter_app/build/web/
      ```
      * In order to properly see the testing phase of the flutter application.
* This was one of the major issues faced during the development of this application.
* Another major issue faced was that the original intention for this flutter app was to have the todo list on one half of the screen and a weather app on the other half of the screen, to create somewhat of a "*morning routine hub*".  However this has not yet been carried out due to issues in the location grabbing and manipulation in the weather app (which can be found in the `weather_app` folder), so currently the application is just the todo app.

## Conclusion
#### Lessons Learned
* **VSCode** is the ultimate coding platform, not only for solo development thanks to its support for countless different languages, but also for its compatability with **Version Control Systems** and the combination of VSCode with **DevContainers** for team development.
* **DevContainers** allow the exact dependencies and packages of a build of VSCode to be installed each time the program is opened.  When this is combined with a containerized image program such as **Docker**, the exact same build of VSCode can be run on a container instead of the developers machine.  Once every developer on the team is working on the same VSCode on a container, then the "*It works on my machine*" issue is eliminated.
* **Version Control Systems (VCS)** are the most important aspect of team development.  While also useful solo developing, the tools these systems, such as GitHub provide make developing stress free.  By providing the ability to roleback to previous states ensures that work will never be lost.  branching allows individual team members to work on their own app features, then that work can be merged back to the main branch instantly or after other team member have verified that the work is sufficient.
* **CI/CD pipelines**, standing for Continuous Integration/Continuous Deployment pipelines, are a set of automated processes that help software teams deliver code changes more frequently and reliably.
   * **Continuous Integration (CI)** involves automatically intgrating code changes from multiple developers into a shared repository several times a day. Each integration triggers automated builds and tests to detect integration errors early in the development process.
   * **Continuous Deployment (CD)** focuses on automating the deployment process to rele**ase code changes to production environments quickly and safely. It involves automating deployment steps, such as building artifacts, running tests, and deploying to production, typically triggered after successful CI.
#### Challenges Faced
* The DevContainer can be very difficult to build properly not only because of its confusing verbage and indentation, but also due to it being a very confusing process to develop.  The DevContainer in this project does not work fully and still needs to be completed.
* Setting up GitHub pages can be confusing due to all of the settings that need to be changed in GitHub in order to setup the process.
#### Potential Improvements:
* Refinement of CI/CD Pipeline: Streamlining the CI/CD pipeline by optimizing build times, refining testing strategies, and automating deployment processes could improve efficiency and reduce deployment errors.
* Enhanced Testing Coverage: Increasing testing coverage by incorporating more edge cases, scenario-based tests, and performance testing could further improve application reliability and quality.
* Continuous Monitoring and Feedback: Implementing continuous monitoring tools and integrating feedback mechanisms into the pipeline would enable faster detection and resolution of issues in both the application and the pipeline itself.
* Overall, the project provided valuable hands-on experience in developing and deploying Flutter applications, highlighting the importance of thorough testing, efficient CI/CD pipelines, and continuous improvement practices. By addressing the challenges encountered and implementing potential improvements, future Flutter projects can be executed more effectively, delivering high-quality applications with streamlined development and deployment processes.
