import json

fin = open('input.json', 'r')
fout = open('ascii.txt', 'w')

jsonLine = ""
for line in fin:
    jsonLine += line.strip()
parsedJson = json.loads(jsonLine)

outputString = ""

outputString += parsedJson["mode"] + "\n"
outputString += parsedJson["bpm"] + "\n"
fout.write(outputString)

fin.close()
fout.close()