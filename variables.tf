variable "instance_type"{
    type = map
    default = {
        dev = "t2.micro"
        prod = "t3.micro"
    }
}

variable "instances"{
    type = list
}

variable env {
    default = {
       dev = "dev"
       prod = "prod"
    }
}

variable "project" {
    default = "Roboshop"
}

variable "common_tags"{
    type = map
    default = {
        Project = "Roboshop"
        Terraform = true
    }
}

variable "domain_name" {
    default = "gangu.fun"
}