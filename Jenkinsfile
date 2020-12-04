pipeline {

  //agent any
  agent {label 'kubejenkins'}
 // agent {
 //   kubernetes {
 //    yaml """
 //               apiVersion: v1
 //               kind: Pod
 //               metadata:
 //                 labels:
 //                   label: jnlp
 //               spec:
 //                 securityContext:
 //                   runAsUser: 0
 //                 containers:
 //                 - name: jnlp
 //                   image: jenkins/inbound-agent:alpine
 //                   resources:
 //                     requests:
 //                       memory: "512Mi"
 //                       cpu: "100m"
 //                       ephemeral-storage: "1Gi"
 //                     limits:
 //                       memory: "1Gi"
 //                       cpu: "500m"
 //                       ephemeral-storage: "2Gi"
 //                   volumeMounts:
 //                  - name: dockersock
 //                     mountPath: "/var/run/docker.sock"
 //                 volumes:
 //                 - name: dockersock
 //                   hostPath:
 //                     path: /var/run/docker.sock
 //               """
 //   }
 // } 
  stages {

      stage('Test the Source') {
        steps {
          git url:'https://github.com/josecarlosjr/nginx-controller-reverse-proxy.git', branch:'main'
          }
        }


      stage('Deploy in K8S') {
        steps {
          script {
            kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kconfig")
            kubernetesDeploy(configs: "configmap.yaml", kubeconfigId: "kconfig")
            kubernetesDeploy(configs: "service.yaml", kubeconfigId: "kconfig")
            kubernetesDeploy(configs: "ingress.yaml", kubeconfigId: "kconfig")
              }
            }
          }
  }
}
