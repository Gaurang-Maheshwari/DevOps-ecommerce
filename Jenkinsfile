pipeline {
    agent any 

    environment {
        // Define your registry URL and credentials here
        REGISTRY_URL = 'docker.io/gaurang09' // Change to your Docker registry URL (e.g., 'docker.io/username' or 'gcr.io/project-id')
        IMAGE_NAME = 'mern-client-image' // Change to your image name (e.g., 'my-app')
        KUBE_CONFIG = '/path/to/kubeconfig' // Change to the path of your kubeconfig file on the Jenkins server
        SONARQUBE_URL = 'http://sonarqube:9000' // Change to your SonarQube server address
        SONAR_PROJECT_KEY = 'mern-ecommerce' // Change to your SonarQube project key
        ELK_LOG_PATH = '/logs' // Change to your application log path if needed
        ELK_NAMESPACE = '<your-elk-namespace>' // Change to your ELK Kubernetes namespace
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone your Git repository
                git url: 'https://github.com/Gaurang-Maheshwari/DevOps-ecommerce.git' // Change to your Git repository URL
            }
        }

        stage('Install Dependencies and Start Applications') {
            steps {
                script {
                    // Install dependencies and start the client and server
                    dir('client') {
                        if (fileExists('package.json')) {
                            sh 'npm install'
                            // Start the client application
                            sh 'npm start &'
                        } else {
                            echo 'Client folder does not exist. Skipping npm install and start for the client.'
                        }
                    }

                    dir('server') {
                        if (fileExists('package.json')) {
                            sh 'npm install'
                            // Start the server application
                            sh 'npm start &'
                        } else {
                            echo 'Server folder does not exist. Skipping npm install and start for the server.'
                        }
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t gaurang09/mern-client-server:latest ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker registry and push the image
                    withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "echo $PASSWORD | docker login ${REGISTRY_URL} -u $USERNAME --password-stdin"
                        sh "docker push ${REGISTRY_URL}/mern-client-image:latest"
                    }
                }
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                    // Run SonarQube scanner for static code analysis
                    withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                        sh "sonar-scanner -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.host.url=${SONARQUBE_URL} -Dsonar.login=${SONAR_TOKEN}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy the application to Kubernetes
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} apply -f k8s/deployment.yaml"
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} apply -f k8s/service.yaml" // Assuming you have a service definition
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    // Wait for deployment to be ready
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} rollout status deployment/${IMAGE_NAME} --namespace=<your-namespace>" // Change to your Kubernetes namespace
                }
            }
        }

        stage('Set Up ELK Stack') {
            steps {
                script {
                    // Deploy Elasticsearch, Logstash, and Kibana
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} apply -f k8s/elk/elasticsearch.yaml --namespace=${ELK_NAMESPACE}"
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} apply -f k8s/elk/logstash.yaml --namespace=${ELK_NAMESPACE}"
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} apply -f k8s/elk/kibana.yaml --namespace=${ELK_NAMESPACE}"
                }
            }
        }

        stage('Configure Application Logging') {
            steps {
                script {
                    // Assuming your application is configured to output logs to a specific directory
                    sh """
                    kubectl --kubeconfig=${KUBE_CONFIG} exec -it <your-pod-name> --namespace=<your-namespace> -- bash -c 'echo "Logging to ${ELK_LOG_PATH}"'
                    """ // Change <your-pod-name> and <your-namespace> accordingly
                }
            }
        }

        stage('Access Kibana Dashboard') {
            steps {
                script {
                    // Port-forward Kibana service to access the dashboard locally
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} port-forward service/kibana --namespace=${ELK_NAMESPACE} 5601:5601 &" // Port-forward Kibana
                    sleep(10) // Wait for port-forwarding to establish
                    echo "Access Kibana at http://localhost:5601"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
