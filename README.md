# Cloud Developer ND Course 2: Design for Performance and Scalability
How I reduced the estimate to $6,500?

To align our infrastructure costs with the new budget of $6,500 per month, we downgraded our database instance from a db.m5.2xlarge to a db.m4.xlarge. This adjustment significantly reduces RDS expenses while still providing sufficient performance for our application’s needs. Additionally, we optimized our EC2 usage by scaling down the number of t3.medium Web Servers and t3.large Application Servers, ensuring efficient resource utilization. Furthermore, we reviewed and removed non-essential services and streamlined our monitoring and logging tools to eliminate unnecessary expenditures, thereby maintaining core functionality without exceeding our financial constraints.

How I increased the estimate to $20,000?
To support the increased budget of $20,000 per month, we added an additional Amazon RDS instance in the Ohio region, enhancing our database's availability and ensuring geographic redundancy for improved disaster recovery capabilities. Additionally, we deployed four more EC2 instances using the t4g.2xlarge instance type, which provide higher performance and better cost-efficiency to handle the growing application demands and increased traffic. These strategic additions not only bolster our infrastructure's scalability and reliability but also ensure that our services can meet the heightened performance requirements without compromising on quality or user experience.

## Project  Instructions

### Exercise 1

1. Download the [starter code](https://github.com/udacity/cand-c2-project).
2. In the main.tf file write the code to provision
   * AWS as the cloud provider
   * Use an existing VPC ID
   * Use an existing public subnet
   * 4 AWS t2.micro EC2 instances named Udacity T2
   * 2 m4.large EC2 instances named Udacity M4
3. Run Terraform. 
4. Take a screenshot of the 6 EC2 instances in the AWS console and save it as `Terraform_1_1`. 
5. Use Terraform to  delete the 2 m4.large instances 
6. Take an updated screenshot of the AWS console showing only the 4 t2.micro instances and save it as `Terraform_1_2`

### Exercise 2

1. In the  Exercise_2 folder, write the code to deploy an AWS Lambda Function using Terraform. Your code should include:

   * A lambda.py file
   * A main.tf file with AWS as the provider, and IAM role for Lambda, a VPC, and a public subnet
   * An outputs.tf file
   * A variables.tf file with an AWS region
  
2. Take a screenshot of the EC2 instances page
3. Take a screenshot of the VPC page 
