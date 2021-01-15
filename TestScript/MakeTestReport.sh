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

    echo berimbau -s "vk_send 36" #enter KEY
    sleep 70
    GetScreenShot
    n=1
    while [ $n -le $max_loop ]
    do
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
    echo "====== Test $1 Results ======"
    echo "=========================="
    for value in ${results[@]}; do
        echo $value > jsonOutput.txt
    done
    GetFormatedResults
    echo "Test ended"
}

GetFormatedResults(){
tmpCsv="$(<jsonOutput.csv)"
for tmpValue in ${tmpCsv[@]}; do
    echo $tmpValue
done
}

ChangeTS(){

}

StartApplication(){
    echo "=============================="
    echo "==== Starting Application ===="
    n=1
    while [ $n -le $testsLength ]
    do
        ChangeTS
        sleep 70
        ExecuteTest $n
        sleep 5
        PrintTestResults $n
        convertJsonToCsv # fazer ele acumular os testes anteriores
    done
    echo "===== End of Application ====="
    echo "=============================="
}

max_loop=5
testsLength=3 #! quantity of tests
results=()

# Start the test
StartApplication

# Print test result
# PrintTestResults

# ParseToCSV results
# convertJsonToCsv