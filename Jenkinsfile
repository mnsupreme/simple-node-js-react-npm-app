pipeline {
    agent none
    environment { 
        CI = 'true'
    }
    stages {
        stage('Build') {
           agent {
                docker {
                    image 'node:6-alpine'
                    args '-p 3000:3000'
                }
            }
            steps {
                sh 'npm install'
            }
        }
        stage('SonarQube analysis') {
            agent {
                docker {
                    image 'openjdk'
                }
            }
            environment{
                scannerHome = tool 'test'
            }
            steps{
                sh 'ping 127.0.0.1:9000'
                withSonarQubeEnv('sonar') { 
                    sh "${scannerHome}/bin/sonar-scanner -X"
                }
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'node:6-alpine'
                    args '-p 3000:3000'
                }
            }
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver') { 
            agent {
                docker {
                    image 'node:6-alpine'
                    args '-p 3000:3000'
                }
            }
            steps {
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Finished using the web site? (Click "Proceed" to continue)' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}