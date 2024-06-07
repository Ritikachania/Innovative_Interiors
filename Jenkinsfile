pipeline {
    agent any

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Ritikachania/Innovative_Interiors.git', credentialsId: 'github-ssh-key'
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
                    sh 'docker build -t my_django_app .'
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    // Ensure the correct working directory is used
                    sh 'docker run --rm -w /app/InnovativeInteriors/myproject my_django_app python manage.py test'
                }
            }
        }
        stage('Push to Docker Hub') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Add your Docker Hub credentials and push logic here
                    echo 'Pushing Docker image to Docker Hub...'
                }
            }
        }
        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Add your deployment steps here
                    echo 'Deploying application...'
                }
            }
        }
    }
    post {
        always {
            script {
                echo 'Pipeline completed.'
            }
        }
        failure {
            script {
                echo 'Pipeline failed. Check the logs for details.'
            }
        }
    }
}
