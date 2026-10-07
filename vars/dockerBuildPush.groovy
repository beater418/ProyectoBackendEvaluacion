def call(String image) {

    echo "Construyendo imagen Docker: ${image}"

    sh """
        docker build \
        -t ${image}:${env.BUILD_NUMBER} \
        -t ${image}:latest \
        .
    """

    withCredentials([
        usernamePassword(
            credentialsId: 'dockerhub',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_TOKEN'
        )
    ]) {

        sh '''
            echo "$DOCKER_TOKEN" | \
            docker login \
            -u "$DOCKER_USER" \
            --password-stdin
        '''

        sh """
            docker push ${image}:${env.BUILD_NUMBER}
            docker push ${image}:latest
        """
    }

    echo "Imagen publicada correctamente en DockerHub"
}