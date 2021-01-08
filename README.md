# Automatize test report
Little concept tool that will easy the tedious task to generate long tests reports.

## How to use
---
To run this tools, you must:
- Open index.html on Test1 folder
- Run MakeTestReport.sh on TestScript folder
- At each test (eg. Test 1, Test 2, etc) you may need to press "Start Test" to get new QRCode again
  
*Note: Must leave browser running index.html in visible plane*

## Know dependencies
List of installed packeges
- opencv
- pyzbar
- imagemagick

## Trobleshouting
---
After install dependencies and **READ** how to use this tool, and yet it does not work, try:

- Bash script may need execution permisison:
  - ```$~: chmod +x <file_name.sh>```
- Use [Google](www.google.com.br) for other issues

*Note: Look code to get more understanding, it is fairly easy to understand.*

## How it works
---
On HTML file, tester (or automated script) will press "Start Test". This will generate a QRCode with tests results.

Using python opencv and zBar libraries, this tools takes a screenshoot and tries to decode the QRCode. If decoding is possible, test is considered to "PASSED", if not it is tagged with "FAILED".

After test finishes it will return an array with test results.

## Future works
---
If prove to be usefull, this tool will be part of berimbau and Jenkins test suit.

## Todo
---
- Array to CSV (or another data structure) parser
