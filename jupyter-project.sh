#!/bin/bash
set -e

README='jupyter-readme.md'

echo "A script to install Jupyter in a new Python project folder"
echo
echo "This will:"
echo "1. create a new project folder"
echo "2. create a new python 3 virtual environment in that folder"
echo "3. install Jupyter Lab files in that folder"
echo "4. add a readme file in the project folder with instructions"
echo
echo "Use this script at your own risk.  It may not work on all Chromebooks or setups."
echo "This has been tested on a clean powerwashed Google Pixelbook."
echo 
read -p "Press return to continue ... or Ctrl-C to cancel." START

PWD=$(pwd)
echo
read -e -i "$PWD/project" -p "Input name of Jupyter project folder to be created: " PROJECT

echo
echo "Creating '$PROJECT' project folder ..."
mkdir $PROJECT

echo
echo "Checking Python versions installed"

for I in python3.10 python3.9 python3.8 python3.7 python3.6 python3.5 python3
do 
    if [[ $(which $I) == "" ]]
    then
        echo "- $I not installed."
    else
        echo "- $I IS installed at - $(which $I)"   
        read -n 1 -p "Shall I use $I for the virtual environment?  (y/n): " CONFIRM
        echo
        if [[ $CONFIRM == "Y" || $CONFIRM == "y" ]]
        then
            PYTHON=$(which $I)
            break
        fi
    fi
done 

if [[ $PYTHON == "" ]]
then
    echo
    echo "Error - You need to select one of the python versions."
    exit 1
fi

echo
read -e -i ".venv" -p "Name of virtual environment to be created: " VENV

echo
echo "Creating virtual environment $VENV ..."

virtualenv -p $PYTHON $PROJECT/$VENV

echo "Done."

echo
echo "Installing Jupyter Lab in the virtual environment"

source $PROJECT/$VENV/bin/activate

pip install jupyterlab

echo "Done."

cp readme-files/$README $PROJECT

echo
echo "Check out the $README file in the project folder for more basic instructions."
echo
echo "Finished."
