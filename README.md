Pet project to play with RDS.

WARNING: there are a lot of hardcoded values, it was just a POC.

# How to run it

1) review hardcoded values on tf files, change it accordantly (or move it to variables.tf)
2) on aws, need to create a key pair to access ec2
3) run `make plan` to review the changes, `make apply` to perform the changes
4) get ec2 and rds info from output, update on `Makefile`
5) run `make connect` to test
6) run `make forward` to create the tunnel
7) connect to the database in the localhost:3306 (user/pass/database are hardcoded on `ec2.tf`)

# AWS: To get your access key ID and secret access key

- On the navigation menu, choose Users.
- Choose your IAM user name (not the check box).
- Open the Security credentials tab, and then choose Create access key.
- To see the new access key, choose Show. ...
- To download the key pair, choose Download .csv file.

# References

- [Terraform: RDS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)
- [Youtube: How to Access a Private RDS Database (Using a Jump Box) From Your Home Network](https://www.youtube.com/watch?v=buqBSiEEdQc)
- [Youtube: How to connect to AWS RDS from local machine](https://www.youtube.com/watch?v=ZFPO0GK_oY4)
  - [StackOverflow: Edit inbound rules](https://stackoverflow.com/a/67240179)