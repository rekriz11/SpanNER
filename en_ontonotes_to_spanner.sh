#! /usr/bin/env bash

SRC_DIR=/exp/${USER}/data/ner/en_ontonotes/original_sampling_100/
TGT_DIR=/exp/${USER}/data/ner/en_ontonotes/spanner_sampling_100/
mkdir -p ${TGT_DIR}

#python bio2spanner.py --src ${SRC_DIR}/train.txt --dst ${TGT_DIR}/spanner --split train
python bio2spanner.py --src ${SRC_DIR}/dev.txt   --dst ${TGT_DIR}/spanner.dev --split dev
python bio2spanner.py --src ${SRC_DIR}/test.txt  --dst ${TGT_DIR}/spanner.test --split test

# eof
