Ex-1

For 1st question i have created ALB --> ec2 --> mysql DB instance 
i have also used custom path for credentials if you want to use my project to run these files, please let me know and will share conf and credential file via email.. though the user will have just the ec2 reader role. Because i am giving it right to assume role required for creation of resources as well. that is mentioned in terraform.tf file.
Also Autoscaling group is used to create ec2 here with the help of templates for scalability.

#################################################################################

Ex-2

Here also i have also used custom path for credentials if you want to use my project to run these files, please let me know and will share conf and credential file via email.. same user as above i am using.

we could also have used another mechanism for authentication like running it from any other CI/CD or devops tool like jenkins, azure and then encrypting those credentials somewhere and just using the reference to them. but in account of time and this demo sharing those files to get connect to that account.
Also for 2nd question in exercise i tried for gcp as well but my billing account was not verified, so have commented out the code.


###################################################################################

Ex-3

have written simple python code and 2 test cases are there as mentioned in the question.


###################################################################################

Thanks
