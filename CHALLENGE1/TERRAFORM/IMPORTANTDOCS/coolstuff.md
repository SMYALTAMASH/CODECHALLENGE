# Some Crazy Stuff and helpful commands in terraform.

* To apply changes to a specific resource, use the -target option:

```
terraform apply -target aws_instance.example
This applies changes only to the aws_instance.example resource.
``

* To preview changes before applying them, use the terraform plan command:

```
terraform plan
This provides a preview of the changes Terraform will make.
```

* To use environment variables for sensitive data, define them in your shell before running Terraform:

```
export TF_VAR_access_key="your_access_key"
export TF_VAR_secret_key="your_secret_key"
terraform plan
This stores your access and secret keys as environment variables before running terraform plan.
```

* To save a plan file, use the -out option:

```
terraform plan -out=plan.tfplan
This saves the plan to a file named plan.tfplan.
```

* To manage the state file, use the terraform state command:

```
terraform state list
This lists all resources in the state file.
```

* To control parallelism, use the -parallelism option:

```
terraform apply -parallelism=10
This applies changes to up to 10 resources in parallel.
```

* To automatically approve changes, use the -auto-approve option:

```terraform apply -auto-approve
This automatically approves changes without requiring manual confirmation. Note that this can be risky, so use it with caution.
```

* Use the -var-file option to load variables from a file.

```
terraform plan -var-file=variables.tfvars
```

* Use the terraform output command to retrieve output values.

```
terraform output public_ip
```

* Use the -state-out option to save the state to a file.

```
terraform apply -state-out=state.tfstate
```

* Use the -var option to set a variable value at runtime.

```
terraform plan -var="region=us-west-2"
```

* Use the terraform graph command to generate a visual representation of your infrastructure.

```
terraform graph | dot -Tpng > graph.png
```

* Use remote state to store your state file in a shared location, such as S3 or a remote backend like Terraform Cloud.

```
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "example.tfstate"
    region = "us-west-2"
  }
}
```

* Use terraform import to import existing infrastructure into your Terraform state file.

```
terraform import aws_instance.example i-0123456789abcdef0
```

* Use terraform providers to manage and install third-party providers.

```
terraform providers or terraform init -upgrade
```

* Use null_resource to run arbitrary commands outside of a resource.

```
resource "null_resource" "example" { provisioner "local-exec" { command = "echo Hello, World!" } }
```

* Use terraform fmt to automatically format your Terraform code.

```
terraform fmt -recursive
```

