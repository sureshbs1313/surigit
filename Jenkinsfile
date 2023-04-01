pipeline {
    agent any
    stages {
        stage ('Git-checkout') {
            steps {
                 git 'https://github.com/Strvsuri/PROJECT-K8S-TOMCAT.git'
            }        
        }
        stage('build'){
        withMaven(maven: 'mvn') {
            sh "mvn clean package"
        }
    }
}
