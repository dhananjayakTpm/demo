node {
label 'slave 1' 
    withMaven(maven:'maven') {

        stage('Checkout') {
            git url: 'https://github.com/arunjohnsonthinkpalm/demo.git', credentialsId: 'myid', branch: 'master'
        }

		stage('Build') {
            bat 'mvn clean install'
            def pom = readMavenPom file:'pom.xml'
            env.version = pom.version
        }

        stage('Image') {
                bat 'docker stop demo || exit 0'
				bat 'docker rm demo || exit 0'
                cmd = "docker rmi demo:${env.version} || exit 0"
                bat cmd
                bat "docker build -t demo:${env.version} ."
            
        }

        stage ('Run') {
        print "${params}"
         if ("${params.modes}" == "DRY_RUN") {
       		 bat "docker run -p 8081:8081 -h demo --name demo --net host -m=500m demo:${env.version} DRY_RUN"
          }
          else if("${params.modes}" == "RUN") {
	   		 bat "docker run -p 8081:8081 -h demo --name demo --net host -m=500m demo:${env.version} RUN"
          }
          else if("${params.modes}" == "FULL_RUN") {
	   		 bat "docker run -p 8081:8081 -h demo --name demo --net host -m=500m demo:${env.version} FULL_RUN"
          }
          
        
        }

    }

}
