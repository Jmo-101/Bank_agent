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
 
 ```bash
software-properties-common, sudo add-apt-repository -y ppa:deadsnakes/ppa, python3.7, python3.7-venv}
```

On the application server EC2s, I installed the following:

```bash
{default-jre, software-properties-common, sudo add-apt-repository -y ppa:deadsnakes/ppa, python3.7, python3.7-venv}
```

I also created a new Key pair in AWS to attach a private key to all of my instances. (This will come into play later.)

### Jenkins Agent:
Once Jenkins was up and running on the first server, I configured a Jenkins agent with the public IP of the application instance, along with configuring the private key in the Jenkins agent to enable SSH access to the server. After configuration, I ensured the agent was up and running to facilitate its functioning.

<img width="500" alt="Screenshot 2023-10-18 at 11 56 08 AM" src="https://github.com/Jmo-101/Bank_agent/assets/138607757/0bfb949b-a601-4069-ba18-5038431d4ac9">

Once the Jenkins agent was operational, I created a multibranch pipeline to build, test, and deploy our code and application. The Pipeline was successful, and the application was deployed on our second instance.

<img width="500" alt="Screenshot 2023-10-18 at 12 33 02 PM" src="https://github.com/Jmo-101/Bank_agent/assets/138607757/58af79a9-39b3-4b11-9dc9-be43fcdf1c5e">

<img width="500" alt="Screenshot 2023-10-18 at 12 32 11 PM" src="https://github.com/Jmo-101/Bank_agent/assets/138607757/e32927b5-1335-472f-aaff-3e6f23fcddc9">


### 3rd Instance:
Next, I needed to deploy the application on the third instance I set up with Terraform earlier. I chose to configure another Jenkins agent with that instance's public IP. After successfully setting up the agent, I needed to find a way to deploy the application on both instances simultaneously. While reviewing the Jenkinsfile, I recalled the Jenkins agent's label and added both Jenkins agents. Upon running the pipeline again in Jenkins, it was successful, and both instances were deployed.

<img width="500" alt="Screenshot 2023-10-18 at 2 52 32 PM" src="https://github.com/Jmo-101/Bank_agent/assets/138607757/501c098e-3b16-4830-832b-335992f9668e">
<img width="500" alt="Screenshot 2023-10-18 at 2 34 55 PM" src="https://github.com/Jmo-101/Bank_agent/assets/138607757/93f5013f-7c48-429e-8afb-f6f8fe5177aa">

### Optimization:
One way I would optimize this infrastructure to make it more available to users would be to add load balancers. My thought process on this is since we have two instances up with the application deployed, we can direct traffic with the load balancers so more users are able to access the application.

### Purpose of Jenkins Agent:
The purpose of a jenkins agent is it acts as a worker node for the controller server. It offloads the workload from the controller server in the build and deploy stages. It offers scalability purposes as well as more worker nodes can be added to the controller server so more applications can be deployed.

