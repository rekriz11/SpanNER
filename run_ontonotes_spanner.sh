#!/bin/sh
source ~/.bashrc
source activate myenv3.6

module load cuda11.2/toolkit
export PYTHONPATH="/exp/${USER}/code/SpanNER/"
cd /exp/${USER}/code/SpanNER/



DATA_DIR="/exp/${USER}/data/ner/en_ontonotes/spanner/"
PRETRAINED="bert-large-uncased"

#BERT_DIR="/exp/${USER}/spanner/bert_dir/"${PRETRAINED}
BERT_DIR=$PRETRAINED

dataname=ontonotes
n_class=5
BERT_DROPOUT=0.2
MODEL_DROPOUT=0.2
LR=1e-5
MAXLEN=128
MAXNORM=1.0
batchSize=10
max_spanLen=4
tokenLen_emb_dim=50
spanLen_emb_dim=100
morph_emb_dim=100


use_prune=True
use_spanLen=True
use_morph=True
use_span_weight=True
neg_span_weight=0.5
#gpus="7,"
#gpus=${CUDA_VISIBLE_DEVICES}
gpus=1
echo "GPUS: ${gpus}"


#max_epochs=30
max_epochs=3
modelName="spanner_"${PRETRAINED}_spMLen${max_span_len}_usePrune${use_prune}_useSpLen${use_spanLen}_useSpMorph${use_morph}_SpWt${use_span_weight}_value${neg_span_weight}
idtest=${dataname}_${modelName}
param_name=epoch${max_epochs}_batchsize${batchSize}_lr${LR}_maxlen${MAXLEN}

OUTPUT_DIR="/exp/${USER}/models/ner/spanner_${dataname}_${modelName}/"
mkdir -p $OUTPUT_DIR

python trainer.py \
--dataname $dataname \
--data_dir $DATA_DIR \
--bert_config_dir $BERT_DIR \
--bert_max_length $MAXLEN \
--batch_size $batchSize \
--gpus=$gpus \
--workers=10 \
--precision=16 \
--progress_bar_refresh_rate 100 \
--lr $LR \
--val_check_interval 1.0 \
--accumulate_grad_batches 1 \
--default_root_dir $OUTPUT_DIR \
--model_dropout $MODEL_DROPOUT \
--bert_dropout $BERT_DROPOUT \
--max_epochs $max_epochs \
--n_class $n_class \
--max_spanLen $max_spanLen \
--tokenLen_emb_dim $tokenLen_emb_dim \
--modelName $modelName \
--spanLen_emb_dim $spanLen_emb_dim \
--morph_emb_dim $morph_emb_dim \
--use_prune $use_prune \
--use_spanLen $use_spanLen \
--use_morph $use_morph \
--use_span_weight $use_span_weight \
--neg_span_weight $neg_span_weight \
--param_name $param_name \
--gradient_clip_val $MAXNORM \
--optimizer "adamw"

#--accelerator=dp \


# qsub -j y -l h_rt=24:00:00 -q gpu.q -l gpu=1 run_ontonotes_spanner.sh
