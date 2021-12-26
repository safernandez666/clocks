pipeline {

  environment {
    dockerimagename = "safernandez666/clock"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
 	      checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/safernandez666/clocks.git']]])
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'DockerHub'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
            dockerImage.push("$JOB_NAME-$BUILD_NUMBER")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(enableConfigSubstitution: true, configs: "deployment.yaml", kubeconfigId: "Okteto")
        }
      }
    }

  }

}