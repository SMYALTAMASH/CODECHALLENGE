# CHALLENGE 1:

* We can discuss this stack: https://github.com/aws-samples/aws-refarch-wordpress

# Few Optimizations

* The above template is already using nested stack but there is no cli option which is present, so CLI approach will be better.
* Create a parameter file for environment specific variables and follow the next section for the cli commands.
* Store the cloudofrmation template in S3 by enabling versioning or in GIT.
* Create a service catalogue to have an approved stack and getting it deployed by approved users and to distribute it to clients.
* The tree structure which can be best for the cloudformation stack with local stack is 

```
.
├── README.md
└── my-cloudformation
    ├── nested-stacks
    │   ├── substack1.yaml
    │   └── substack2.yaml
    ├── parameters
    │   ├── dev.json
    │   └── prod.json
    ├── policies
    │   ├── s3-bucket-policy.json
    │   └── sqs-queue-policy.json
    ├── scripts
    │   ├── bootstrap.sh
    │   └── configure.sh
    └── templates
        ├── database.yaml
        ├── main.yaml
        └── networking.yaml

6 directories, 12 files
```

# Few useful commands to be used are as below.
* To create a CloudFormation stack using a template stored locally:

```
aws cloudformation update-stack \
  --stack-name dev-substack1 \
  --template-body file://my-cloudformation/nested-stacks/substack1.yaml \
  --parameters file://my-cloudformation/parameters/dev.json \
  --capabilities CAPABILITY_IAM

```

* To create a CloudFormation stack using a template stored in an S3 bucket:

```
--template-url https://s3.amazonaws.com/dev-bucket/dev-template.yml


```

* To Create Cloudformation ChangeSet:

```
aws cloudformation create-change-set \
  --stack-name my-stack \
  --template-url https://s3.amazonaws.com/my-bucket/my-template.yaml \
  --change-set-name my-changeset \
  --parameters file://my-params.json \
  --capabilities CAPABILITY_IAM
```

* To Review the changeSet:

```
aws cloudformation describe-change-set \
  --stack-name my-stack \
  --change-set-name my-changeset
```

* To Approve the changeSet:

```
aws cloudformation execute-change-set \
  --stack-name my-stack \
  --change-set-name my-changeset

```

* To update a CloudFormation stack:

```
aws cloudformation update-stack \
  --stack-name dev-substack1 \
  --template-body file://my-cloudformation/nested-stacks/substack1.yaml \
  --parameters file://my-cloudformation/parameters/dev.json \
  --capabilities CAPABILITY_IAM

```

* To delete a Cloudformation Stack:

```
aws cloudformation delete-stack \
  --stack-name dev-substack1
```
