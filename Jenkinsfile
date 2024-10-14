pipeline {
    agent any
    
    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the GitHub repository
                git credentialsId: 'github-user-pass', url: 'https://github.com/Gaurang-Maheshwari/DevOps-ecommerce.git', branch: 'main'
            }
        }

        stage('Install Backend Dependencies') {
            steps {
                dir('server') {
                    sh 'npm install'
                }
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                dir('client') {
                    sh 'npm install'
                }
            }
        }

        stage('Test (Placeholder)') {
            steps {
                echo 'Running Tests (To be implemented)...'
                // Example: sh 'npm test' (Add actual test command later)
            }
        }

        stage('Build (Placeholder)') {
            steps {
                echo 'Building Application (To be implemented)...'
                // Example: sh 'npm run build' (Add actual build command later)
            }
        }

        stage('Deploy (Placeholder)') {
            steps {
                echo 'Deploying Application (To be implemented)...'
                // Example: sh './deploy.sh' (Add actual deploy command later)
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
