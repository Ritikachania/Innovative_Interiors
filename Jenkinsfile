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
                git branch: 'main', url: 'https://github.com/Ritikachania/Innovative_Interiors.git', credentialsId: 'github-ssh-key'
            }
        }
        stage('List Directory') {
            steps {
                sh 'ls -la'
                sh 'ls -la InnovativeInteriors'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def appDir = '.' // Adjust this path if needed
                    sh "docker build -t ${DOCKER_IMAGE} ${appDir}"
                }
            }
        }
        stage('Verify Files in Docker Container') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside {
                        sh 'ls -la /app'
                        sh 'ls -la /app/InnovativeInteriors'
                    }
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside {
                        sh 'python /app/InnovativeInteriors/manage.py test'
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
        }
        stage('Deploy') {
            steps {
                sh './jenkins_deploy_prod_docker.sh'
            }
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
    }
}
