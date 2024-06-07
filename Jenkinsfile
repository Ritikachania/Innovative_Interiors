pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my_django_app'
        REGISTRY_CREDENTIALS = 'dockerhub-credentials-id'
        GIT_CREDENTIALS = 'github-ssh-key'
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', git url: 'https://github.com/Ritikachania/Innovative_Interiors.git', credentialsId: 'github-ssh-key'
            }
        }
        stage('List Directory') {
            steps {
                sh 'ls -la'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def appDir = 'mywebapp' // Ensure this path is correct relative to the workspace
                    sh "docker build -t my_django_app  ${appDir}"
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    sh "docker run --rm (my_django_app)python manage.py test"
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image('my_django_app').push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }
    }
    post {
        failure {
            script {
                echo 'Pipeline failed. Check the logs for details.'
            }
        }
    }
}

