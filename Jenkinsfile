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
                echo 'Checkout version'
                git branch: 'master', url: 'https://github.com/sercheo87/hello-jenkins.git'
            }
        }
        stage('Build') {
            agent {
                docker { image 'node:14-alpine' }
            }
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
                echo 'Building..'
                sh 'node --version'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                script {
                   docker.withRegistry( '', registryCredential ) {
                   dockerImage.push()
               }
                echo 'Deploying....'
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
