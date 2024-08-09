pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'manalalkuraya/my-wiremock-server:latest'
        REGISTRY_CREDENTIALS = credentials('docker-hub-wiremock-server')
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ManalAlkuraya/build_wireMock_Project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh 'docker stop wiremock-server || true && docker rm wiremock-server || true'

                    // Run the new container
                    sh "docker run -d --name wiremock-server -p 8080:8080 ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
