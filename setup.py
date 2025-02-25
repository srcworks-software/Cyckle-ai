from setuptools import setup, Extension
from Cython.Build import cythonize

# Define the include path for Python headers
include_dirs = ["/usr/include/python3.13"]

# Define the extension module
extensions = [
    Extension(
        name="main",
        sources=["main.pyx"],
        include_dirs=include_dirs,
        extra_compile_args=["-fPIC"],  # Add the -fPIC flag
    )
]

# Setup the package
setup(
    ext_modules=cythonize(extensions)
)