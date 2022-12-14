name                = "aws-fargate-dotnet-demo"
container_image     = "632815008263.dkr.ecr.eu-central-1.amazonaws.com/aws-fargate-dotnet-demo-test:14639560b3cc5f59c5f9258e35cb35b14bee83fc"
dns_tld             = "munch.engineering"
dns_subdomain       = "demo"
environment         = "test"
availability_zones  = ["eu-central-1a", "eu-central-1b"]
private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
container_memory    = 512