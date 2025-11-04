variable "instance_type"{
    type = string
    default = "t3.micro"
}

variable "instances"{
    type = list
}

variable env {
    default = "prod"
}

variable "tags"{
    type = map
    default = {
        Project = "Roboshop"
    }
}

variable "domain_name" {
    default = "gangu.fun"
}