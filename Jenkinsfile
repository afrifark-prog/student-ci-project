// Optional: Pipeline-job equivalent of the Freestyle job.
// The main submission uses a Freestyle job named Student-CI-Project.
pipeline {
    agent any
    triggers {
        githubPush()
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and Test') {
            steps {
                sh 'sh ./build.sh'
            }
        }
    }
    post {
        success { echo 'Build succeeded: all tests passed.' }
        failure { echo 'Build failed: check the test output above.' }
    }
}
