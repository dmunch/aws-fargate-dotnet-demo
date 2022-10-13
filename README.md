# Using .NET with AWS Fargate and Terraform

A complete example, deploying a containerised .NET application through GitHub actions to a fresh AWS account, provisioned via Terraform. 

# Live

The deployed application can be accessed under https://demo.munch.engineering - There's currently just one endpoint, which is accesible at https://demo.munch.engineering/weatherforecast

## IAC

The [IAC](iac/) Terraform code has been taken from [this](https://engineering.finleap.com/posts/2020-02-20-ecs-fargate-terraform/) blog post, and adapted to include Route53 resources, a TLS certificate, and a dedicated GitHub Action user role with the minimal amount of permissions to allow the GitHub Action runner to deploy the application. 

The AWS Setup is a uses a private subnet for the containers, with a Load Balancer and a NAT Gateway in a public subnet for connectivity. 

![example](https://d2908q01vomqb2.cloudfront.net/1b6453892473a467d07372d45eb05abc2031647a/2018/01/26/Slide5.png "Infrastructure illustration")
(Source: https://aws.amazon.com/de/blogs/compute/task-networking-in-aws-fargate/)

# Application

The Application in [src/](src/) is a basic .NET 7 (preview) minimal API. This demo uses a new .NET 7 feature  feature which makes publishing of Docker containers much easier.

https://devblogs.microsoft.com/dotnet/announcing-builtin-container-support-for-the-dotnet-sdk/


# GitHub Actions

The demo has a minimalistic CI/CD pipeline using GitHub Actions: [.github/workflows/containerize.yml](.github/workflows/containerize.yml)

Instead of using hard-coded credentials, this demo uses OpenID for GitHub Actions to authenticate with AWS

- https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
- https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html


For the deployment steps, the following steps are used:
- https://github.com/aws-actions/configure-aws-credentials
- https://github.com/aws-actions/amazon-ecs-deploy-task-definition