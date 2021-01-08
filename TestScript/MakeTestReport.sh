#!/bin/bash

GetScreenShot()
{
    import -window root ./screenshots/screenshot.png
}

GetQRCodeData()
{
    echo $(python3 ReadQRCode.py ./screenshots/screenshot.png)
}

ExecuteTest()
{
    echo "=========================="
    echo "==== Test $1 ===="
    echo "=========================="

    n=1
    while [ $n -le $max_loop ]
    do
        GetScreenShot
        result=$(GetQRCodeData)
        if [[ $result == "" ]]; then
            echo "FAILED Loop [$n/$max_loop]"
        else
            echo "PASSED Loop [$n/$max_loop]"
            results+=("$result")
            break
        fi
        n=$(($n + 1))
        sleep 10
    done
}

PrintTestResults()
{
    echo "=========================="
    echo "====== Test Results ======"
    echo "=========================="
    for value in ${results[@]}; do
        echo $value
    done
}

max_loop=5
results=()

# SetupTest1()
ExecuteTest 1

# SetupTest1()
ExecuteTest 2

# SetupTest1()
ExecuteTest 3

# Print test result
PrintTestResults

# TODO: parse results array to python function and get CSV file (report)
# ParseToCSV results