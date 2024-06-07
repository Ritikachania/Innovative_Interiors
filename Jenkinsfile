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
            }
        }
         stage('Set appDir') {
            steps {
                script {
                    // Use realpath to get the absolute path of the app directory within Innovative_Interiors
                    env.appDir = sh(script: 'realpath InnovativeInteriors', returnStdout: true).trim()
                    echo "App directory path: ${appDir}"
                    env.appDir = appDir // Set the environment variable
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                  sh "docker build -t 'my_django_app' \"${env.appDir}\""
                }
            }
        }
        stage('Verify Files in Docker Container') {
            steps {
                script {
                    docker.image('my_django_app').inside {
                        sh 'ls -la /app'
                        sh 'ls -la /app/InnovativeInteriors'
                    }
                }
            }
        }        
        stage('Run Tests') {
            steps {
                script {
                    docker.image('my_django_app').inside {
                        sh 'python /app/InnovativeInteriors/manage.py test'
                    }
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image('my_django_app').push('latest')
                    }
                }
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
        failure {
            script {
                echo 'Pipeline failed. Check the logs for details.'
            }
        }
    }
}

