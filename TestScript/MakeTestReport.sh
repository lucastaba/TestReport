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

ChangeApp(){
#  abre o applist, muda o app e inicia
echo "Changing Application"
    echo berimbau -s "vk_send XF86Apps" #Open AppList
    sleep 15
for programNumber in $1; do #! validar esse for
    echo berimbau -s "vk_send 40" #Down key
    sleep 5
done
    echo berimbau -s "vk_send 36" #start a new APP, enter Key
    sleep 5
}

StartApplication(){
    echo "=============================="
    echo "==== Starting Application ===="
    n=1
    while [ $n -le $testsLength ]
    do
        ChangeApp $n
        sleep 70
        ExecuteTest $n
        sleep 3
        PrintTestResults $n
        sleep 3
        convertJsonToCsv # needs upgrade, to store all tests, not only the last one
        sleep 3
        # ChangeTS
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