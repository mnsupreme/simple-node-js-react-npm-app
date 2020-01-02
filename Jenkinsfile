pipeline {
    agent {
        label 'master'
    }
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
                    image 'maven'
                }
            }
            environment{
                scannerHome = tool 'test'
            }
            steps{
                sh 'cat /etc/os-release'
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
                sh 'npm install'
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
                sh 'npm install'
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Finished using the web site? (Click "Proceed" to continue)' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}