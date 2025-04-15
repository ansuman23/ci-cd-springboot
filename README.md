# Docker, Kubernetes, CI/CD on AWS, Terraform and AWS DevOps 🚀

## Project Overview 📝
This project demonstrates a **Java Spring Boot** application integrated with **Swagger API** documentation, containerized using **Docker**, deployed on **Kubernetes**, and automated with a complete **CI/CD pipeline** on **AWS** using **CodePipeline**, **CodeBuild**, **CodeDeploy**, and **Amazon EKS**.

Key Features:
- **Spring Boot** app with Swagger API docs
- **Docker** for containerization of the application
- **Kubernetes** for container orchestration
- **CI/CD** automation with **AWS services** (CodePipeline, CodeBuild, CodeDeploy, EKS)
- **Docker Hub** as the container registry
- Full integration with **AWS Lambda** for serverless functionality (optional)

---

## Table of Contents 📑
- [Project Setup](#project-setup)
- [Technologies Used](#technologies-used)
- [Setup Instructions](#setup-instructions)
- [CI/CD Pipeline](#cicd-pipeline)
- [Kubernetes Setup](#kubernetes-setup)
- [AWS CodePipeline & CodeDeploy](#aws-codepipeline-codedeploy)
- [Deployment](#deployment)
- [Terraform](#terraform)
- [Contributing](#contributing)
- [License](#license)

---

## Project Setup ⚙️

### 1. Clone the repository
Start by cloning the repository to your local machine:
```bash
git clone https://github.com/your-username/springboot-docker-kubernetes.git
cd springboot-docker-kubernetes
```

### 2. Build the Spring Boot Application
Use **Maven** to build the Spring Boot app:
```bash
./mvnw clean install
```

### 3. Dockerize the Application 🐳
Docker is used to package the application into a container for easy deployment and scaling.

- **Dockerfile**: A Dockerfile defines the environment to run your Spring Boot application.
  ```Dockerfile
  FROM tomcat:9.0.85-jdk17
  WORKDIR /user/local/tomcat/webapps/
  COPY target/expense-tracker-0.0.1-SNAPSHOT.war expense-tracker.war
  EXPOSE 8081
  CMD ["catalina.sh","run"]
  ```

- **Build Docker Image**:
  ```bash
  docker build -t your-username/springboot-app .
  ```

- **Push Docker Image to Docker Hub**:
  ```bash
  docker push your-username/springboot-app
  ```

---

## Technologies Used ⚡

### Java Spring Boot 🖥️
A popular Java framework for building stand-alone, production-grade web applications. It simplifies the development of RESTful APIs.

### Docker 🐋
Docker containers package the application and its dependencies into a portable unit, ensuring consistent runtime across environments.

### Kubernetes 🔲
Kubernetes automates the deployment, scaling, and management of containerized applications. It provides high availability, scalability, and easy rollback features for your applications.

### AWS CI/CD 🌩️
AWS services like **CodePipeline**, **CodeBuild**, and **CodeDeploy** automate the build, test, and deployment process, ensuring faster and error-free releases.

### Swagger 📚
Swagger is used for generating interactive API documentation, allowing users to easily test and understand the API endpoints.

### AWS Lambda ⚡
AWS Lambda allows you to run serverless functions in response to events, reducing the need for managing servers.

---

## Setup Instructions 🔧

### Docker Setup 🐋
**Dockerize the application** to create a containerized version of the Spring Boot app, which can be deployed consistently across environments.

1. **Create Dockerfile**:
   Define the base image, copy the application JAR, and set the entry point.
   ```Dockerfile
    FROM tomcat:9.0.85-jdk17
    WORKDIR /user/local/tomcat/webapps/
    COPY target/expense-tracker-0.0.1-SNAPSHOT.war expense-tracker.war
    EXPOSE 8081
    CMD ["catalina.sh","run"]
   ```

2. **Build Docker Image**:
   ```bash
   docker build -t your-username/springboot-app .
   ```

3. **Push Image to Docker Hub**:
   ```bash
   docker push your-username/springboot-app
   ```

### Kubernetes Setup 🔲
**Kubernetes** helps manage the containerized application with features like auto-scaling, high availability, and rolling updates.

1. **Create Kubernetes Deployment**: Use `deployment.yaml` for specifying how many pods you need and the container to run.
   Example `deployment.yaml`
   ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: expense-tracker-deployment
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: expense-tracker
      template:
        metadata:
          labels:
            app: expense-tracker
        spec:
          containers:
            - name: expense-tracker
              image: ansuman25/expense-tracker:1.0
              ports:
                - containerPort: 8081
   ```

3. **Create Kubernetes Service**: Expose the app with a `service.yaml` to make it accessible via a LoadBalancer.
   Example `service.yaml`
   ```
   apiVersion: v1
    kind: Service
    metadata:
      name: expense-tracker-service
    spec:
      type: NodePort
      selector:
        app: expense-tracker
      ports:
        - port: 8081
          targetPort: 8081
          nodePort: 30081
   ```

### AWS CI/CD Pipeline 🔄
Set up **CI/CD** pipelines using AWS services for automating the entire process of code deployment.

1. **CodePipeline**: Integrates with GitHub for continuous integration and AWS services for deployment.
2. **CodeBuild**: Automatically builds Docker images and pushes them to **Docker Hub**.
3. **CodeDeploy**: Deploys the Docker container on **Amazon EKS**.

Example **buildspec.yml** for AWS CodeBuild:
```
version: 0.2

phases:
  build:
    commands:
      - echo Skipping Docker build, image is already in Docker Hub.

artifacts:
  files:
    - '**/*'
```
---
## Deployment 📦

**Deploy to Amazon EKS**:
   - Set up an **Amazon EKS** cluster and configure `kubectl` to interact with it.
   - Use the following commands to deploy:
     ```bash
     kubectl apply -f deployment.yaml
     kubectl apply -f service.yaml
     ```

**☁️ Deploy to Amazon S3 (Static Files or Lambda Package)**
- Create an S3 bucket to store your deployment files or host a static website.
- Use the following commands to upload your artifacts:
```bash

aws s3 mb s3://your-bucket-name
aws s3 cp lambda-function.zip s3://your-bucket-name/lambda-function.zip
aws lambda update-function-code \
  --function-name your-lambda-name \
  --s3-bucket your-bucket-name \
  --s3-key lambda-function.zip
```

## 🛠️ Terraform Deployment (for Web Scraper)
This project uses Terraform to automate the deployment of the Python web scraper to an AWS EC2 instance.

✅ Purpose
Instead of running the scraper locally, Terraform provisions a virtual machine in the cloud, installs Python and dependencies, and runs the script automatically.

## Contributing 🤝

We welcome contributions! To contribute to this project:
1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.
---
---
Some Snapshots attached to showcase the final results of the Project:

**CI-CD Pipeline**
![ci-cd pipeline](https://github.com/user-attachments/assets/9337fbd3-a412-45b3-9ab3-decc3d559160)

**CodeBuild**
![CodeBuild](https://github.com/user-attachments/assets/f0cab628-5a71-4b7b-a20a-15c36eb452a9)

**Docker Hub**
![Docker image in Docker Hub](https://github.com/user-attachments/assets/068f91a3-6b3d-43b8-ae0d-8c823739f4b7)

**Kubernetes Dashboard**
![kubernetes dashboard](https://github.com/user-attachments/assets/4586bc57-fc8d-4989-b5b0-1254e52b6c9a)

## 🖋️ Author
This project was created and maintained by [Ansuman Parija](https://github.com/ansuman23).
For any questions or contributions, feel free to reach out.



