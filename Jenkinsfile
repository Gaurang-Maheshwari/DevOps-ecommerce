pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Gaurang-Maheshwari/DevOps-ecommerce.git'
        BACKEND_DIR = 'server'
        FRONTEND_DIR = 'client'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "${REPO_URL}"
                echo 'Repository cloned successfully'
            }
        }
        stage('Install Backend Dependencies') {
            steps {
                dir("${BACKEND_DIR}") {
                    bat 'npm install'
                }
            }
        }
        stage('Install Frontend Dependencies') {
            steps {
                dir("${FRONTEND_DIR}") {
                    bat 'npm install'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                dir("${BACKEND_DIR}") {
                    bat 'npm test'  // Replace with actual test command if different
                }
                dir("${FRONTEND_DIR}") {
                    bat 'npm test'  // Replace with actual test command if different
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building the application...'
                dir("${FRONTEND_DIR}") {
                    bat 'npm run build'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Add deployment steps here
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
