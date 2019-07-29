node {
label 'slave 1' 
    withMaven(maven:'maven') {

        stage('Checkout') {
            git url: 'https://github.com/reshmigu/AtoBe_ver1.1.git', credentialsId: 'master', branch: 'test'
        }

		stage('Build') {
		    sh 'mvn package shade:shade'
            def pom = readMavenPom file:'pom.xml'
            env.version = pom.version
        }

        stage('Image') {
                sh 'docker stop restassured || true && docker rm restassured || true'
                cmd = "docker rmi restassured:${env.version} || true"
                sh cmd
                docker.build "restassured:${env.version}"
        }

        stage ('Run') {
         if ("${params.RunType}" == "DRY_RUN") {
              docker.image("restassured:${env.version}").run(' -h restassured --name restassured --net host').withRun( '--arg1 DRY_RUN ')
              
                
          }
          else if("${params.RunType}" == "RUN") {
            docker.image("restassured:${env.version}").run(' -h restassured --name restassured --net host')
          }
          else if("${params.RunType}" == "FULL_RUN") {
            docker.image("restassured:${env.version}").run(' -h restassured --name restassured --net host')
          }
        
            docker.image("restassured:${env.version}").run(' -h restassured --name restassured --net host')
        }

    }

}
