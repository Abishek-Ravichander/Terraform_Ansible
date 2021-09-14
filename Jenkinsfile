pipeline {
environment {
        
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
         stage('Vault - AWS connection check') {
            steps {
                withCredentials([vaultString(credentialsId: 'AWS_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                       sh '''
                        aws --version
                        aws ec2 describe-instances
                        '''
}
            }
        }
        stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/Abishek-Ravichander/Terraform_Ansible.git"
                        
                    }
                }
            }       
                                                           
        stage('Terraform Plan') {
            steps {
                     withCredentials([vaultString(credentialsId: 'AWS_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat 'cd&cd terraform/Terraform_Ansible & terraform init -input=false'
                bat 'cd&cd terraform/Terraform_Ansible & terraform destroy -auto-approve'
                bat "cd&cd terraform/Terraform_Ansible & terraform plan -input=false -out tfplan"
                bat 'cd&cd terraform/Terraform_Ansible & terraform show -no-color tfplan > tfplan.txt'
                     }
            }
        }
       

        stage('Terraform Apply') {
            steps {
                    withCredentials([vaultString(credentialsId: 'AWS_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat "cd&cd terraform/Terraform_Ansible & terraform apply -input=false tfplan"
                    }
            }
        }
       
        
        }
   }
