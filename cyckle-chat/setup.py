from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        name="main",
        sources=["main.pyx"],
        extra_compile_args=["-fPIC"],
    )
]

setup(
    name="CyckleAI",
    ext_modules=cythonize(extensions, language_level="3", cache=True),
    zip_safe=False,
)
