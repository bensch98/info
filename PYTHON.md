# Python

### Example Python directory structure
- *README.md*
- */scripts:* for command-line interface stuff
- */test:* for unit tests
- */docs:* documentation
- */apidocs:* epydoc generated API docs or other automatically generated docs
- */projectname:* whole python package
- *setup.py* 


### Example tree structure
```text
.
├── data
├── docs
├── examples
├── extra
│   ├── script4.py
│   └── script5.py
├── LICENSE
├── project
│   ├── __init__.py
│   ├── __pycache__
│   │   ├── constants.cpython-39.pyc
│   │   └── __init__.cpython-39.pyc
│   ├── script1.py
│   └── sub-package
│       ├── __init__.py
│       └── script2.py
├── README.md
├── requirements.py
├── setup.py
└── test
    ├── __init__.py
        └── script3.py
```

### Setup.py

*example setup.py*
```python
#!/usr/bin/env python3

import os
from setuptools import setup
import pathlib
from projectname import __version__ 

readme = pathlib.Path(__file__).parent / 'README.md'
requirements = pathlib.Path(__file__).parent / 'requirements.txt'

with open(readme, 'r') as f:
  long_description = f.read()

with open(requirements, 'r') as f:
  install_requirements = f.read().splitlines()

setup(name='projectname',
      version='0.8.15',
      description='Short description of package',
      author='Benedikt Scheffler',
      license='MIT',
      long_description=long_description,
      long_description_content_type='text/markdown',
      packages = ['packagename'],
      classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License"
      ],
      install_requires=install_requirements,
      python_requires='>=3.8',
      include_package_data=True)
```

### Source and Build distribution

```bash
rm -rf dist build *.egg-info && \
  python setup.py sdist bdist_wheel && \
  echo -e "\n--- Wheel ---" && \
  unzip -l dist/*.whl && \
  echo -e "\n--- Source Distribution ---" && \
  tar --list -f dist/*.tar.gz
```

### Use package

> To use the python package the path to the repo must be specified in the PYTHONPATH or the package installed via `pip install -e .` to omit exporting the PATH. 

*via bash*
```bash
export $PYTHONPATH=/home/[USER]/path/to/repo/
```

*via Python*
```python
import sys
import os
# specifiy relative path to root of python package to enable absolute package references
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
```
