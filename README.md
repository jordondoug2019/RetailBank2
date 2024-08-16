# RetailBank2
Deploying an application with AWS CLI and EB


The purpose of this project is to deploy a Retail Bank application that is fully managed by AWS. 

Steps Taken:

Step 1: Clone Repository to Github

Cloning a repo into you own Github repository allows for a dev to make changes locally and doesn’t interfere with the main branch. It also helps with tracking changes and version control.


Step 2: Create an EC2 Instance 

Creating a virtual server allows a developer to configure and customize for specific requirements and it also allows for scalability and flexibility for resources being used.

	Step 2.1: Update and Upgrade Server 
	
	Run `sudo apt update’ and `sudo apt upgrade` to make sure your server is updated and upgraded. This is to prevent any issues that may cause configuration drift between the server and any dependencies that may be added to the server.

         Step 2.2: Create security Group for EC2 Instance
	
         Creating a security group controls traffic and ensures only authorized access is permitted to your site and server.
      
         
 Step 3: Install Jenkins
Jenkins helps streamline the process of building, testing, and deploying code. It makes it easier to detect bugs and run test.  

To successfully install Jenkins, root user permissions are needed. Use the command sudo su. This allows for a regular user (ubuntu@ip.address) to gain privileges and access to all commands and files without needing the root user password. 

Once Jenkins has been added to your server, run sudo systemctl start jenkins. To make sure Jenkins is running, run the command sudo systemctl status jenkins.

 Step 4: Log into Jenkins

Once Jenkins is up and running on your EC2, open your browser to https://localhost:8080 (Jenkins default port is 8080). The following screen should appear. 
<img width="731" alt="Screenshot 2024-08-01 at 9 34 54 PM" src="https://github.com/user-attachments/assets/a1863d36-e3fa-4be6-892a-e52d8587491e">



Follow the path /var/jenkins_home/secrets/initalAdminPassword 
Copy and paste the password, follow the steps to create your 1st admin user.


 Step 5: Create a Multibranch Pipeline

After creating the 1st admin user, It’s time to create a multibranch pipeline. This step allows for different branches to be built and tested without compromising the main branch and causing potential issues. 

 Step 6: Connect Github Repo to Jenkins

Once you have successfully created the multibranch pipeline, Look for Branch Sources, click “Add source” and select “GitHub. Click “+ Add” and select “Jenkins”. Make sure “Kind” reads “Username and password”. Enter your Github username under Username and enter your Github Personal Access Token under Password. 
This step is important because any code pushed to the repo will automatically trigger builds and test, which makes it easier to detect any issues without affecting the main branch.

Step 7:  Build and Test in Jenkins
Jenkins Build Stage:
The build stage is where all of the files are complied together to create a copy of the finished application. Here, I continued to receive an error during my build stage. My error was due to a command on line 3 in the “test” file. Whenever I tried to access the file Jenkins was directing me to, I was met with permissions errors in the console. Once again, I tried the sudo commands and tried to access showrtcuts but still needed root user permissions to access those files. I tried changing the jenkins permissions but was still met with an error. 


<img width="1440" alt="Screenshot 2024-08-15 at 7 32 11 PM" src="https://github.com/user-attachments/assets/ef873b71-30cb-4412-9267-488594f52aa8">


I checked the errors frot the console output in Jenkins. I tried to use sudo su jenkins and google several different commands such as the one below but continued to get a prompt to enter the password. 

Once I got the initial Secret Password, I entered it but continued to receive an error that stated “Sorry, try again”
<img width="527" alt="Screenshot 2024-08-15 at 8 20 13 PM" src="https://github.com/user-attachments/assets/b9907b5b-9f06-48d7-b6b7-18bd9b656981">


# Step 8: Test in Jenkins

I was never able to test in Jenkins. 

 **Step 9: Create an AWS IAM role for Amazon Elastic Beanstalk and EC2.** 

Navigate to the AWS Management console and search for IAM to create IAM roles for Elastic Beanstalk environment and EC2 Instance. It is important to create the IAM roles to secure your instances and make it easier for permissions to be granted to your instances and to use different resources they may need.

 **Step 10: Create an Elastic Beanstalk Environment using AWS CLI**  
After creating your IAM roles, Go to the Terminal and instal AWS CLI using the following commands: 

$curl "https://awscli.amazonaws.com/awscli-exe-linux-x86\_64.zip" \-o "awscliv2.zip"  
$unzip awscliv2.zip  
$sudo ./aws/install  
$aws \--version 

After successful installation, you will see the version number of the AWS CLI.

**Step 11: Switch to the user "jenkins"**

Sudo su jenkins. This command allows us to access make changes to the server as a Jenkins user.

**12\. Navigate to the pipeline directory within the jenkins "workspace"**

**cd workspace/\[name-of-multibranch-pipeline**	

you should be able to see the application source code from this directory

**13\. Activate the Python Virtual Environment**  
  

**source venv/bin/activate**

**14\. Install AWS EB CLI on the Jenkins Server with the following commands:**

**$pip install awsebcli**  
**$eb \--version**

**15\. Configure AWS CLI with the folling command:**  
         
     **$aws configure**

**Enter your access key**  
**b. Enter your secret access key**  
**c. region: "us-east-1"**  
**d. output format" "json"**  
**e. check to see if AWS CLI has been configured by entering:**  
**$aws ec2 describe-instances** 

**16\. Initialize AWS Elastic Beanstalk CLI**  
**a. run the following command:**  
**eb init**

**b. Set the default region to: us-east-1**  
**c. Enter an application name (or leave it as default)**  
**d. Select python3.7**  
**e. Select "no" for code commit**  
**f. Select "yes" for SSH and select a "KeyPair"**

17. Create Environment

Create the environment from the cli using 
eb create environment-name
Follow the steps to create environment

<img width="1440" alt="Screenshot 2024-08-15 at 4 17 34 PM" src="https://github.com/user-attachments/assets/64efe78e-bc9c-42f7-9d34-cce29fab76c0">

The naviaget back to EB Console

<img width="1440" alt="Screenshot 2024-08-15 at 4 43 08 PM" src="https://github.com/user-attachments/assets/0d498659-abdd-470d-97f1-09616e5d4127">

Click the Url that was auto generated by Elastic Beanstalk

You should see a successful launch of your application
<img width="1440" alt="Screenshot 2024-08-15 at 4 43 20 PM" src="https://github.com/user-attachments/assets/f37c0d06-44a2-4840-b5d7-e4f538524727">
