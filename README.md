# Full Stack E-Commerce Platform with Auto-Scaling

This project implements a full-stack e-commerce platform that automatically scales based on the load of the website. By utilizing an array of technologies, this project demonstrates a comprehensive approach to building scalable, efficient, and reliable web applications. The application features a range of items, allowing users to browse, select, and purchase from a list of products.

## Project Overview
The project simulates an e-commerce platform, providing functionalities such as product browsing, user management, shopping cart operations, and more. It is designed with scalability in mind, automatically adapting to the load of the website to ensure a smooth and reliable user experience.

## Technologies Used

- **Front-End**: React.js
- **Back-End**: Node.js / Express.js
- **Database**: AWS DynamoDB
- **Storage**: AWS S3 for storing product images
- **Infrastructure**: AWS EC2, Elastic Load Balancer, and Auto Scaling Groups
- **Configuration Management**: Terraform for Infrastructure as Code (IaC)
- **Containerization and Orchestration**: Docker and Kubernetes
- **Continuous Integration/Continuous Deployment (CI/CD)**: CircleCI
- **Version Control**: Git & GitHub

## Features

1. **User Management**: Users can sign up, log in, and manage their profiles. 
    > Note: This is a Work in Progress (WIP)   
2. **Product Browsing**: Users can browse through a list of products, view detailed information, and see product images.
   > Note: This is a WIP
3. **Shopping Cart**: Users can add products to a shopping cart, view cart contents, and proceed to checkout.
   > Note: This is a WIP
4. **Auto-Scaling**: The application scales automatically in response to traffic load, ensuring efficient resource use and seamless user experience even during peak times.

## Getting Started
Clone the project.  
After cloning the repository, you'll need to install the dependencies for the server and the client separately:
1. **Server:** From the root directory of the project, run:

    ```
    npm install
    ```

2. **Client:** Navigate into the `client` directory, and run:

    ```
    cd client
    npm install
    ```

Now, both your server and client should have all the necessary dependencies installed. 

> Note: In this project, the server and client are treated as separate packages, each with their own `package.json` file. Hence, the need to `npm install` in each directory.

### Requirements
1. AWS account   
    - **AWS Access Key**  
    - **AWS Secret Access Key**  
    - **AWS EC2 Region**   
2. DockerHub Account
    - **DockerHub Username**
    - **DockerHub Token or Password**
3. Install the following dependencies (Use the latest. I used Homebrew for most of my MacOS installs)
   - **AWS CLI**
   - **Terraform for your OS**
   - **Docker**
   - **Kubernetes**

4. IDE   
   I use VSCode.

5. Set up AWS CLI by entering the AWS CLI configs.  
   ```
    export AWS_ACCESS_KEY=$AWS_ACCESS_KEY_ID  
    export AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY  
    export AWS_EC2_REGION=$AWS_DEFAULT_REGION
    ```    

### Infrastructure
The project is hosted on Amazon Web Services (AWS) and utilizes a variety of their offerings to deliver a robust, scalable solution:

- **VPC (Virtual Private Cloud)**: Provides the isolated, secure environment in which the application resides.

- **Subnets**: Used to logically separate different portions of the application for increased manageability and security.

- **Route Tables and Internet Gateways (IGWs)**: Handles routing and connectivity for the VPC.

- **Security Groups**: Used to define access rules for resources within the VPC.

- **Key Pair**: Provides secure, encrypted connection to EC2 instances when necessary.

- **Elastic Compute Cloud (EC2)**: The main compute service where the application server runs.

- **Elastic Load Balancer (ELB)**: Distributes incoming application traffic across multiple EC2 instances for better performance.

- **Auto Scaling Groups (ASGs)**: Automatically adjusts the number of EC2 instances in response to traffic patterns, ensuring the application has sufficient resources during peak times and saving money during off-peak times.

### Terraform Usage
- Type `terraform` in the terminal to view all Terraform commands.  
  - **To initialize a terraform configuration file (.tf)**:  `terraform init`  
  - **To validate the terraform configuration file and to check syntax**: `terraform validate`
  - **To create an execution plan using the configuration files**: `terraform plan`
  - **To run the plan you created**: `terraform apply`   
  You can execute terraform apply after initializing, it will create the plan before applying.            
  - **To view the resources created**: `terraform state list`  
  - **To destroy the resources you provisioned**: `terraform destroy`   
This will terminate/destroy all resources and prevent incurring unnecessary charges.

## Architecture Diagram

Directory Structure:
```
├── .circleci
   	├── config.yml
├── ansible
   	├── auto_scaling.yml
   	├── destroy.yml
   	├── dynamoDb.yml
	├── ec2.yml
	├── eks_cluster.yml
	├── elb.yml
	├── networking.yml
	├── s3.yml
├── client
   	├── node_modules
   	├── public
   	├── src
		├── components
			├── Contacts
				├── Contact.js
   			├── Footer
				├── Footer.js
   			├── Header
				├── Header.js
			├── HelloWorld
				├── HelloWorld.js
   			├── Home
				├── Home.js
   			├── Navigation.js
				├── Navigation.js
			├── ProductList
				├── ProductList.js
   			├── Shop
				├── Shop.js
   		├── App.cs
   		├── App.js
		├── App.test.js
   		├── index.css
   		├── index.js
		├── logo.svg
   		├── reportWebVitals.js
   		├── setupTests.js
	├── .dockerignore
   	├── frontend.dockerfile
   	├── .gitignore
   	├── package-lock.json
   	├── package.json
   	├── README.md
├── config
	├── config.js
├── data
	├── initialData.json
	├── populateData.js
├── db
   	├── index.js
   	├── dynamoDbUtils.js
   	├── productDb.js
├── e_com_products (jpg files in this directory)
├── node_modules
├── routes
	├── admin.js
	├── public.js
├── terraform
	├── cloudwatch
		├── main.tf
   	├── dynamodb
		├── main.tf
   	├── ec2
		├── main.tf
	├── eks
		├── main.tf
	├── elb
		├── elb.tf
	├── iam
		├── main.tf
	├── s3
		├── main.tf
	├── sns
		├── main.tf
	├── networking
		├── igw.tf
		├── key_pair.tf
		├── route_table.tf
   		├── sg_ec2.tf
   		├── sg_elb.tf
		├── subnet.tf
		├── vpc.tf
	├── backend.tf
   	├── provider.tf
	├── userData.sh
	├── main.tf
	├── outputs.tf
├── backend.dockerfile (for backend)
├── .dockerignore
├── .gitignore
├── Jenkinsfile
├── docker-compose.yml
├── package.json
├── package-lock.json 
└── server.js
```

## Future Improvements

Note: I have `Ansible Playbooks` and a `Jenkinsfile` also included in this project. I hope to create alternate methods for CI/CD and IaC in the future.


