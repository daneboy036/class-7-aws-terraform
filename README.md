# Classes

## 10-28-25

- catchup week
- goal is to do a vpc from scratch in terraform, if time we'll do a EC2 instance and maybe SG

## 11-2-25

- we'll add security groups and an ec2 instance with a server

# Terraform

## Blocks

- Use = when assigning a map or object as the value of a simple argument (ex: tags = { ... }).

- Use no = for nested blocks that define a set of related configuration options within the resource (ex: network_interface { ... }).

## Terraform Commands

`terraform state list` -- show all infra terraform has created
`terraform init`
`terraform validate`
`terraform plan`
`terraform apply`
`terraform destroy`
`terraform plan -out=plan && terraform show -json plan > plan.tfgraph` -- generate a graph http://webgraphviz.com/ will show it better

## Lifecyle

### `create_before_destroy`

- tells terraform to create a replacement resource before destroying the current resource
- ex: we want to create a replacement security group before removing the existing one, this is necessary because a sg can't be destroyed while it is still assocated with resources. Creating the new one first allows terraform to safely detach and destory the oldone, avoiding a dependency violation

## Data Types

- supports what kind of data we are working with
  - string
  - boolean
  - number

## Functions

- combine or modify expression sto produce different values
- tf has several built in function
  - ex: file that can be used to attach user data to ec2 instances

## Output Blocks

- generate output
- let you export structured data bout your resource
- ex:
  ```hcl
      output "vpc_id" {
      description = "ID of project VPC"
      value       = module.vpc.vpc_id
      }
  ```
  - the above will allow you to output the value of your vpc id

## Data Sources

- another type of code block
- similar to resource blocks but in reverse
- insted of modifying infrastrucure, it's used to query existing in frastruction and return info about the specific resource in question
- need to do an apply to get the data source info added to the state file
  - we can output the results of the data

## Terraform State

- state is the desired state that you want to deploy
- it's rare to have to manually change the state files

### commands

- `terraform state ls`
- `terraform state rm <resource name>` -- you'd run this if you had a corrupted state
- `terraform apply -replace="<resource address>"` replace a specific resource
