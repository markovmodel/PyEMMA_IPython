#!/bin/bash
# Run ipython notebook tests

#ipynb_dir=.
base_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
ipynb_dir=$base_dir/..
#cd examples/ipython
pushd $ipynb_dir
testfail=0
python $base_dir/ipynbtest.py "its.ipynb" || testfail=1

popd 
if [ $testfail -gt 0 ]
then
    exit $testfail
fi

