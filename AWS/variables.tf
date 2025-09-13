variable "region" {
  description = "AWS region."
  type = string
  default = "eu-central-1"
}

variable "vpc-cidr" {
    description = "Value for VPC CIDR block"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc-name" {
    description = "Two-Tier-VPC"
    type = string
    default = "two-tier-vpc"
}

variable "first-az" {
    description = "First availability zone"
    type = string
    default = "eu-central-1a"
}

variable "second-az" {
    description = "Second availability zone"
    type = string
    default = "eu-central-1b"
}

variable "public-subnet1-cidr" {
    description = "First public Subnet CIDR block"
    type = string
    default = "10.0.1.0/24"
}

variable "public-subnet2-cidr" {
    description = "Second public Subnet CIDR block"
    type = string
    default = "10.0.2.0/24"
}

variable "ig-name" {
    description = "Internet gateway"
    type = string
    default = "internet-gateway"
}

variable "public-rt-name" {
    description = "Public route table"
    type = string
    default = "public-route-table"
}

variable "private-subnet1-cidr" {
    description = "First private Subnet CIDR block"
    type = string
    default = "10.0.3.0/24"
}

variable "private-subnet2-cidr" {
    description = "Second private Subnet CIDR block"
    type = string
    default = "10.0.4.0/24"
}

variable "ami-id" {
    description = "ami-id"
    type = string
    default = "ami-0a116fa7c861dd5f9"
}

variable "instance-type" {
    description = "Instance type"
    type = string
    default = "t3.micro"
}

variable "db-subnet" {
  description = "Database subnet"
  type = string
  default = "db-subnet"
}

variable "lb-sg-name" {
   description = "Security group for load balancer"
   type = string
   default = "load-balancer-sg"
}

variable "lb-name" {
   description = "Load balancer name"
   type = string
   default = "load-balancer"
}

variable "sg-name" {
   description = "EC2 security group"
   type = string
   default = "ec2-sg"
}

variable "tg-name" {
   description = "Target group"
   type = string
   default = "target-group"
}

variable "db-username" {
   description = "Username for db instance"
   type = string
   default = "admin"
}

variable "db-password" {
   description = "Password for db instance"
   type = string
   default = "abmashraf2222"
}

variable "db-sg-name" {
    description = "Database security group"
    type = string
    default = "database-sg"
}

variable "key-name" {
    description = "Value for key-name"
    type = string
    default = "my-key"
}