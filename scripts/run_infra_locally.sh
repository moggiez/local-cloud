#!/bin/bash
# Runs IaC code with LocalStack and local Terraform Backend

NAME=$1
CURRENT_DIR=$(pwd)
PARENT_DIR=$(dirname $CURRENT_DIR)
PROJ_DIR=$CURRENT_DIR/temp/$NAME
INFRA_DIR=$CURRENT_DIR/temp/$NAME/infrastructure
TEMPLATES_DIR=$INFRA_DIR/templates

mkdir -p $PROJ_DIR
mkdir -p $TEMPLATES_DIR
cp ./infrastructure/main.tf $INFRA_DIR
cd $PARENT_DIR/$NAME
make build

TF_FILES=$(find . -type f -name "*.tf")
JSON_FILES=$(find . -type f -name "*.json")

for f in $TF_FILES
do
    # if [[ "$f" =~ ^(main.tf|code_artifact.tf)$ ]]
    b=$(basename $f)
    if [[ "$b" =~ $(echo ^\($(paste -sd'|' $CURRENT_DIR/scripts/ignore_files)\)$) ]]; then
        # echo "Skipping $f"
        :
    elif [[ "$f" == *".terraform/modules"* ]]; then
        # echo "Skipping module file $f"
        :
    else
        echo "Copy $f"
        cp $f $INFRA_DIR
    fi
done

for jf in $JSON_FILES
do 
    if [[ "$jf" == *"templates/"* ]]; then
        echo "Copy $jf"
        cp $jf $INFRA_DIR/templates
    else
        # echo "Skipping $jf"
        :
    fi
done

rm -rf $CURRENT_DIR/temp/$NAME/dist
echo "Copy $PARENT_DIR/$NAME/dist"
cp -r $PARENT_DIR/$NAME/dist $CURRENT_DIR/temp/$NAME/dist

cd $INFRA_DIR
# Cleanup modules
rm -rf $INFRA_DIR/.terraform/modules
terraform init
terraform apply -auto-approve