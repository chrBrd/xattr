import os
import cffi

ffi = cffi.FFI()
dir_path = os.path.dirname(__file__)
with open(os.path.join(dir_path, '_lib.h')) as file:
    ffi.cdef(file.read())

with open(os.path.join(dir_path, '_lib.c')) as file:
    ffi.set_source('_lib', file.read())

if __name__ == '__main__':
    ffi.compile()
