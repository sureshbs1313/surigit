pipeline {
    agent any
    stages {
        stage ('Git-checkout') {
            steps {
                 git 'https://github.com/Strvsuri/PROJECT-K8S-TOMCAT.git'
            }        
        }
        stage (' build pro') {
            steps {
                sh 'mvn clean install'
            }
        } 
    }
}
