node {
label 'slave 1' 
    withMaven(maven:'maven') {

        stage('Checkout') {
            git url: 'https://github.com/arunjohnsonthinkpalm/demo.git', credentialsId: 'myid', branch: 'test'
        }

		stage('Build') {
		    sh 'mvn package shade:shade'
            def pom = readMavenPom file:'pom.xml'
            env.version = pom.version
        }

        stage('Image') {
                sh 'docker stop demo || true && docker rm demo || true'
                cmd = "docker rmi demo:${env.version} || true"
                sh cmd
                docker.build "demo:${env.version}"
        }

        stage ('Run') {
         if ("${params.RunType}" == "DRY_RUN") {
              docker.image("demo:${env.version}").run(' -h demo --name demo --net host').withRun( '--arg1 DRY_RUN ')
              
                
          }
          else if("${params.RunType}" == "RUN") {
            docker.image("demo:${env.version}").run(' -h demo --name demo --net host')
          }
          else if("${params.RunType}" == "FULL_RUN") {
            docker.image("demo:${env.version}").run(' -h demo --name demo --net host')
          }
        
            docker.image("demo:${env.version}").run(' -h demo --name demo --net host')
        }

    }

}
