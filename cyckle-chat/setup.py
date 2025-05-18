from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize

extensions = [
    Extension(
        name="cyckleapp.main",
        sources=["cyckleapp/main.pyx"],
        extra_compile_args=["-fPIC"],
    )
]

setup(
    name="CyckleAI",
    version="1.3.0",
    packages=find_packages(),
    ext_modules=cythonize(extensions, language_level="3"),
    zip_safe=False,
    include_package_data=True,
    package_data={"cyckleapp": ["data.json"]},
    entry_points={
        "console_scripts": [
            "cyckle = cyckleapp.main:main",  # assumes you have def main() in .pyx
        ]
    },
    install_requires=[
        r.strip() for r in open("requirements.txt") if r.strip()
    ]
)