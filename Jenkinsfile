pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 3000:3000'
        }
    }
    environment { 
        CI = 'true'
        scannerHome = tool 'test'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('SonarQube analysis') {
            agent{ 
                docker { 
                    image 'openjdk:11-alpine' 
                } 
            }
            steps{
                sh 'echo $JAVA_HOME'
                withSonarQubeEnv('sonar') { 
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage('Test') {
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