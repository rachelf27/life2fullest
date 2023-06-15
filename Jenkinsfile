pipeline {
  agent any
  stages {
    stage('Build Images') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          // Use DOCKER_USERNAME and DOCKER_PASSWORD to authenticate with DockerHub
          // First pull the latest frontend image
          docker.image("rachelvf27/life2fullest-frontend").pull()
          // Build the frontend docker image
          frontend = docker.build("rachelvf27/life2fullest-frontend")
          // Pull the latest backend image
          docker.image("rachelvf27/life2fullest-backend").pull()
          // Build the backend docker image
          backend = docker.build("rachelvf27/life2fullest-backend")
          // Run docker compose up using docker-compose.yml
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
