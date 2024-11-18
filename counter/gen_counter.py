import math
import numpy as np

def create_all_arr():
    array = np.zeros((256, 8), bool)
    num = 0
    for i in range(2):
        for j in range(2):
            for k in range(2):
                for m in range(2):
                    for n in range(2):
                        for l in range(2):
                            for g in range(2):
                                for h in range(2):
                                    array[num] = [i, j, k, m, n, l, g, h]
                                    num += 1
    return array

def write_array_to_file(array, file):
    for i in range(len(array)):
        file.write(str(int(array[i])))
    return

def test_top(array, file, time, updn, num):
    for i in range(num + 1):
        index = i * (int(len(array) / num))
        if (index < 256):
            file.write("10000000000000000000")
            file.write("\n")
            file.write("0110")
            write_array_to_file(array[index], file)
            write_array_to_file(array[index], file)
            file.write("\n")
            for j in range(time):
                if(updn):
                    file.write("010100000000")
                    if ((index + j) > 255):
                        write_array_to_file(array[index + j - 256], file)
                    else:
                        write_array_to_file(array[index + j], file)
                else:
                    file.write("010000000000")
                    if (index - j < 0):
                        write_array_to_file(array[index - j + 256], file)
                    else:
                        write_array_to_file(array[index - j], file)
                file.write("\n")


f = open('counter_tests.txt', 'w')
a = create_all_arr()
test_top(a, f, 3, 0, 84)
f.close()