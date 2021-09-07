export WDIR="/home/gridsan/tdn/pr-graph"
export CLASSPATH="$WDIR/bin/:$WDIR/libs/optimization-2010.11.jar:$WDIR/libs/trove-2.0.2.jar:$WDIR/libs/args4j-2.0.10.jar"

lang=$1
lname=$2
umap=$3

echo $lang
echo $lname
echo $umap

umapPath="$WDIR/data/univmap/$lang-$umap.map"
echo $umapPath
cat $umapPath

java -cp $CLASSPATH -Xmx8000m programs.TestPosGraphBuilder  \
-data-path "$WDIR/data/langs/$lang/$lname.train,$WDIR/data/langs/$lang/$lname.test" \
-umap-path "$WDIR/data/univmap/$lang-$umap.map" \
-ngram-path "$WDIR/data/graph/temp-$lang-60nn.idx" \
-lang-name "$lname" \
-graph-path "$WDIR/data/graph/temp-$lang-60nn.grph" \
-encoding "LATIN1"
