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
            steps {
                script {
                    docker.withServer('http://nexussrv.com:14441', registryCredential) {
                        docker.image('docker/compose').withRun('-e DOCKER_HOST=tcp://jenkins-docker:2376') {
                            sh 'docker-compose up -d'
                        }
                    }
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
