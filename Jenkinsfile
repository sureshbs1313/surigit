pipeline {
    agent any
    environment {
        PATH = "/opt/maven/bin:${PATH}"
    }
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
        stage ('copying artifact') {
            steps {
                sshagent(['687a60ca-45ca-4284-945e-3a0fd25af5ee']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97'
                    sh 'scp webapp/target/webapp.war ubuntu@172.31.83.97:/opt'
                    sh 'scp Dockerfile ubuntu@172.31.83.97:/opt'
                }
            }
        }
        stage ('Building docker image') {
           steps {
                sshagent(['687a60ca-45ca-4284-945e-3a0fd25af5ee']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 docker image build -t $JOB_NAME:v1.$BUILD_ID /opt'
                }
            }
        }
        stage ('docker image tagging') {
            steps {
                sshagent(['687a60ca-45ca-4284-945e-3a0fd25af5ee']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 cd /opt'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 docker tag $JOB_NAME:v1.$BUILD_ID suribau/$JOB_NAME:v1.$BUILD_ID'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 docker tag $JOB_NAME:v1.$BUILD_ID suribau/$JOB_NAME:v1.latest'
                }
            }
        }
        stage ('Docker image push') {
            steps {
                sshagent(['687a60ca-45ca-4284-945e-3a0fd25af5ee']) {
                    withCredentials([usernameColonPassword(credentialsId: 'Dockerhub', variable: 'Dockerregistry')]) {
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 docker image push suribau/$JOB_NAME:v1.$BUILD_ID'
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 docker image push suribau/$JOB_NAME:v1.latest'
                    }
                }
            }
        }
        stage ('k8s Deploy') {
            steps {
                sshagent(['687a60ca-45ca-4284-945e-3a0fd25af5ee']) {
                    withCredentials([usernameColonPassword(credentialsId: 'Dockerhub', variable: 'Dockerregistry')]) {
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97'
                        sh 'scp Deployment.yml ubuntu@172.31.83.97:/opt'
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.83.97 sudo kubectl apply -f Deployment.yml'
                    }
                }
            }
        }
    }
}
