#!/bin/bash  
#SBATCH --exclusive
#SBATCH -o ../logs/run-pos.out-%j
#SBATCH --dependency=afterok:10931135

WDIR="/home/gridsan/tdn/pr-graph"
CLASSPATH="$WDIR/bin/:$WDIR/libs/optimization-2010.11.jar:$WDIR/libs/trove-2.0.2.jar:$WDIR/libs/args4j-2.0.10.jar"

lang="english"
lname="english-small-ptb"
umap="ptb"
gstr=1
sfid=0
lbs=100

java -cp $CLASSPATH -Xmx8000m programs.TestHighOrderPos -num-labels $lbs \
-data-path "$WDIR/data/langs/$lang/$lname.train,$WDIR/data/langs/$lang/$lname.test" \
-umap-path "$WDIR/data/univmap/$lang-$umap.map" \
-ngram-path "$WDIR/data/graph/temp-$lang-$lname-$umap-60nn.idx" \
-lang-name "$lname" \
-graph-path "$WDIR/data/graph/temp-$lang-$lname-$umap-60nn.grph" \
-sample-fold $sfid \
-eta 0.2 \
-backoff 1e-8 \
-gaussian-prior 100 \
-graph-strength $gstr \
-num-mstep-iters 300 \
-num-estep-iters 10 \
-em-stop 0.01 \
-estep-stop 0.01 \
-mstep-stop 0.00001 \
-num-em-iters 20 \
-num-threads 4 \
-output-path "$WDIR/output/$lang-$lname-f$sfid-100lb-gstr$gstr" \
-encoding "LATIN1" 

