#!/bin/bash
# Run ipython notebook tests

base_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
ipynb_dir=$base_dir/..

cmd="py.test --nbval"
test_ops="-v --sanitize-with $base_dir/sanitize_output_cells.txt"

pushd $ipynb_dir
testfail=0
##############################################################################
# add new notebooks here and increment the testfail number to distinct failing
# notebooks upon errors.

###################
# TEST APPLICATIONS

pushd applications/pentapeptide_msm
$cmd $test_ops "pentapeptide_msm.ipynb" || let "testfail++"
popd

# BPTI
pushd applications/bpti_msm
$cmd $test_ops "Estimate_BPTI_MSM.ipynb" || let "testfail++"
$cmd $test_ops "TPT_BPTI.ipynb" || let "testfail++"
popd

##############
# TEST METHODS

# Model selection/validation
pushd methods/model_selection_validation
$cmd $test_ops "model_selection_validation.ipynb" || let "testfail++"
popd

# TPT
pushd methods/tpt
$cmd $test_ops "tpt.ipynb" || let "testfail++"
popd


##############################################################################
# leave this alone
popd 
if [ $testfail -gt 0 ]
then
    exit $testfail
fi

