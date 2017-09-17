import json

fin = open('input.json', 'r')
fout = open('ascii.txt', 'w')

def generateDurationHash():
    durationHash['1/4'] = format(0, '04b')
    durationHash['1/3'] = format(1, '04b')
    durationHash['1/2'] = format(2, '04b')
    durationHash['3/4'] = format(3, '04b')
    durationHash['1'] = format(4, '04b')
    durationHash['1 1/2'] = format(5, '04b')
    durationHash['2'] = format(6, '04b')
    durationHash['3'] = format(7, '04b')
    durationHash['4'] = format(8, '04b')
    durationHash['8'] = format(9, '04b')

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