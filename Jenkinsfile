pipeline {
  environment {
    dockerRegistry = 'dockerhub'
  }
  //agent any
  //agent {label 'kubejenkins'}
  
  agent {
    kubernetes {
      yaml """
                apiVersion: v1
                kind: Pod
                metadata:
                  labels:
                    label: jnlp
                spec:
                  securityContext:
                    runAsUser: 0
                  containers:
                  - name: jnlp
                    image: jenkins/inbound-agent:alpine
                    resources:
                      requests:
                        memory: "512Mi"
                        cpu: "100m"
                        ephemeral-storage: "2Gi"
                      limits:
                        memory: "1Gi"
                        cpu: "500m"
                        ephemeral-storage: "3Gi"
                    volumeMounts:
                    - name: dockersock
                      mountPath: "/var/run/docker.sock"
                  volumes:
                  - name: dockersock
                    hostPath:
                      path: /var/run/docker.sock
                """
    }
  } 
  stages {

      stage('Test the Source') {
        steps {
          git url:'https://github.com/josecarlosjr/nginx-controller-reverse-proxy.git', branch:'main'
          }
        }
    
    stage("Build image") {
            steps {
              echo "testing the environment"               
              sh 'cat /etc/os-release'      
              sh 'apk update'
              sh 'apk add --no-cache'              
              sh 'apk add py-pip python3-dev libffi-dev openssl-dev gcc libc-dev make'
              sh 'apk add openrc docker docker-compose'   
              sh 'rc-update add docker default'              
              //sh 'rc-service -I docker restart'              
             
                script {
                    //myapp = docker.build("josecarlosjr/hellowhale:${env.BUILD_ID}")
                    myapp = docker.build("josecarlosjr/nginx-controller-reverse-proxy")
                }
            }
      
        }
    stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                           // myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }
    
      
    stage('Erasing old Deployment') {
      steps {
       script {
    //       kubernetesDeploy(configs: "namespace.yaml", kubeconfigId: "kconfig")
           kubernetesDeploy(configs: "configmap.yaml", kubeconfigId: "kconfig", deleteResource: true)
           kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kconfig", deleteResource: true)
           kubernetesDeploy(configs: "service.yaml", kubeconfigId: "kconfig", deleteResource: true)
        }
      } 
    }  
     
    //stage('Deploy in K8S') {
    //    steps {
    //      script {
    //        kubernetesDeploy(configs: "namespace.yaml", kubeconfigId: "kconfig")
    //        kubernetesDeploy(configs: "configmap.yaml", kubeconfigId: "kconfig")
    //        kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kconfig")            
    //        kubernetesDeploy(configs: "service.yaml", kubeconfigId: "kconfig")
            
    //          }
    //        }
          }
    
    
    
  }
}
