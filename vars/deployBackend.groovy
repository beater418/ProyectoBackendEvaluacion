def call(String serverIp) {

    echo "Desplegando backend en DigitalOcean: ${serverIp}"

    withEnv(["CLOUD_SERVER_IP=${serverIp}"]) {

        withCredentials([
            sshUserPrivateKey(
                credentialsId: 'cloud-server-ssh',
                keyFileVariable: 'SSH_KEY',
                usernameVariable: 'SSH_USER'
            )
        ]) {

            sh '''
                CLEAN_KEY=$(mktemp)

                tr -d '\\r' < "$SSH_KEY" > "$CLEAN_KEY"

                chmod 600 "$CLEAN_KEY"

                ssh \
                  -o StrictHostKeyChecking=no \
                  -i "$CLEAN_KEY" \
                  "$SSH_USER@$CLOUD_SERVER_IP" \
                  "if [ ! -d /opt/ProyectoBackendEvaluacion/.git ]; then
                       git clone --branch jenkins https://github.com/beater418/ProyectoBackendEvaluacion.git /opt/ProyectoBackendEvaluacion;
                   else
                       cd /opt/ProyectoBackendEvaluacion &&
                       git fetch origin &&
                       git checkout jenkins &&
                       git reset --hard origin/jenkins;
                   fi &&
                   cd /opt/ProyectoBackendEvaluacion &&
                   docker compose -f jenkins/docker-compose.yml pull &&
                   docker compose -f jenkins/docker-compose.yml up -d --build &&
                   docker compose -f jenkins/docker-compose.yml ps"

                RESULT=$?

                rm -f "$CLEAN_KEY"

                exit $RESULT
            '''
        }
    }

    echo "Despliegue cloud completado"
}