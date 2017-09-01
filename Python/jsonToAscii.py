import json

fin = open('input.json', 'r')

jsonLine = ""
for line in fin:
    jsonLine += line.strip()
    print jsonLine
parsedJson = json.loads(jsonLine)

for i in parsedJson:
    print(i)

fin.close()