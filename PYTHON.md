# Python

**Example Python directory structure:**
- *README.md*
- */scripts:* for command-line interface stuff
- */test:* for unit tests
- */docs:* documentation
- */apidocs:* epydoc generated API docs
- */projectname:* whole python package
- *setup.py:* 


**Example tree structure:**
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

*example setup.py*
```python
#!/usr/bin/env python3

import os
from setuptools import setup

directory = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(directory, 'README.md'), encoding='utf-8') as f:
  long_description = f.read()

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
      install_requires=['numpy', 'requests', 'pandas'],
      python_requires='>=3.8',
      include_package_data=True)
```


> To use the python package the path to the repo must be specified in the PYTHONPATH. 

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
