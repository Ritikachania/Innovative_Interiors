pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_URL = 'your-docker-registry-url'
        DOCKER_REGISTRY_CREDENTIALS = 'your-docker-registry-credentials'
        IMAGE_NAME = 'my-docker-image'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG}.'
            }
        }

        stage('Push') {
            steps {
                withDockerRegistry(credentialsId: DOCKER_REGISTRY_CREDENTIALS, url: DOCKER_REGISTRY_URL) {
                    sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }
    }
}
