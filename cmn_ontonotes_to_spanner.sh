#! /usr/bin/env bash

SRC_DIR=/exp/scale19/data/ner/cmn-ontonotes-extended/partitions/entity80-10-10
TGT_DIR=/exp/${USER}/spanner/data/cmn_ontonotes_extended
mkdir -p ${TGT_DIR}

python bio2spanner.py --src ${SRC_DIR}/train.iob2.txt --dst ${TGT_DIR}/spanner.train
python bio2spanner.py --src ${SRC_DIR}/dev.iob2.txt   --dst ${TGT_DIR}/spanner.dev
python bio2spanner.py --src ${SRC_DIR}/test.iob2.txt  --dst ${TGT_DIR}/spanner.test

# eof
