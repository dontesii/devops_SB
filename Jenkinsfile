pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        SUDO_PASS = credentials('PRIVATE')
    }


    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git branch: 'Task173', credentialsId: 'jenkins_ssh_key', url: 'git@github.com:dontesii/devops_SB.git'
                        }
                    }
                }
            }

        stage('Plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment} || terraform workspace new ${environment}'
                sh "terraform plan -input=false -out tfplan "
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
               not {
                    equals expected: true, actual: params.destroy
                }
           }

           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('AnsibleGit') {
            steps {
                git branch: 'Task167', credentialsId: 'jenkins_ssh_key', url: 'git@github.com:dontesii/devops_SB.git'
                dir('Task167') {
                    sh 'ansible-playbook Task.167.yml --private-key $PRIVATE'
                }
            }

                  stage("run ec2.py") {
            steps {
                sh "chmod +x ec2.py"
                sh "pwd"
                sh "./ec2.py --list"
            }
        }

       stage("Ansible") {
            steps {
               ansiblePlaybook become: true, becomeUser: 'root', credentialsId: 'MyKeyPair1', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'ec2.py', playbook: 'deploy.yml'
            }              
          }
        }

        stage('Apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
        
        stage('Destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
        
        steps {
           sh "terraform destroy --auto-approve"
        }
    }

  }
}