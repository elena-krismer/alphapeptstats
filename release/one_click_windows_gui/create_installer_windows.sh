#!bash

# Initial cleanup
rm -rf dist
rm -rf build
cd ../..
rm -rf dist
rm -rf build

# Creating a conda environment
conda create -n alphapeptstats_installer python=3.10 -y
conda activate alphapeptstats_installer

# Creating the wheel
python setup.py sdist bdist_wheel

# Setting up the local package
cd release/one_click_windows_gui
# Make sure you include the required extra packages and always use the stable or very-stable options!
pip install "../../dist/alphastats-0.6.2-py3-none-any.whl"

# Creating the stand-alone pyinstaller folder
pip install pyinstaller==5.8
pyinstaller ../pyinstaller/alphastats.spec -y
conda deactivate

# If needed, include additional source such as e.g.:
# cp ../../omiclearn/data/*.fasta dist/omiclearn/data

# Wrapping the pyinstaller folder in a .exe package
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" alphastats_innoinstaller.iss
# WARNING: this assumes a static location for innosetup
