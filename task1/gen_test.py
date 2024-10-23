import math
import numpy as np

def create_all_arr():
    array = np.zeros((16, 4), bool)
    num = 0
    for i in range(2):
        for j in range(2):
            for k in range(2):
                for m in range(2):
                    array[num] = [i, j, k, m]
                    num += 1
    return array

def write_array_to_file(array, file):
    for i in range(len(array)):
        file.write(str(int(array[i])))

def write_two_var_and_answer(a, b, func, f):
    assert (len(a) == len(b))
    for i in range(len(a)):
        for j in range(i, len(b)):
            write_array_to_file(a[i], f)
            write_array_to_file(b[j], f)
            write_array_to_file(func(a[i], b[j]), f)
            f.write("\n")

def write_two_var_and_not_answer(a, b, func, f):
    assert (len(a) == len(b))
    for i in range(len(a)):
        for j in range(i, len(b)):
            write_array_to_file(a[i], f)
            write_array_to_file(b[j], f)
            write_array_to_file(np.logical_not(func(a[i], b[j])), f)
            f.write("\n")

def write_two_var_and_all_answers(a, b, f):
    assert (len(a) == len(b))
    for i in range(len(a)):
        for j in range(i, len(b)):
            write_array_to_file(a[i], f)
            write_array_to_file(b[j], f)
            write_array_to_file(a[i], f)
            write_array_to_file(np.logical_not(a[i]), f)
            write_array_to_file(np.logical_and(a[i], b[j]), f)
            write_array_to_file(np.logical_not(np.logical_and(a[i], b[j])), f)
            write_array_to_file(np.logical_or(a[i], b[j]), f)
            write_array_to_file(np.logical_not(np.logical_or(a[i], b[j])), f)
            write_array_to_file(np.logical_xor(a[i], b[j]), f)
            write_array_to_file(np.logical_not(np.logical_xor(a[i], b[j])), f)
            f.write("\n")

def y(a, f):
    for i in range(len(a)):
        write_array_to_file(a[i], f)
        write_array_to_file(a[i], f)
        f.write("\n")
    return a

def ynot(a, f):
    for i in range(len(a)):
        write_array_to_file(a[i], f)
        write_array_to_file(np.logical_not(a[i]), f)
        f.write("\n")
    return np.logical_not(a)

def yand(a, b, f):
    write_two_var_and_answer(a, b, np.logical_and, f)
    return np.logical_and(a, b)

def ynand(a, b, f):
    write_two_var_and_not_answer(a, b, np.logical_and, f)
    return np.logical_not(np.logical_and(a, b))

def yor(a, b, f):
    write_two_var_and_answer(a, b, np.logical_or, f)
    return np.logical_or(a, b)

def ynor(a, b, f):
    write_two_var_and_not_answer(a, b, np.logical_or, f)
    return np.logical_not(np.logical_or(a, b))

def yxor(a, b, f):
    write_two_var_and_answer(a, b, np.logical_xor, f)
    return np.logical_xor(a, b)

def ynxor(a, b, f):
    write_two_var_and_not_answer(a, b, np.logical_xor, f)
    return np.logical_not(np.logical_xor(a, b))

f = open('tests.txt', 'w')

a = create_all_arr()
b = create_all_arr()

write_two_var_and_all_answers(a, b, f)
f.close()
