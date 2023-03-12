# TERRAFORM EXECUTION COMMANDS

* Initialize a new Terraform working directory

```
terraform init
```

* Review and validate the Terraform plan [We can take the output of plan to separate file by using -out option]

```
terraform plan -var-file="../variables/dev.tfvars" -state=dev.tfstate
```

* Apply the changes mentioned in above plan phase.

```
terraform apply -var-file="../variables/dev.tfvars" -state=dev.tfstate
```

* Destroy the resources

```
terraform destroy -var-file="../variables/dev.tfvars" -state=dev.tfstate
```

* Tree Structure and Explanation

```
.
├── IMPORTANTDOCS
│   ├── README.md
│   ├── coolstuff.md
│   └── problems.md
├── main
│   ├── container_definitions.json
│   ├── main.tf
│   └── variables.tf
├── modules
│   ├── alb
│   ├── cloud_front
│   ├── ecr
│   ├── iam
│   ├── rds
│   ├── s3_access_log
│   ├── s3_lb_log
│   ├── sg
│   └── vpc
└── variables
    ├── dev.tfvars
    ├── prod.tfvars
    └── staging.tfvars

13 directories, 9 files
```

* Here the IMPORTANTDOCS contains the important documents for terraform module as the name suggests.
* main folder contains the generic template with modules which will call different resources picking variables specific to each environment.
* modules folder contains the services and its definition which can be extended pretty easily.
* variables folder contains environment specific files.
