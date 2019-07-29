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
        print "${params.Modes}"
         if ("${params.Modes}" == "DRY_RUN") {
       		 bat "docker run -p 8081:8081 -h restassured --name restassured --net host -m=500m restassured:${env.version} DRY_RUN"
          }
          else if("${params.Modes}" == "RUN") {
	   		 bat "docker run -p 8081:8081 -h restassured --name restassured --net host -m=500m restassured:${env.version} RUN"
          }
          else if("${params.Modes}" == "FULL_RUN") {
	   		 bat "docker run -p 8081:8081 -h restassured --name restassured --net host -m=500m restassured:${env.version} FULL_RUN"
          }
          
        
        }

    }

}
