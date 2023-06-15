pipeline {
  agent any
  stages {
    stage('Build Images') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          // Use DOCKER_USERNAME and DOCKER_PASSWORD to authenticate with DockerHub
          // Build and push Docker images
          // First build the docker images
          // get frontend dockerfile
          frontend = docker.build("rachelvf27/life2fullest-frontend")
          // get backend dockerfile
          backend = docker.build("rachelvf27/life2fullest-backend")
          // run docker compose up using docker-compose.yml
          sh 'docker compose up'
        }
      }
    }
    
    stage('Provision Resources') {
      steps {
        // Run Ansible playbooks
        sh 'ansible-playbook ansible/playbooks/networking.yml'
        sh 'ansible-playbook ansible/playbooks/s3.yml'
        sh 'ansible-playbook ansible/playbooks/dynamodb.yml'
        sh 'ansible-playbook ansible/playbooks/ec2.yml'
        sh 'ansible-playbook ansible/playbooks/elb.yml'
        sh 'ansible-playbook ansible/playbooks/auto_scaling.yml'
      }
    }

    stage('Deploy EKS Clusters') {
      steps {
        // Run Ansible playbooks
        sh 'ansible-playbook ansible/playbooks/eks_cluster.yml'
      }
    }
  }
}
