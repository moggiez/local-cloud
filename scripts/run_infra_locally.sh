#!/bin/bash
# Runs IaC code with LocalStack and local Terraform Backend

NAME=$1
CURRENT_DIR=$(pwd)
PROJ_DIR=$CURRENT_DIR/temp/$NAME

mkdir -p $PROJ_DIR
cp ./infrastructure/main.tf temp/$NAME
cd ../$NAME

FILES=$(find . -type f -name "*.tf" -exec basename \{} \;)

for f in $FILES
do
    # if [[ "$f" =~ ^(main.tf|code_artifact.tf)$ ]]
    if [[ "$f" =~ $(echo ^\($(paste -sd'|' $CURRENT_DIR/scripts/ignore_files)\)$) ]]
    then
        echo "Skipping $f"
    else
        echo $f
        cp $f $PROJ_DIR
    fi
done

cd $PROJ_DIR
terraform init
terraform apply -auto-approve