@Library('devops-shared-library') _
pipeline {
    agent any
    environment {
        IMAGE = 'dantito/proyecto-backend'
    }stages {
        stage('Checkout') {
            steps {
                echo 'Descargando proyecto desde GitHub'
                checkout scm
            }
        }stage('Verificar Docker') {
            steps {
                sh 'docker --version'
                sh 'docker compose version'
            }
        }stage('Build and Push') {
            steps {
                script {
                    dockerBuildPush(env.IMAGE)
                }
            }
        }stage('Deploy') {
            steps {
                script {
                    deployBackend()
                }
            }
        }stage('Verify') {
            steps {
                sh 'sleep 10'
                sh 'docker ps'
                sh 'curl -f http://localhost:3000/'
            }
        }
    }post {
        success {
            echo 'Pipeline ejecutado correctamente'
        }
        failure {
            echo 'Pipeline fallo'
        }
    }
}