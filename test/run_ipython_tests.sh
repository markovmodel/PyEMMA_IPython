#!/bin/bash
# Run ipython notebook tests

base_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
ipynb_dir=$base_dir/..
pushd $ipynb_dir
testfail=0
##############################################################################
# add new notebooks here and increment the testfail number to distinct failing
# notebooks upon errors.
python $base_dir/ipynbtest.py "its.ipynb" || testfail=1
pushd Estimate_MSM
python $base_dir/ipynbtest.py "Estimate_BPTI_MSM.ipynb" || testfail=2
popd
pushd TPT
python $base_dir/ipynbtest.py "TPT_BPTI.ipynb" || testfail=3
python $base_dir/ipynbtest.py "TPT_AlanineDiP.ipynb" || testfail=4
popd
pushd Analyze_MSM
python $base_dir/ipynbtest.py "Analyze_MSM_AlanineDiP.ipynb" || testfail=5
popd
pushd md2msm_penta_peptide
python $base_dir/ipynbtest.py "md2msm_penta_peptide.ipynb" || testfail=6
popd

##############################################################################
# leave this alone
popd 
if [ $testfail -gt 0 ]
then
    exit $testfail
fi

