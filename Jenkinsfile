pipeline {
    agent any
    stages {
        stage (' git checkout') {
            steps {
                git 'https://github.com/Strvsuri/VALAXY-hello-world.git'
            }
        }
        stage (' build pro') {
            steps {
                sh 'mvn clean install'
            }
        }   
        stage (' deployment') {
            steps {
                sshagent(['tomcat']) {
                    sh 'scp -o StrictHostKeyChecking=no webapp/target/webapp.war ubuntu@44.202.116.126:/opt/tomcat/webapps'
                }                  
            }
        }        
    }
}
