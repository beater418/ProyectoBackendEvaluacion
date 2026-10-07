@Library('devops-shared-library') _

pipeline {

    agent any

    parameters {
        string(
            name: 'SERVER_IP',
            defaultValue: '167.71.153.34',
            description: 'IP publica del servidor DigitalOcean creado con Terraform'
        )
    }

    environment {
        IMAGE = 'dantito/proyecto-backend'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Descargando proyecto desde GitHub'
                checkout scm
            }
        }

        stage('Validar servidor') {
            steps {
                script {
                    if (!params.SERVER_IP?.trim()) {
                        error('Debes ingresar SERVER_IP')
                    }

                    echo "Servidor destino: ${params.SERVER_IP}"
                }
            }
        }

        stage('Verificar Docker') {
            steps {
                sh 'docker --version'
                sh 'docker compose version'
            }
        }

        stage('Build and Push') {
            steps {
                script {
                    dockerBuildPush(env.IMAGE)
                }
            }
        }

        stage('Deploy Cloud') {
            steps {
                script {
                    deployBackend(params.SERVER_IP)
                }
            }
        }

        stage('Verify Cloud') {
            steps {
                sh 'sleep 15'
                sh "curl -f http://${params.SERVER_IP}:3000/"
            }
        }
    }

    post {

        success {
            echo 'Pipeline cloud ejecutado correctamente'
        }

        failure {
            echo 'Pipeline cloud fallo'
        }
    }
}