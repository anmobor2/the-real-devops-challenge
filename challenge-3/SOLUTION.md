1 There is first to run the folder setup-backend/test and 
2 later main-infra/environments_main-infra/test.

The first folder, setub-backen creates the bucket s3 and the dynamo table for the terraform state file.

Second run main-infra to raise all the infrastructure: terraform init, plan, apply.