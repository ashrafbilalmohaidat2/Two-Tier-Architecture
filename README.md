# Two-Tier AWS Architecture with Terraform

A Terraform project that provisions a highly available two-tier architecture on AWS, consisting of a web tier (EC2 + ALB) and a database tier (RDS MySQL), deployed across two availability zones.

## Architecture Overview

```
Internet
    │
    ▼
[Application Load Balancer]  ← public subnets (AZ-1a, AZ-1b)
    │
    ├──► [EC2 Instance 1]  (public-subnet1 / eu-central-1a)
    │         │
    └──► [EC2 Instance 2]  (public-subnet2 / eu-central-1b)
              │
              ▼
        [RDS MySQL 8.0]  ← private subnets (AZ-1a, AZ-1b)
```

## Resources Provisioned

| Resource | Details |
|---|---|
| VPC | `10.0.0.0/16` |
| Public Subnets | `10.0.1.0/24`, `10.0.2.0/24` |
| Private Subnets | `10.0.3.0/24`, `10.0.4.0/24` |
| Internet Gateway | Routes public traffic |
| Route Table | Public route to IGW |
| EC2 Instances | 2x `t3.micro` with Nginx (user-data) |
| Application Load Balancer | Internet-facing, HTTP:80 |
| Target Group | Both EC2 instances on port 80 |
| RDS MySQL | `db.t3.micro`, MySQL 8.0.40, 10 GB |
| Security Groups | ALB SG, EC2 SG, DB SG |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
- An existing EC2 Key Pair in the target region
- An AMI ID for the target region (Ubuntu recommended)

## Project Structure

```
AWS/
├── provider.tf          # AWS provider & Terraform version
├── variables.tf         # All input variables
├── vpc.tf               # VPC
├── internet-gateway.tf  # Internet Gateway
├── puplic-subnets.tf    # Public subnets (x2)
├── private-subnet.tf    # Private subnets (x2)
├── public-route-table.tf# Route table + associations
├── security-group.tf    # EC2 security group
├── lb-sg.tf             # Load balancer security group
├── db-sg.tf             # Database security group
├── ec2.tf               # EC2 instances (x2)
├── alb.tf               # ALB + HTTP listener
├── target-group.tf      # Target group + attachments
├── rds.tf               # RDS MySQL instance
├── db-subnet-group.tf   # DB subnet group
├── outputs.tf           # ALB DNS name output
├── user-data.sh         # Nginx bootstrap script
└── secret.tfvars        # Sensitive variables (not committed)
```

## Usage

### 1. Clone the repository

```bash
git clone <repo-url>
cd Two-Tier-Architecture/AWS
```

### 2. Create `secret.tfvars`

```hcl
db-password = "<your-db-password>"
ami-id      = "<your-ami-id>"        # e.g. ami-0faab6bdbac9486fb (Ubuntu 22.04 eu-central-1)
key-name    = "<your-key-pair-name>"
my-ip       = "<your-public-ip>/32"  # e.g. 203.0.113.10/32
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan & Apply

```bash
terraform plan -var-file="secret.tfvars"
terraform apply -var-file="secret.tfvars"
```

### 5. Access the application

After apply completes, Terraform outputs the ALB DNS name:

```
Outputs:
dns-name = "load-balancer-<id>.eu-central-1.elb.amazonaws.com"
```

Open the DNS name in your browser to see the Nginx welcome page served from one of the EC2 instances.

### 6. Destroy infrastructure

```bash
terraform destroy -var-file="secret.tfvars"
```

## Variables

| Variable | Default | Description |
|---|---|---|
| `region` | `eu-central-1` | AWS region |
| `vpc-cidr` | `10.0.0.0/16` | VPC CIDR block |
| `first-az` | `eu-central-1a` | First availability zone |
| `second-az` | `eu-central-1b` | Second availability zone |
| `instance-type` | `t3.micro` | EC2 instance type |
| `ami-id` | *(required)* | AMI ID for EC2 instances |
| `key-name` | *(required)* | EC2 Key Pair name |
| `db-username` | `admin` | RDS master username |
| `db-password` | *(sensitive, required)* | RDS master password |
| `my-ip` | *(required)* | Your public IP in CIDR notation for SSH access |

## Security Notes

- `secret.tfvars` is listed in `.gitignore` — never commit it
- `terraform.tfstate` may contain sensitive data — consider using a remote backend (e.g. S3 + DynamoDB)
- EC2 SSH (port 22) is restricted to `my-ip` — keep this updated to your current IP
- Private subnets have `map_public_ip_on_launch = false` — instances in private subnets won't receive public IPs
- Consider enabling HTTPS (port 443) on the ALB with an ACM certificate for production use
