#!/bin/bash

GetScreenShot()
{
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        import -window root ./screenshots/screenshot.png
    else
        magick convert screenshot: ./screenshots/screenshot.png
    fi
}

GetQRCodeData()
{
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo $(python3 ReadQRCode.py ./screenshots/screenshot.png)
    else
        echo $(py ReadQRCode.py ./screenshots/screenshot.png)
    fi
}

convertJsonToCsv()
{
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo $(python3 convertJsonToCsv.py)
    else
        echo $(py convertJsonToCsv.py)
    fi
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
        echo $value > jsonOutput.txt
    done
}

max_loop=5
results=()

# SetupTest1()
ExecuteTest 1

# SetupTest1()
# ExecuteTest 2

# SetupTest1()
# ExecuteTest 3

# Print test result
PrintTestResults

# ParseToCSV results
convertJsonToCsv