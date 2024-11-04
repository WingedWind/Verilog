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

def mux0(d0, d1, s):
    a = np.logical_and(d0, np.logical_not(s))
    b = np.logical_and(d1, s)
    return np.logical_or(a, b)

def multiplex(d0, d1, d2, d3, s0, s1):
    q0 = mux0(d0, d1, s0)
    q1 = mux0(d2, d3, s0)
    q  = mux0(q0, q1, s1)
    return q

def write_four_var_and_answer(d0, d1, d2, d3, f):
    for i in range(len(d0)):
        for j in range(i, len(d1)):
            for k in range(len(d2)):
                for m in range(k, len(d3)):
                    for s0 in range(2):
                        for s1 in range(2):
                            write_array_to_file(d0[i], f)
                            write_array_to_file(d1[j], f)
                            write_array_to_file(d2[k], f)
                            write_array_to_file(d3[m], f)
                            f.write(str(s1))
                            f.write(str(s0))
                            write_array_to_file(multiplex(d0[i], d1[j], d2[k], d3[m], s0, s1), f)
                            f.write("\n")

def write_two_var_and_answer(d0, d1, f):
    for i in range(len(d0)):
        for j in range(i, len(d1)):
            for s in range(2):
                write_array_to_file(d0[i], f)
                write_array_to_file(d1[j], f)
                f.write(str(s))
                write_array_to_file(mux0(d0[i], d1[j], s), f)
                f.write("\n")

f1 = open('tests_mux_double_s.txt', 'w')

d0 = create_all_arr()
d1 = create_all_arr()
d2 = create_all_arr()
d3 = create_all_arr()

write_four_var_and_answer(d0, d1, d2, d3, f1)
f1.close()

f2 = open('tests_mux_one_s.txt', 'w')
write_two_var_and_answer(d0, d1, f2)
f2.close()

