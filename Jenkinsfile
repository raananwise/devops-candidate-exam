pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                sh '''
                    cd /var/lib/jenkins/workspace/DevOps_Play_Avi
                    dir 
                    terraform --version
                    aws --version
                    terraform init
                '''
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
                sh '''
                    cd /var/lib/jenkins/workspace/DevOps_Play_Avi
                    terraform validate
                '''
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                sh '''
                    cd /var/lib/jenkins/workspace/DevOps_Play_Avi
                    terraform plan
                '''
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
            }
        }
    }
}
