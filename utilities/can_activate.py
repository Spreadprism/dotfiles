import os
import sys
from pathlib import Path

if os.getenv("CONDA_PREFIX"):
    sys.exit(1)

# TODO: should have a better way to find conda home
conda_home = Path.home() / "miniconda3"

if not conda_home.exists():
    print("No conda home found...")
    sys.exit(1)

cwd = Path(os.getcwd()).name

conda_envs = conda_home / "envs"
found = False
for directory in conda_envs.iterdir():
    if directory.name == cwd or directory.name == cwd + "_env":
        found = True
        break

sys.exit(0 if found else 1)
