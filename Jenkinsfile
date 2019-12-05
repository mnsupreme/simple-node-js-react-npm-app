pipeline {
    agent none
    environment { 
        CI = 'true'
        scannerHome = tool 'test'
    }
    stages {
        stage('Build') {
            agent { docker { image 'node:6-alpine' } }
            steps {
                sh 'npm install'
            }
        }
        stage('SonarQube analysis') {
            agent{ 
                docker { 
                    image 'openjdk'
                    args '--privileged' 
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
            agent { docker { image 'node:6-alpine' } }
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver') {
            agent { docker { image'node:6-alpine' } } 
            steps {
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Finished using the web site? (Click "Proceed" to continue)' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}