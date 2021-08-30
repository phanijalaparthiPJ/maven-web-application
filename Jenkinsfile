node
{
def mavenHome = tool name: "maven3.8.2"
/*
echo "GitHub BranchName ${env.BRANCH_NAME}"
echo "Jenkins Job Number ${env.BUILD_NUMBER}"
echo "Jenkins Node Name ${env.NODE_NAME}"

echo "Jenkins Home ${env.JENKINS_HOME}"
echo "Jenkins URL ${env.JENKINS_URL}"
echo "JOB Name ${env.JOB_NAME}"
*/

 properties([
      buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], 
      pipelineTriggers([
      //cron('* * * * * '), 
      //githubPush(), 
      pollSCM('* * * * *')
      ])
      ])
  timestams(){
stage('checkoutocode')
{
git branch: 'development', credentialsId: 'bc8c0969-6bab-43f9-990d-9e4dd376ad45', 
url: 'https://github.com/phanijalaparthiPJ/maven-web-application.git'
 }
stage('Build') 	
{
sh "${mavenHome}/bin/mvn clean package"
}
 stage('SonarQubeReport')
{
sh "${mavenHome}/bin/mvn clean sonar:sonar"
}
stage('UploadArtifactReportIntoNexus')
{
sh "${mavenHome}/bin/mvn clean deploy"
}
stage('DeployApplicationIntoTomcatserver')
{  
sshagent(['fd7391ca-785d-4b44-aaef-004929bb9e66']) {
sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@52.66.239.174:/opt/apache-tomcat-9.0.52/webapps/"
}    
}

stage('EmailNotification')
{
emailext body: '''Build over & build success..!



Regard,
phanijalaparthi,
9652559975.
''', subject: 'Build over..!!', to: 'phanichowdary1912@gmail.com'
}	
}
}
