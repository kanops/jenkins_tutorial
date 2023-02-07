variable "name" {
    type = string
}

variable "region" {
    type = string
}

variable "machine_type"{
    type = string
}

variable "network_name" {
    type = string
}

variable "image_name"{
    type = string
    default = "Debian 11"
}

variable "key_pair_name" {
    type = string
}

variable "security_group" {
    type = string
}

variable "metadata" {
    type = map

    default= {}
}