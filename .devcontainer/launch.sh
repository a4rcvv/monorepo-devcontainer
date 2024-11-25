#!/bin/bash

# chown mounted volumes
volume_dirs="
/workspace/backend/.venv
/workspace/lambda/python/func/.venv
/opt/uv_cache
/opt/npm_cache
/workspace/frontend/node_modules
/workspace/lambda/node/func/node_modules
"
for dir in $volume_dirs; do
  echo "chown $dir"
  sudo chown -R vscode:vscode $dir
done

# install python dependencies
python_root_dirs="
/workspace/backend
/workspace/lambda/python/func
"
for dir in $python_root_dirs; do
  cd $dir
  echo "creating virtual environment in $dir"
  uv venv --allow-existing .venv
  echo "done!"
  if [ -f "uv.lock" ]; then
    echo "installing python dependencies in $dir"
    uv sync --frozen --no-install-project --all-extras
    echo "done!"
  else
    echo "no uv.lock file found in $dir. skipping"
  fi
done

# install node dependencies
node_root_dirs="
/workspace/frontend
/workspace/lambda/node/func
"
for dir in $node_root_dirs; do
  cd $dir
  if [ -f "package.json" ]; then
    echo "installing node dependencies in $dir"
    npm install
    echo "done!"
  else
    echo "no package.json file found in $dir. skipping"
  fi
done

# launch supervisord
cd /workspace/.devcontainer
supervisord