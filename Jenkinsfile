pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker { image 'node:14-alpine' }
            }
            steps {
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
                echo 'Deploying....'
            }
        }
    }
}
