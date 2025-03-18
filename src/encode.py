import sys


def predicate_of_char(row, col, char):
    if char == '.':
        return f'unknown({row}, {col}). '

    if char == '1':
        return f'at({row}, {col}, black). '
    
    if char == '0':
        return f'at({row}, {col}, white). '

    return '\n'


def encode(input, output):   
    with open(input, 'r') as in_file:
        with open(output, 'w') as out_file:
            sys.stdout = out_file

            [print(predicate_of_char(i, j, char), end = '')
             for (i, line) in enumerate(in_file)
             for (j, char) in enumerate(line)]


def main(args):
    if len(args) != 3:
        print('encode.py domXX.txt domXX.lp')
        sys.exit()
    
    return encode(args[1], args[2])


if __name__ == '__main__':
    main(sys.argv)
