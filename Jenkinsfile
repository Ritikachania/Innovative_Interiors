pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my_django_app'
        REGISTRY_CREDENTIALS = 'dockerhub_credentials'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'git@github.com:Ritikachania/Innovative_Interiors.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside {
                        sh 'python manage.py test'
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry(DOCKER_REGISTRY_URL, REGISTRY_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Add your deployment steps here, e.g., using kubectl, ansible, etc.
                    echo 'Deploying application...'
                }
            }
        }
    }
}

