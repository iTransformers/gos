node {
    stage('Checkout'){
        checkout scm

    }
    stage('Prepare'){
	sh "mkdir -p $(pwd)/image-build-env"
    }

   stage('Build'){
	sh "sudo su && export PATH=$PATH:/sbin && scripts/system/build-image.sh $(pwd)/image-build-env"
   }


    stage('Test') {
    }



    stage('Realease') {
        echo "Realse not yet done!"
        //runWithMaven("mvn release -B -P sign-artifacts -B release:prepare release:perform ")

    }

}
