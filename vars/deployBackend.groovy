def call() {

    echo "Desplegando backend con Docker Compose"

    sh '''
        docker compose \
        -f jenkins/docker-compose.yml \
        down || true
    '''

    sh '''
        docker compose \
        -f jenkins/docker-compose.yml \
        pull || true
    '''

    sh '''
        docker compose \
        -f jenkins/docker-compose.yml \
        up -d --build
    '''

    sh '''
        docker compose \
        -f jenkins/docker-compose.yml \
        ps
    '''

    echo "Despliegue terminado"
}