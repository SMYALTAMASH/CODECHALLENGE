# CHALLENGES.

* We have majorly 3 challenges one is on 3 tier app creation and 2 on scripting and coding.
* In challenge1 the custom solution is in terraform.

# Challenge1: https://github.com/SMYALTAMASH/CODECHALLENGE/tree/master/CHALLENGE1/TERRAFORM/IMPORTANTDOCS

# Challenge1: https://github.com/SMYALTAMASH/CODECHALLENGE/tree/master/CHALLENGE1/CLOUDFORMATION

# Challenge2: https://github.com/SMYALTAMASH/CODECHALLENGE/tree/master/CHALLENGE2

# Challenge3: https://github.com/SMYALTAMASH/CODECHALLENGE/tree/master/CHALLENGE3

# CHALLENGE1: THIS IS A BIT OPEN AND TRICKY QUESTION THE REASON BEING THE BELOW.

|   | Terraform | CloudFormation | Serverless Framework |
|---|---|---|---|
| **Language/DSL** | HashiCorp Configuration Language (HCL) | YAML or JSON syntax | YAML syntax |
| **Supported Cloud Providers** | Multiple cloud providers, including AWS, Azure, Google Cloud Platform, and more | Only AWS | Only AWS |
| **State Management** | Built-in state management with version control | AWS-managed or self-managed state storage options | No built-in state management, but integrates with external services like Serverless Framework |
| **Resource Coverage** | Broad range of resources across multiple cloud providers | All AWS resources are supported | Limited to AWS serverless resources |
| **Modularity** | Modules can be used for code reuse | Supports nested stacks and cross-stack references | Supports plugins and reusable templates |
| **Rollbacks** | Manual rollback required | Automatic rollback on failure | Automatic rollback on failure |
| **Drift Detection** | Built-in drift detection | Supported through Change Sets | No built-in drift detection, but integrates with external services like Serverless Framework |
| **Third-party Integrations** | Many third-party integrations, including for testing and monitoring | Limited third-party integrations | Many third-party integrations, including plugins and serverless libraries |
| **Learning Curve** | Can be simpler to learn due to consistent syntax | Can be complex due to the variety of AWS resources and quirks | Can be simpler to learn for serverless projects due to specific focus |
| **Cost** | Open source or enterprise versions available with additional features and support | No additional cost beyond AWS resource usage | No additional cost beyond AWS resource usage |
| **Vendor Lock-in** | Less locked into a single cloud provider | Locked into AWS | Locked into AWS |
| **Community Support** | Large and active community | Large and active community | Large and active community |
| **Infrastructure as Code Maturity** | Mature product with many features and services | Mature product with many features and services | Relatively new, but rapidly growing with a focus on serverless projects |

# Note: There are many combinations of resources/IAC tools/Cloud Providers which makes the stuff complex until the resources are freezed. If there was enough time i woupld have loved to talk about Serverless Framework.
