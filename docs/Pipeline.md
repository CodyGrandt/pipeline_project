# CI/CD Pipeline
* The **CI/CD Pipeline**'s main purpose is to support rapid development, testing, and deployment of software applications, specifically flutter web applications for the purpose of this project.
## CI/CD Pipeline Environment
* In order to support agile software development and deployment, the infrastructure of the CI/CD pipeline needs to be hosted on a **cloud-based platform**.  Depending on the CI/CD Pipeline tools used, the infrastructure could be hosted on Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP).  This project utilizes GitHub Actions (*refer to the CI/CD Pipline Tools section to learn why*) which is hosted using the **Microsoft Azure** cloud platform, which has the GitHub Actions runner application installed.
* GitHub Actions provides runners that can be used to run jobs, or the user can host their own runners.  Each GitHub-hosted runner is a new Virtual Machine hosted by GitHub, and is available with **Ubuntu Linux, Windows, or MacOS operating Systems**. [Click to learn more about GitHub-hosted Runners](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners%23:~:text%3DGitHub%2520provides%2520runners%2520that%2520you,Windows%252C%2520or%2520macOS%2520operating%2520systems.&ved=2ahUKEwiu3tmb-KaFAxWW4MkDHQ5aCv4QFnoECA4QAw&usg=AOvVaw24zN_xo0hfHe6UtdziPKUi)
* A **Virtual Private Cloud (VPC)** provides an isolated section of the cloud where resources like virtual machines, containers, and services reside.  It allows you to define your network settings, including IP address ranges, subnets, route tables, and getaways.  CI/CD Pipelines operate within a VPC to provide network isolation, security, and control over network resources.
    * **Subnets** are used to partition the VPC into smaller segments for organization and resource isolation.  
    * **Routing Tables** define how traffic is routed between subnets and to external networks.
    * **Security groups and network ACLs** enforce security policies by controlling inbound and outbound traffic to instances and resources within the VPC.
## CI/CD Pipeline Tools
The tools used to create the CI/CD Pipeline for this project was through **[GitHub Actions](https://github.com/features/actions)**.  This was done for a number of reasons, however there are also some drawbacks to this tool:
### Benefits
1. GitHub Actions allows  a CI/CD pipeline to be integrated directly into a GitHub repository.  This was the most convenient choice for implementing a pipeline since the **Version Control System (VSC)** chosen for this project had already been GitHub.
2. GitHub Actions workflows are **stored directly in the repositories**, allowing for carefree implementation and access.  Also, since the workflows belong in the same repository, they are also versioned along the repository's code, meaning changes to the workflows can be tracked, reverted, etc. depending on the needs of the developer(s).
3. GitHub Actions allows for **automatic creation and implementation** of a CI/CD pipeline based on the template selected.  These workflows can be configured and created based on the user's needs and automatically implements within the user's repository.  While this workflow is not guaranteed to work directly upon creation, it does provide a very helpful starting point the user can proceed from.
4. GitHub Actions is **free** for the base tier for public repositories, allowing for CI/CD automation without extra costs.  Despite this, GitHub Actions also allows for simple scalability and performance enhancements on pipelines for large projects.
5. Since the workflows are stored directly in the project repository, they can be accessed and edited inside VSCode just like any other project file.  This allows for the workflow to be edited and pushed back into the repository 
### Limitations
1. GitHub Actions provides predefied execution environments for workflows, including Linux, Windows, and MacOS runners.  While these cover most use cases, users may encounter limitations if they require highly specialized or custom execution environments.
2. Since GitHub Actions is a subset of GitHub, any downtime or disruptions in the availibility of GitHub will henceforth effect GitHub Actions as well.
3. GitHub Actions imposes resource constraints, such as limitations on ongoing workflows, workflow runtime, and usage minutes for self-hosted runners.  Organizations with high build volumes will need to manage their usage or upgrade to a higher tier plan.
4. While GitHub Actions supports self-hosted runners for custom execution environments, this feature set may be more limited compared to cloud-hosted runners, especially in complex or distributed environments.
## Automation Process
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
4. Once the source code is checked out and the necessary dependencies are installed, then **Unit Testing** is carried out to verify the correctnedd of individual components or units of code in isolation.  The pipeline runs these automatic tests in order to verify the functionality of the code.  For this project, this is designated in the workflow by the following:
```
name: run test
      working-directory: ./default_flutter_app
      run: flutter test
```

   
