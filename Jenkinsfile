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
        stage('Robot') {
                 sh 'robot --variable BROWSER:headlesschrome -d Results Tests'
        }
        post {
            always {
                script {
                    step()
                        [
                            $class                  :   'RobotPublisher',
                            outputPath              :   'results',
                            outputFileName          :   '**/output.xml',
                            reportFileName          :   '**/report.html',
                            logFileName             :   '**/log.html',
                            disableArchiveOutput    :   false,
                            passThreshold           :   50,
                            unstableThreshold       :   40,
                            otherFiles              :   "**/*.png,**/*.jpg",
                        ]
                }
            }
        }
    }
}