#!/bin/bash
# Run ipython notebook tests

base_dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
ipynb_dir=$base_dir/..
pushd $ipynb_dir
testfail=0
##############################################################################
# add new notebooks here and increment the testfail number to distinct failing
# notebooks upon errors.
pushd BPTI
python $base_dir/ipynbtest.py "Estimate_BPTI_MSM.ipynb" || testfail=1
python $base_dir/ipynbtest.py "TPT_BPTI.ipynb" || testfail=2
popd
pushd md2msm_penta_peptide
python $base_dir/ipynbtest.py "md2msm_penta_peptide.ipynb" || testfail=2
popd
pushd tryp_ben
python $base_dir/ipynbtest.py "CA_contacts_tryp_ben.ipynb " || testfail=3
popd

##############################################################################
# leave this alone
popd 
if [ $testfail -gt 0 ]
then
    exit $testfail
fi

