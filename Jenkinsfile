pipeline {
    environment {
        registry = "nexussrv.com:14441/novopayment/demo/node-web-app"
        registryCredential = 'nexus-private'
        dockerImage = ''
    }

    agent any

    stages {
        stage('Checkout') {
            steps {
                deleteDir()
                echo 'Checkout version'
                git branch: 'master', url: 'https://github.com/sercheo87/hello-jenkins.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.withRegistry( 'http://nexussrv.com:14441', registryCredential ) {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    }
                }
                echo 'Building..'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'docker/compose'
                    args '-e DOCKER_HOST=unix://jenkins-docker:2376 -e DOCKER_TLS_VERIFY=0 -e DOCKER_CERT_PATH=/certs/client -v /certs/client:/certs/client:ro'
                }
            }
            steps {
                script {
                    sh 'docker-compose up -d'
                }

                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                script {
                   docker.withRegistry( 'http://nexussrv.com:14441', registryCredential ) {
                    dockerImage.push()
                   }
                }
                echo 'Deploying....'
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
