pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'Descargando proyecto desde GitHub'
                checkout scm
            }
        }stage('Verificar archivos') {
            steps {
                echo 'Listando archivos del proyecto'
                sh 'ls -la'
            }
        }stage('Construir imagen') {
            steps {
                echo 'Construyendo imagen Docker'
                sh 'docker build -t dantito/proyecto-backend:latest .'
            }
        }stage('Desplegar') {
            steps {
                echo 'Levantando proyecto con Docker Compose'
                sh '''
                    docker compose -f jenkins/docker-compose.yml down || true
                    docker compose -f jenkins/docker-compose.yml up -d
                '''
            }
        }stage('Verificar') {
            steps {
                echo 'Verificando contenedores'
                sh 'docker ps'
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