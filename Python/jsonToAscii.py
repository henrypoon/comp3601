import json

fin = open('input.json', 'r')
fout = open('ascii.txt', 'w')

def generateDurationHash():
    durationHash['1/4'] = "sq"
    durationHash['1/3'] = "t"
    durationHash['1/2'] = "q"
    durationHash['3/4'] = "dq"
    durationHash['1'] = "c"
    durationHash['1 1/2'] = "dc"
    durationHash['2'] = "m"
    durationHash['3'] = "dm"
    durationHash['4'] = "sb"
    durationHash['8'] = "b"

jsonLine = ""
outputString = ""
durationHash = {}
generateDurationHash()

for line in fin:
    jsonLine += line.strip()
parsedJson = json.loads(jsonLine)

outputString += parsedJson["mode"] + "\n"
outputString += parsedJson["bpm"] + "\n"

notes = parsedJson["song"].split("|")
for i in range(0, len(notes)-1, 2):
    outputString += notes[i] + " " + durationHash[notes[i+1]] + "\n"

fout.write(outputString)

fin.close()
fout.close()