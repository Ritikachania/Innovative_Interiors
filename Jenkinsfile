pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t my_django_app .'
            }
        }
        stage('Test') {
            steps {
                // Add your test commands here
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8000:8000 my_django_app'
            }
        }
    }
}

