fin = open('music.txt', 'r')
fout = open('binary.txt', 'w')
result = ''

# store text file in a list
lines = []
for line in fin:
    # ignore leading and trailing whitespace
    # case insensitive
    line = line.strip().lower()
    # ignore empty lines
    if line:
        # ignore comments
        if '%' in line:
            line = list(line)
            index = line.index('%')
            line = ''.join(line)
            line = line[0:index]
        lines.append(line)

# dictionary of notes
# 17 notes per octave
# 4 octaves required
# 68 notes in required range
# rest
# total 69 items
binary = {}

binary['rest'] = 0

count = 1

#range is actually A3 to G6
for octave in range(3, 7):
    for letter in ['a', 'b', 'c', 'd', 'e', 'f', 'g']:
        # flat
        # C and F do not have flats
        if letter != 'c' or letter != 'f':
            binary[letter + str(octave) + '#'] = count
            count += 1

        # normal
        binary[letter + str(octave)] = count
        count += 1

        # sharp
        # B and E do not have sharps
        binary[letter + str(octave) + 'b'] = count
        count += 1

#BPM and timing between notes
for line in lines:
    print(line)

print(binary)