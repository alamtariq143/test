echo "-----Starting th init script ------"
echo ""

## Installing PSQL

echo "Step 1: Installing PSQL "

sudo apt update  
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service

echo ""
echo "Step 1: Completed "
echo ""

## Installing AWS CLI

echo ""
echo "Step 2: Installing aws cli to get the secert from secert manager"
echo ""

sudo apt install awscli --assume-yes

echo ""
echo "Step 2: Completed "
echo ""

## getting the secret 

echo ""
echo "Step 3: setting the aws configure/logging into AWS account"
echo ""

aws configure set aws_access_key_id "AKIA2VEIVMOBLHFOYVVG" --profile profile_aws
aws configure set aws_secret_access_key "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" --profile profile_aws
aws configure set region "us-east-1" --profile profile_aws
aws configure set output "json" --profile profile_aws

echo ""
echo "Step 3: Completed "
echo ""

echo ""
echo "Step 4: getting the secret"
echo ""

aws secretsmanager get-secret-value  --secret-id test > output.json


sudo snap install jq

output2=$(cat output.json | jq '.SecretString')

echo $output2



#out=$(echo $output2)

#output5=$(echo $out | jq '.test')


#echo $output5


echo ""
echo "Step 4: Completed "
echo ""

echo ""
echo "Step 5: getting the RAW SQL file from github"
echo ""

wget https://raw.githubusercontent.com/anthonydb/practical-sql-2/main/Chapter_02/Chapter_02.sql

echo ""
echo "Step 5: Completed "
echo ""


echo ""
echo "Step 6: Run the PSQL command to connect to Postgres"
echo ""


# Set variables
DB_HOST="rds-postgresql.chhmha6g7mfn.us-east-1.rds.amazonaws.com"
DB_PORT="5432"
DB_NAME="dbname"
DB_USER="masterUsername"
GIT_REPO="https://github.com/anthonydb/practical-sql-2/blob/main/Chapter_02"
#SQL_FILE="Chapter_02.sql"

# Get DB secret (replace with your actual command to fetch the secret)
#DB_SECRET=$(aws secretsmanager get-secret-value --secret-id test --query SecretString --output text)
DB_SECRET="1234567890"

# Connect to the database using psql and execute the SQL file



#psql postgres://masterUsername:1234567890@rds-postgresql.chhmha6g7mfn.us-east-1.rds.amazonaws.com:5432/dbname -f "./Chapter_02.sql"

psql postgres://$DB_USER:$DB_SECRET@$DB_HOST:$DB_PORT/$DB_NAME -f "./Chapter_02.sql"

echo ""
echo "Step 6: Completed "
echo ""


echo "---------Exiting the script---------- "





