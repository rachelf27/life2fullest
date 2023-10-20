# Full Stack E-Commerce Platform with Auto-Scaling

This project implements a scalable full-stack e-commerce platform utilizing cloud-based technologies.   

## Project Overview
This e-commerce platform focuses on displaying a variety of products for users. While it lays the groundwork for user management and shopping cart functionalities, these features are currently in the developmental phase.

## Technologies Used

- **Front-End**: React.js
- **Back-End**: Node.js / Express.js
- **Database**: AWS DynamoDB
- **Storage**: AWS S3 for storing product images
- **Infrastructure**: AWS with EKS for managed Kubernetes
- **Configuration Management**: Terraform for Infrastructure as Code (IaC)
- **Containerization and Orchestration**: Docker and Kubernetes
- **Continuous Integration/Continuous Deployment (CI/CD)**: CircleCI
- **Version Control**: Git & GitHub

## Features

1. **Product Browsing**: Users can browse through a list of products, view details and images.
2. **Auto-Scaling**: The application scales automatically with AWS EKS, for smoother user experience during traffic surges.  

## Getting Started
Clone the project and follow the steps below:  

1. **Server:**  In the root directory, run:  
	```
    npm install
    ```

2. **Client:** Move to the client directory, then run:
    ```
    cd client
    npm install
    ```

### Requirements
1. AWS account   
    - **AWS Access Key**  
    - **AWS Secret Access Key**  
    - **AWS EC2 Region**   
2. DockerHub Account
    - **DockerHub Username**
    - **DockerHub Token or Password**
3. Tools (latest versions recommended):
   - **AWS CLI**
   - **Terraform**
   - **Docker**
   - **Kubernetes**

4. IDE (VSCode or other)

5.AWS CLI Setup: 
```
	export AWS_ACCESS_KEY=$AWS_ACCESS_KEY_ID  
    export AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY  
    export AWS_EC2_REGION=$AWS_DEFAULT_REGION
```

### Infrastructure
This project leverages AWS services, focusing on VPC for network isolation, S3 for storage, and EKS for container orchestration:  

- **VPC (Virtual Private Cloud)**
- **Subnets**
- **Route Tables and Internet Gateways (IGWs)**
- **Security Groups**
- **DynamoDB**
- **EKS (Elastic Kubernetes Service)**

### Terraform Usage
Use terraform to manage your infrastructure:  
  - **Initialize**:  `terraform init`  
  - **Validate**: `terraform validate`
  - **Plan**: `terraform plan`
  - **Apply**: `terraform apply`              
  - **View**: `terraform state list`  
  - **Destroy**: `terraform destroy`   
  
Note: terraform apply initializes and plans before applying.

## Directory Structure:
```
➜  life2fullest git:(develop) ✗ tree -I 'node_modules|life2fullest.code-workspace|package-lock.json|public'
.
├── README.md
├── backend.dockerfile
├── client
│   ├── README.md
│   ├── client
│   ├── frontend.dockerfile
│   ├── package.json
│   └── src
│       ├── App.css
│       ├── App.js
│       ├── App.test.js
│       ├── components
│       │   ├── Contact
│       │   │   └── Contact.js
│       │   ├── Footer
│       │   │   └── Footer.js
│       │   ├── Header
│       │   │   └── Header.js
│       │   ├── Home
│       │   │   └── Home.js
│       │   ├── Navigation
│       │   │   └── Navigation.js
│       │   ├── ProductList
│       │   │   └── ProductList.js
│       │   └── Shop
│       │       └── Shop.js
│       ├── index.css
│       ├── index.js
│       ├── logo.svg
│       ├── reportWebVitals.js
│       └── setupTests.js
├── config
│   └── config.js
├── data
│   ├── initialData.json
│   └── populateData.js
├── db
│   ├── dynamoDbUtils.js
│   ├── index.js
│   └── productDb.js
├── docker-compose.yml
├── e_com_products
│   ├── BaileyPainting.jpg
│   ├── BeachPainting.jpg
│   ├── BeautySoaps.jpg
│   ├── BeeSoaps.jpg
│   ├── BodyScrubs.jpg
│   ├── CatPainting.jpg
│   ├── CharcoalSoaps.jpg
│   ├── ChristmasCandles.jpg
│   ├── EpsomSaltNCoconutSoaps.jpg
│   ├── PrettyTinCandles.jpg
│   ├── RelaxCandle.JPG
│   ├── SoapVarietyBundle.jpg
│   ├── SpaEyePillows.JPG
│   ├── SunrisePainting.JPG
│   └── TallEucalyptusCandle.jpg
├── k8s
│   ├── backend-deployment.yaml
│   └── frontend-deployment.yaml
├── kubectl
├── package.json
├── routes
│   ├── admin.js
│   ├── home.js
│   └── public.js
├── server.js
└── terraform
    ├── backend.tf
    ├── cloudwatch
    │   └── main.tf
    ├── dynamodb
    │   └── main.tf
    ├── ecom_app_key.pem
    ├── eks
    │   └── main.tf
    ├── iam
    │   └── main.tf
    ├── main.tf
    ├── networking
    │   ├── igw.tf
    │   ├── key_pair.tf
    │   ├── route_table.tf
    │   ├── sg_cluster.tf
    │   ├── sg_nodes.tf
    │   ├── subnet.tf
    │   ├── vpc.tf
    │   └── vpc_endpoints.tf
    ├── outputs.tf
    ├── provider.tf
    ├── s3
    │   └── main.tf
    ├── sns
    │   └── main.tf
    ├── userData.sh
    └── variables.tf
```

## Future Improvements
- User Management: Enable user registration, login, and profile management.
- Shopping Cart: Allow users to add products to cart, view cart contents, and checkout.
- Admin Routes: Integrate admin routes for product management.
