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
                echo "Building.. $WORKSPACE"
            }
        }
        stage('Run server test') {
            agent {
                docker {
                    image 'nexussrv.com:14442/node:12'
                }
            }
            steps {
                sh 'npm start'
            }
        }
        stage('Run Postman') {
            agent {
                docker {
                    image 'nexussrv.com:14441/novopayment/tools/ci/postman-builder:1.0.0'
                }
            }
            steps {
                sh 'sleep 20'
                sh 'cd postman-test/app-test && sh run-postman.sh'
                sh 'ls -la .'
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
