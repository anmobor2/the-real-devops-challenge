There is fist to run the folder setup-backend and later main-infra.

The first folder, setub-backen creates the bucket s3 and the dynamo table for the terraform state file.

Second run main-infra to raise all the infrastructure: terraform init, plan, apply.