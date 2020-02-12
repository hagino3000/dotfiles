mkdir -p ~/dev/jupyter
mkdir -p ~/dev/jupyter/notebook_root

# Install Jupyter
cd ~/dev/jupyter
virtualenv ./env -p /usr/bin/python3
./env/bin/pip install jupyter

# Add Kernel A
cd ~/dev/a
./.venv/bin/pip install ipykernel
./.venv/bin/python -m ipykernel install --user --name a --display-name "Python3 (a)"

# ./.venv/bin/python -m ipykernel install --prefix=/path/to/jupyter/env --user --name a --display-name "Python3 (a)"

# Add Kernel B
cd ~/dev/b
./.venv/bin/pip install ipykernel
./.venv/bin/python -m ipykernel install --user --name b --display-name "Python3 (b)"


# Run
cd ~/dev/jupyter
./env/bin/jupyter notebook --ip=0.0.0.0 --notebook-dir=./notebook_root
