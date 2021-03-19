pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "mvn compile"
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }

        }
        stage('Newman') {
            steps {
                sh 'newman run RestfulBooker.postman_collection.json --environment RestfulBooker.postman_environment.json -- reporters junit'
            }
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }

        }
    }
}