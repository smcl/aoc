#!/bin/bash

if test -f $1
then
    NOTEBOOK_FILE=$1
else
    NOTEBOOK_FILE=$1.ipynb
fi

if test -f $NOTEBOOK_FILE
then
    nbqa mypy $NOTEBOOK_FILE --no-color-output
    
    if [ $? -eq 0 ]; then
        nbqa flake8 $NOTEBOOK_FILE

        if [ $? -eq 0 ]; then
            nbqa black --quiet $NOTEBOOK_FILE
            nbqa isort --quiet $NOTEBOOK_FILE
        fi

    fi
else
    echo $NOTEBOOK_FILE does not exist, use "./test.sh day1.ipynb" etc
fi