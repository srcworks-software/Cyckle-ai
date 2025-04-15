from setuptools import setup, Extension
from Cython.Build import cythonize

include_dirs = ["/usr/include/python3.13"]

extensions = [
    Extension(
        name="main",
        sources=["main.pyx"],
        include_dirs=include_dirs,
        extra_compile_args=["-fPIC"], 
    )
]

setup(
    ext_modules=cythonize(extensions)
)