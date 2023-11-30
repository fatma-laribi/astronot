pipeline {
  agent any 
  tools{
    nodejs "node"
    terraform "terraform"
  }     
  stages{

      
    
       stage('Clone') {
          
    // Clones the repository from the current branch name
    
    steps{
   sh'terraform --version'
        echo 'Make the output directory'
    sh 'mkdir -p build'
    
   
    dir('build') {
        git branch: 'main', url: 'https://github.com/SoulaimakH/astronot-angular.git'
    }  
     }
     
  } 
  
    stage('install node modules'){
     steps{
          dir('build') {
              
            sh "npm install"
              
    }  
       
     }
        
    }
     
  
          
        stage('build'){
         steps{
              dir('build') {
                   
           sh "npm run ng build --prod"}
              
         } 
        }
        
        
        stage('Test'){
             steps{
            sh "echo 'test'"}
        }

    
    stage('Terraform init') {
            steps {
                sh 'terraform init'
              sh'terraform plan'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }

    
         
    
 
 
 
        
  }
}
