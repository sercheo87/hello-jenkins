pipeline {
    environment {
        registry = "localhost:14441/novopayment/demo/node-web-app"
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
        stage('compile-postman-image') {
            steps {
                sh 'cd postman-test/postsman-builder && docker-compose build'
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.withRegistry( 'http://localhost:14441', registryCredential ) {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    }
                }
                echo "Building.. $WORKSPACE"
            }
        }
        stage('Run server test') {
            steps {
                sh 'docker-compose up -d'
                sh 'docker-compose logs'
                sh 'docker-compose logs app-hello-jenkins-test'
                sh 'ls -la .'
                sh 'ls -la postman-test/app-test'
                sh 'ls -la postman-test/app-test/report-postman'
            }
            post {
                always {
                    junit (testResults: '**/postman-report*.xml', allowEmptyResults: true)
                    archiveArtifacts(artifacts: '**/postman-report*.html', allowEmptyArchive: true)
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                   docker.withRegistry( 'http://localhost:14441', registryCredential ) {
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
    post {
        always {
             // sh 'docker-compose down'
            junit (testResults: '**/postman-report*.xml', allowEmptyResults: true)
            archiveArtifacts(artifacts: '**/postman-report*.html', allowEmptyArchive: true)
        }
    }
}
