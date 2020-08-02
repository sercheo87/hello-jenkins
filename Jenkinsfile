pipeline {
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
                echo 'Building..'
                sh 'node --version'
            }
        }
        stage('Generate Image') {
            steps {
                echo 'Generate images...'
                sh 'docker build -t nexussrv.com:14441/node-web-app .'
                sh 'docker push nexussrv.com:14441/node-web-app'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
