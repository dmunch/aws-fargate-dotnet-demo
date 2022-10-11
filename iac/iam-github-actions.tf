// Setup GitHub actions authentication using OpenID, as documented here
// https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
// https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html


resource "aws_iam_role" "github_actions_role" {
  name = "github_actions_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "sts:AssumeRoleWithWebIdentity"
        Effect   = "Allow"
        Principal = {
            Federated = [
                aws_iam_openid_connect_provider.github_actions.id
            ]
        }
        Condition = {
            StringLike = {
                "token.actions.githubusercontent.com:sub" = "repo:dmunch/aws-fargate-dotnet-demo:*"
            }
            "ForAllValues:StringEquals" = {
                "token.actions.githubusercontent.com:iss" = "https://token.actions.githubusercontent.com",
                "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            }
        }
      },
    ]
  })
}

resource "aws_iam_policy" "github_actions_policy" {
  name = "github_actions_role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "iam:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "ecr:*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_role_policy_attachment" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}