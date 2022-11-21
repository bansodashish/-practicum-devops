The Terraform code is under the api folder under terraform directory.
terraform version used 0.12 and above, aws provider version 3.0.0 and above.
Directory structure of the terraform code:
.
├── main.tf
├── package.sh
├── provisioning.tf
├── terraform.tfvars
└── variable.tf
main.tf-->> contains the resource creation code.

package.sh -->>is the file contains the packages to be installed on the Instance like Docker and Docker compose which will be used in the userdata.

Provisioning.tf-->> It is put in a separate file and not associate to any resource,associate them with a null_resource.
 > Instances of null_resource are treated like normal resources, but they don't do anything. 
 > Like with any other resource, you can configure provisioners and connection details on a null_resource. 
 > You can also use its triggers argument and any meta-arguments to control exactly where in the dependency graph its provisioners will run.
 
terraform.tfvars--> Need to define the values of the variables as per the enviornment.

variable.tf -->> Need to define the variables.

We need to ran the terraform init command first to initialised the terraform files, install the the AWS plugin, read the modules if any also the backend if we defined in the code.

Then we do a dry run by running terraform plan this will show what all resources will be provisioned on the cloud.

Ran the terraform apply command to build the infrastructure on the AWS.

Workflow:
During the apply it will create the instance and during the bootstrap it will ran the userdata and will install Docker, Docker-Compose on the instance.
When the bootstrap get completed it will used the remote-exec provisioner to copy the docker-compose file to the instance at the /home/ec2-user directory
Then we can ran the docker-compose command under the provisioner remote-exec section to build the containers on the ec2.


Continous Integration/Continuous delivery:
We can use Jenkins as a CICD tool to do the orchestration of the infrastructure.
We need to Install the terraform plugin in jenkins.
Create a Jenkins pipeline with various stages:
Stage1:
 repo clone
Stage2:
 Create a stage for terraform init
Stage3:
 Create a stage for terraform plan which show the dry run result.
Introduce the input function under this for human intervention whether to proceed or not.
Stage4:
 Stage for terraform apply.
if everything works fine, all stages ran successfully then add notfication stage:
Stage5:
Send email notification or chat notification.
