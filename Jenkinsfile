pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my_django_app'
        REGISTRY_CREDENTIALS = 'dockerhub-credentials'
        GIT_CREDENTIALS = 'github-ssh-key' // This should match the ID you used
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Ritikachania/Innovative_Interiors.git', credentialsId: 'github-ssh-key'      

		}
	}
	stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my_django_app')
                }
            }
        }

        stage('Run Tests') {
            steps {
                sh 'python manage.py test'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/','dockerhub-credentials-id') {
                        docker.image('my_django_app').push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}

