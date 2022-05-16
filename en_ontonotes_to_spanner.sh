#! /usr/bin/env bash

SRC_DIR=/exp/${USER}/data/ner/en_ontonotes/original/
TGT_DIR=/exp/${USER}/data/ner/en_ontonotes/spanner/
mkdir -p ${TGT_DIR}

python bio2spanner.py --src ${SRC_DIR}/train.txt --dst ${TGT_DIR}/spanner.train
python bio2spanner.py --src ${SRC_DIR}/dev.txt   --dst ${TGT_DIR}/spanner.dev
python bio2spanner.py --src ${SRC_DIR}/test.txt  --dst ${TGT_DIR}/spanner.test

# eof
