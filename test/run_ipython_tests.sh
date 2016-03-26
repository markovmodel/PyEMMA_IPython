#!/bin/bash
# Run ipython notebook tests

base_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
ipynb_dir=$base_dir/..
pushd $ipynb_dir
testfail=0
##############################################################################
# add new notebooks here and increment the testfail number to distinct failing
# notebooks upon errors.

###################
# TEST APPLICATIONS

pushd applications/pentapeptide_msm
python $base_dir/ipynbtest.py "pentapeptide_msm.ipynb" || let "testfail++"
popd

# BPTI
pushd applications/bpti_msm
python $base_dir/ipynbtest.py "Estimate_BPTI_MSM.ipynb" || let "testfail++"
python $base_dir/ipynbtest.py "TPT_BPTI.ipynb" || let "testfail++"
popd

##############
# TEST METHODS

# Model selection/validation
pushd methods/model_selection_validation
python $base_dir/ipynbtest.py "model_selection_validation.ipynb" || let "testfail++"
popd

# TPT
pushd methods/tpt
python $base_dir/ipynbtest.py "tpt.ipynb" || let "testfail++"
popd


##############################################################################
# leave this alone
popd 
if [ $testfail -gt 0 ]
then
    exit $testfail
fi

