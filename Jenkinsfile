node {
    stage('Checkout'){
        checkout scm

    }
    stage('Prepare'){
	sh "mkdir -p ./image-build-env"
    }

   stage('Build'){
	sh "sudo scripts/system/build-image.sh ./image-build-env"
   }


    stage('Test') {
    }



    stage('Realease') {
        echo "Realse not yet done!"
        //runWithMaven("mvn release -B -P sign-artifacts -B release:prepare release:perform ")

    }

}
