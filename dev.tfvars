region = "ap-south-1"
prefix = "may-lab"
vpc_cidr     = "192.168.1.0/25"
# subnet1_cidr = "192.168.1.0/28"
# subnet2_cidr = "192.168.1.16/28"
# subnet3_cidr = "192.168.1.32/28"
# subnet4_cidr = "192.168.1.48/28"
# subnet5_cidr = "192.168.1.64/28"
# subnet6_cidr = "192.168.1.80/28"
subnets = [
  {
    az   = "a"
    cidr = "192.168.1.0/28"
  },
  {
    az   = "b"
    cidr = "192.168.1.16/28"
  },
  {
    az   = "a"
    cidr = "192.168.1.32/28"
  },
  {
    az   = "b"
    cidr = "192.168.1.48/28"
  },
  {
    az   = "a"
    cidr = "192.168.1.64/28"
  },
  {
    az   = "b"
    cidr = "192.168.0.80/28"
  }
]