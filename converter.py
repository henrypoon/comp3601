fin = open('music.txt', 'r')
fout = open('binary.txt', 'w')

noteHash = {}
durationHash = {}

def generateNoteHash():
    # dictionary of notes
    # 17 notes per octave
    # only 12 frequencies
    # 3 octaves required and 1 note
    # 52 notes in required range
    # 37 frequencies in required range
    # dictionary requires 38 entries to include rest
    noteHash['rest'] = 0

    count = 1
    octave = 3

    #range is actually A3 to G6
    while count <= 38:
        for letter in ['c', 'd', 'e', 'f', 'g', 'a', 'b']:
            # flat
            # C and F do not have flats
            if letter != 'c' and letter != 'f':
                noteHash[letter + str(octave) + 'b'] = format(count, '06b')
                count += 1
            
            # normal
            noteHash[letter + str(octave)] = format(count, '06b')
            count += 1

            # sharp
            # B and E do not have sharps
            if letter != 'b' and letter != 'e':
                noteHash[letter + str(octave) + '#'] = format(count, '06b')

            if letter == 'g':
                octave += 1

    noteHash['c6'] = format(count, '06b')

def generateDurationHash():
    durationHash['sq'] = format(0, '04b')
    durationHash['t'] = format(1, '04b')
    durationHash['q'] = format(2, '04b')
    durationHash['dq'] = format(3, '04b')
    durationHash['c'] = format(4, '04b')
    durationHash['dc'] = format(5, '04b')
    durationHash['m'] = format(6, '04b')
    durationHash['dm'] = format(7, '04b')
    durationHash['sb'] = format(8, '04b')
    durationHash['b'] = format(9, '04b')

def readFile(fileName):
    lines = []
    # store text file in a list
    for line in fileName:
        # ignore leading and trailing whitespace
        # case insensitive
        line = line.strip().lower()
        # ignore comments
        line = removeComments(line)
        # ignore empty lines
        if line:
            # split notes and durations and store in lines
            temp = line.split()
            lines += temp
    return(lines)

def removeComments(line):
    # ignore everthing after '%' and remove trailing whitespace
    if '%' in line:
        line = list(line)
        index = line.index('%')
        line = ''.join(line)
        line = line[0:index]
        line = line.strip()
    return(line)

#BPM and timing between notes

def ASCIItoBinaryNote(noteASCII):
    return(noteHash[noteASCII])

def ASCIItoBinaryDuration(durationASCII):
    return(durationHash[durationASCII])

def conversion(lines):
    timing = 0
    bpm = 80
    bpmFlag = 0
    count = 0
    converted = ''
    for line in lines:
        # set bpm
        if line == "bpm":
            bpmFlag = 1
        elif bpmFlag == 1:
            bpm = int(line)
            bpmFlag = 0
        # set timing
        # default is already normal so normal can be ignored
        elif line == "slurred":
            timing = 1
        elif line == "stacatto":
            timing = 2
        # convert notes to binary
        elif count == 0:
            converted += ASCIItoBinaryNote(line)
            count = 1
        else:
            converted += ASCIItoBinaryDuration(line) +"00\n"
            count = 0
    converted = format(timing, '03b') + format(bpm, '07b') + "00\n" + converted
    return(converted)

########## MAIN ##########
generateNoteHash()
generateDurationHash()
lines = readFile(fin)
# print(lines)
result = conversion(lines)
print(result)