pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "mvn compile"
                step(
                    [
                        $class          :       'JacocoPublisher',
                        execPattern     :       'target/*.exec',
                    ]
                )
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
                step(
                     [
                        $class          :       'JacocoPublisher',
                        execPattern     :       'target/*.exec',
                     ]
                )
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
            steps {
                sh 'robot --variable BROWSER:headlesschrome -d Results Tests'
            }
            post {
                always {
                    script {
                        step(
                            [
                                $class                  :   'RobotPublisher',
                                outputPath              :   'Results',
                                outputFileName          :   '**/output.xml',
                                reportFileName          :   '**/report.html',
                                logFileName             :   '**/log.html',
                                disableArchiveOutput    :   false,
                                passThreshold           :   50,
                                unstableThreshold       :   40,
                                otherFiles              :   "**/*.png,**/*.jpg",
                            ]
                        )
                    }
                }
            }
                 
        }
        
    }
}