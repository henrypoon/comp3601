#1/usr/bin/python3

import json

fin = open('input.json', 'r')
fout = open('binary.txt', 'w')

def generateNoteHash():
    # dictionary of notes
    # 21 notes per octave
    # only 12 frequencies
    # 3 octaves required and 1 note
    # 64 notes in required range
    # 37 frequencies in required range
    # dictionary requires 38 entries to include rest
    noteHash['rest'] = 0

    count = 1
    octave = 3

    #actual range in hash goes slightly beyond required range
    while count <= 38:
        for letter in ['c', 'd', 'e', 'f', 'g', 'a', 'b']:
            # flat
            noteHash[letter + str(octave) + 'b'] = format(count, '06b')
            count += 1
            
            # normal
            noteHash[letter + str(octave)] = format(count, '06b')
            count += 1

            # sharp
            noteHash[letter + str(octave) + '#'] = format(count, '06b')
            if letter == 'e' or letter == 'b':
                count -= 1

            if letter == 'g':
                octave += 1

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

def ASCIItoBinaryNote(noteASCII):
    return(noteHash[noteASCII])

def FractiontoBinaryDuration(durationFraction):
    return(durationHash[durationFraction])

def conversion():
    timing = 0
    bpm = 80
    count = 0
    converted = ''
    # set bpm
    bpm = int(parsedJson["bpm"])

    # set timing
    # default is already normal so normal can be ignored
    jsonTiming = parsedJson["mode"]
    if jsonTiming == "slurred":
        timing = 1
    elif jsonTiming == "staccato":
        timing = 2

    # convert notes to binary
    notes = parsedJson["song"].split("|")
    for i in range(0, len(notes)-1, 2):
        converted += ASCIItoBinaryNote(notes[i]) + " " + FractiontoBinaryDuration(notes[i+1]) + "00\n"
    converted = format(timing, '03b') + format(bpm, '07b') + "00\n" + converted
    return(converted)

jsonLine = ""
outputString = ""
noteHash = {}
durationHash = {}
generateNoteHash()
generateDurationHash()

for line in fin:
    jsonLine += line.strip()
parsedJson = json.loads(jsonLine)

conversion()

fout.write(outputString)

fin.close()
fout.close()