# Getting Started with AWS
## Creating an AWS account

1. Go to https://aws.amazon.com/
2. Click Create an AWS Account
3. If you have an amazon account login with your amazon credentials (If not, create an account)
  1. Follow the instructions to create your account.
  2. On the Contact Information page select Personal Account
  3. For Support plan, the free option has already been picked, just click continue
4. If the instructions have been followed, your AWS should be created.

## Sign up for AWS Educate

1. Go to https://www.awseducate.com/Application?apptype=student
2. Fill out the form appropriately
   ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/AWS_Educate.png)
  * For institution type Davis and our school option will pop up, click on it
  * __USE YOUR @UCDAVIS.EDU email__
  * Your AWS Account ID can be found at https://console.aws.amazon.com/billing/home?#/account
  * __DO NOT__ click the option for AWS Educate Starter Account
3. Complete the verification process
4. Your application should be approved within 1 minute if you followed the steps correctly.

## Apply $100.00 credit to your account

Your application approval email came with a promotional credit code

1. Go to https://console.aws.amazon.com/billing/home?#/credits
2. Enter your promo code and your credit should be applied

## Creating your BIS180L instance

1. Go to https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1
  * Make sure it says N.California in the top right corner
2. Click on the blue button in the middle of the screen saying "Launch Instance"
  * It should say "Note: Your instances will launch in the US West (N. California) region"
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Home.png)
3. Click on Community AMIs in the menu on the left
4. In the search bar search for BIS180L
5. Select BIS180L - ami-d67c36b6
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_AMI.png)
6. On next page click on the 4th option down
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Instance.png)
  * It should say "t2.medium (Variable ECUs, 2 vCPUs, 2.5 GHz, Intel Xeon Family, 4 GiB memory, EBS only)" on the screen now
7. Click "6. Configure Security Group" at the top of the page
8. Make sure "create a new security group" is selected. Then change Type to All TCP
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Security.png)
9. Click Review and launch at the bottom of the page
10. Click Launch
11. Select "Create a new key pair"
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Key.png)
  * Name it whatever you want
  * Click the Download button
  * Press "Launch Instances"
  
## Attaching Permanent IP address to instance

1. Go to https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1#Addresses:sort=publicIp
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Elastic.png)
2. Click "Allocate New Address"
3. Click on "Actions" followed by "Associate Address"
4. On the pop-up window click on instance box and the name of your instance will pop up. Click on it followed "Associate" at the bottom of the window
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Associate.png)

## Connecting to your Instance for the first time
### Connecting this way will only be used doing initial setup and incase something goes wrong

1. Go to https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1#Instances:sort=securityGroupNames
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Overview.png)
  * Here you'll find your instance
  * Take note of your Public IP (you'll need this later)
2. Click Connect (This will open a new window)
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Connect.png)
  * Under example copy the line which starts with "ssh"
4. Open up your Terminal interface (ie. GitBash (Windows), Terminal(Mac))
5. Paste in the line you copied
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_Terminal.png)
  * You will have to change where it says "root" and replace it with "ubuntu"
6. You should now be logged into your Instance

## First time Setup

1. While logged into your Instance
2. Enter `sudo passwd ubuntu`
  * Enter a new password you want to use
  * This password will be used to log into Rstudio and to log into your instance if you lose you keypair file
  
## Connecting to you Desktop Interface

1. Open whatever VNC viewer you wish to use
2. Your VNC server will be your Public IP you noted earlier except you'll add ":1: to the end of it
  * Ex: 127.0.0.0:1
3. You will be asked to enter a password, the password is "Genomics"
4. You should now be able to see your desktop
  ![alt text](https://github.com/johnny3420/AWS_Setup/blob/master/Pictures/EC2_VNC.png)
