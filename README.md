<p align="center">
<img src="https://github.com/kura-labs-org/kuralabs_deployment_1/blob/main/Kuralogo.png">
</p>
<h1 align="center">Banking_Agent<h1> 

# Planning:

<img width="600" alt="Screenshot 2023-10-20 at 7 39 11 PM" src="https://github.com/Jmo-101/Bank_agent/assets/138607757/f3f01838-5953-4b06-b95b-f98f38761556">

## Purpose:
The purpose of this project was to showcase the ability to use Terraform to create a cloud infrastructure, the use of Jenkins, and the utilization of Jenkins agents to deploy the application.

### Terraform:
In my `main.tf` file, I configured it so Terraform can automate the building of the 3 EC2 instances I needed for this project. I set it up to create the EC2s in a VPC with 2 availability zones and 2 public subnets. One public subnet housed the Jenkins servers, while the other public subnet housed the application servers.

### EC2 Instances:
On the EC2 server hosting Jenkins, I installed the following requirements:

- [List of requirements installed on Jenkins EC2 instance]

On the application server EC2s, I installed the following:

- [List of requirements installed on application server EC2 instances]

I also created a new Key pair in AWS to attach a private key to all of my instances. (This will come into play later.)

### Jenkins Agent:
Once Jenkins was up and running on the first server, I configured a Jenkins agent with the public IP of the application instance, along with configuring the private key in the Jenkins agent to enable SSH access to the server. After configuration, I ensured the agent was up and running to facilitate its functioning.

Once the Jenkins agent was operational, I created a multibranch pipeline to build, test, and deploy our code and application. The Pipeline was successful, and the application was deployed on our second instance.

### 3rd Instance:
Next, I needed to deploy the application on the third instance I set up with Terraform earlier. I chose to configure another Jenkins agent with that instance's public IP. After successfully setting up the agent, I needed to find a way to deploy the application on both instances simultaneously. While reviewing the Jenkinsfile, I recalled the Jenkins agent's label and added both Jenkins agents. Upon running the pipeline again in Jenkins, it was successful, and both instances were deployed.
