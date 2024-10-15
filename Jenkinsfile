pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials-id', url: 'https://github.com/Gaurang-Maheshwari/DevOps-ecommerce.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'cd server && npm install'
                sh 'cd client && npm install'
            }
        }
        stage('Build Frontend') {
            steps {
                sh 'cd client && npm run build'
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: ['ec2-mern-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no mern-ecommerce@13.60.171.184  << EOF
                        cd /home/ec2-user/mern-ecommerce
                        git pull origin main
                        npm install --prefix server
                        npm install --prefix client
                        npm run build --prefix client
                        pm2 restart all
                    EOF
                    '''
                }
            }
        }
    }
}
