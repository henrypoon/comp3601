fin = open('music.txt', 'r')
fout = open('binary.txt', 'w')
result = ''

# dictionary of notes
# 17 notes per octave
# only 12 frequencies
# 3 octaves required and 1 note
# 52 notes in required range
# 37 frequencies in required range
# dictionary requires 38 entries to include rest
binary = {}

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

print(binary)

#BPM and timing between notes


# store text file in a list
for line in fin:
    # ignore leading and trailing whitespace
    # case insensitive
    line = line.strip().lower()
    # ignore comments
    if '%' in line:
        line = list(line)
        index = line.index('%')
        line = ''.join(line)
        line = line[0:index]
        line = line.strip()
    # ignore empty lines
    if line:
        result += binary[line]

print(result)