# TERRAFORM EXECUTION COMMANDS

* Initialize a new Terraform working directory

```
terraform init
```

* Review and validate the Terraform plan [We can take the output of plan to separate file by using -out option]

```
terraform plan -var-file="../variables/dev.tfvars"
```

* Apply the changes mentioned in above plan phase.

```
terraform apply -var-file="../variables/dev.tfvars"
```

* Destroy the resources

```
terraform destroy -var-file="../variables/dev.tfvars"
```
