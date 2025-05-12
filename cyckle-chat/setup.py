from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        name="main",
        sources=["main.pyx"],
        extra_compile_args=["-O3","-fPIC"],
    )
]

setup(
    name="CyckleAI",
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            "language_level": 3,
            "boundscheck": False,
            "wraparound": False,
            "cdivision": True,
            "nonecheck": False,
        },
        cache=True
    ),
    zip_safe=False,
)