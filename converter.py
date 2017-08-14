fin = open('music.txt', 'r')
fout = open('binary.txt', 'w')

result = ''
binary = {}

def generateNoteHash():
    # dictionary of notes
    # 17 notes per octave
    # only 12 frequencies
    # 3 octaves required and 1 note
    # 52 notes in required range
    # 37 frequencies in required range
    # dictionary requires 38 entries to include rest
    binary['rest'] = 0

    count = 1
    octave = 3

    #range is actually A3 to G6
    while count <= 38:
        for letter in ['c', 'd', 'e', 'f', 'g', 'a', 'b']:
            # flat
            # C and F do not have flats
            if letter != 'c' and letter != 'f':
                binary[letter + str(octave) + 'b'] = format(count, '06b')
                count += 1
            
            # normal
            binary[letter + str(octave)] = format(count, '06b')
            count += 1

            # sharp
            # B and E do not have sharps
            if letter != 'b' and letter != 'e':
                binary[letter + str(octave) + '#'] = format(count, '06b')

            if letter == 'g':
                octave += 1

    binary['c6'] = format(count, '06b')

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

def ASCIItoBinaryNote():

def ASCIItoBinaryDuration():

########## MAIN ##########
generateNoteHash()
lines = readFile(fin)
print(lines)


# print(binary)