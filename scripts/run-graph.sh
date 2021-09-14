#!/bin/bash  
#SBATCH --exclusive
#SBATCH -o ../logs/run-graph.out-%j

WDIR="/home/gridsan/tdn/pr-graph"
CLASSPATH="$WDIR/bin/:$WDIR/libs/optimization-2010.11.jar:$WDIR/libs/trove-2.0.2.jar:$WDIR/libs/args4j-2.0.10.jar"

lang="english"
lname="english-small-ptb"
umap="ptb"

java -cp $CLASSPATH -Xmx8000m programs.TestPosGraphBuilder  \
-data-path "$WDIR/data/langs/$lang/$lname.train,$WDIR/data/langs/$lang/$lname.test" \
-suffix-path "$WDIR/data/suffix.dict" \
-umap-path "$WDIR/data/univmap/$lang-$umap.map" \
-num-neighbors 60 \
-ngram-path "$WDIR/data/graph/temp-$lang-$lname-$umap-60nn.idx" \
-lang-name "$lname" \
-graph-path "$WDIR/data/graph/temp-$lang-$lname-$umap-60nn.grph" \
-encoding "LATIN1"
