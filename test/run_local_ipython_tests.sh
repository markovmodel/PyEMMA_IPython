#!/bin/bash
# Run ipython notebook tests

base_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
ipynb_dir=$base_dir/..
pushd $ipynb_dir
testfail=0
##############################################################################
# add new notebooks here and increment the testfail number to distinct failing
# notebooks upon errors.

################################################
# TEST NOTEBOOKS THAT DEPEND ON UNPUBLISHED DATA
# MUST PUT DATA IN ./unpublished 

# BPTI Application
pushd applications/bpti_msm
python $base_dir/ipynbtest.py "MSM_BPTI.ipynb" || testfail=1

# BPTI Feature selection
pushd methods/feature_selection
python $base_dir/ipynbtest.py "feature_selection.ipynb" || testfail=1
popd


##############################################################################
# leave this alone
popd 
if [ $testfail -gt 0 ]
then
    exit $testfail
fi

