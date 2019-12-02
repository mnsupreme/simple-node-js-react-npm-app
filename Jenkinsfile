pipeline {
    agent none
    environment { 
        CI = 'true'
    }
    stages {
        stage('Build') {
            agent { docker 'node:6-alpine' }
            steps {
                sh 'npm install'
            }
        }
        stage('SonarQube analysis') {
            agent{ 
                docker 'openjdk:12-alpine' 
            }
            steps{
                script {
                    scannerHome = tool 'SonarQube Scanner';

                }
                withSonarQubeEnv('sonar') { 
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage('Test') {
            agent { docker 'node:6-alpine' }
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Finished using the web site? (Click "Proceed" to continue)' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}