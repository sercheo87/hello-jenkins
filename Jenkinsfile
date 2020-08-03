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
                    args "-v $WORKSPACE:/hello-jenkins"
                }
            }
            steps {
                script {
                    sh "cp -a $(pwd)/*  /hello-jenkins"
                    sh 'cd /hello-jenkins && $(pwd) && ls -la .'
                    sh 'echo $(pwd)'
                    sh 'ls -la'
                    sh 'docker-compose up -d'
                    sh 'sleep 20'
                    sh 'docker-compose down'
                    sh 'ls -la postman-test/app-test'
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
