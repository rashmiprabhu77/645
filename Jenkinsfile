pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('Docker_Cred') 
        GIT_REPO = 'https://github.com/rashmiprabhu77/645' 
        DOCKER_IMAGE_NAME = 'rashmi77/swe645h2' 
        TIMESTAMP = new Date().format('yyyyMMdd-HHmmss')
        KUBE_CONFIG = 'Kubeconfig'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build and tag the Docker image
                    def dockerImage = "${DOCKER_IMAGE_NAME}:${TIMESTAMP}"
                    sh "docker build -t ${dockerImage} ."
                }
            }
        }
            
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    def dockerImage = "${DOCKER_IMAGE_NAME}:${TIMESTAMP}"
                    withCredentials([usernamePassword(credentialsId: 'Docker_Cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "docker login -u rashmi77 -p dckr_pat_qHgBZd73wVpcmPqKUWeZ6NN8Mvo"
                    }

                    sh "docker push ${dockerImage}"
                }
            }
        }

        stage('Update Kubernetes Deployment') {
            steps {
                script {
                    withCredentials([file(credentialsId: "$KUBE_CONFIG", variable: 'KUBECONFIG')]) {
                        sh "kubectl set image deployment/swe645h2 swe645h2_container=${DOCKER_IMAGE_NAME}:${TIMESTAMP} --all"
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Jenkins Pipeline executed successfully!'
        }
        failure {
            echo 'Jenkins Pipeline failed!'
        }
    }
}
