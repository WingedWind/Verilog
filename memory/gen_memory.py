import numpy as np
import random

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

def write_part_test(random_write, index, file):
    file.write(str('{:08b}'.format(index)))
    write_array_to_file(random_write, file)
    # write_array_to_file(random_write, file)
    file.write("\n")

def test_top(array, file, num):
    for i in range(num + 1):
        index = i * (int(len(array) / num))
        if (index < 256):
            random_write = random.choice(array)
            file.write("11")
            write_part_test(random_write, index, file)
            file.write("10")
            write_part_test(random_write, index, file)
            file.write("00")
            write_part_test(random_write, index, file)

f = open('memory_tests.txt', 'w')
a = create_all_arr()
test_top(a, f, 84)
f.close()