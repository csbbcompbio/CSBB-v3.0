#!/bin/bash
FASTQ1=$1
FASTQ2=$2
BOWTIE_INDEX=$3
OUTPUT=$4
FASTQC_OUT=$5
BAMTOBIGWIG=$6
CHROMSIZE=$7
PEAKCALLDIR=$8
GENOMESIZE=$9
FILENAME=${10}
echo Started Fastqc Run !!
fastqc -o $FASTQC_OUT $FASTQ1
fastqc -o $FASTQC_OUT $FASTQ2
echo Started Bowtie2 Run !!
bowtie2 -x $BOWTIE_INDEX -1 $FASTQ1 -2 $FASTQ2 -S $OUTPUT.sam
echo Converting sam to bam
samtools view -b -o $OUTPUT.bam $OUTPUT.sam
echo Sorting Bam
samtools fixmate -m $OUTPUT.bam $OUTPUT.temp.bam
samtools sort $OUTPUT.temp.bam -o $OUTPUT.temp.sorted.bam
echo Removing Temp Files !!
rm $OUTPUT.sam
rm $OUTPUT.bam
rm $OUTPUT.temp.bam
echo Removing Duplicate Reads !!
samtools markdup -r $OUTPUT.temp.sorted.bam $OUTPUT.final.bam
echo Removing Temp Files !!
rm $OUTPUT.temp.sorted.bam
samtools sort $OUTPUT.final.bam -o $OUTPUT.final.sorted.bam
samtools index $OUTPUT.final.sorted.bam
echo Removing Temp Files !!
rm $OUTPUT.final.bam
echo Converting Bam to BigWig !!
bedtools genomecov -bg -ibam $OUTPUT.final.sorted.bam -g $CHROMSIZE > $OUTPUT.bedGraph
sort -k 1,1 -k2,2n $OUTPUT.bedGraph > $OUTPUT.sorted.bedGraph
$BAMTOBIGWIG $OUTPUT.sorted.bedGraph $CHROMSIZE $OUTPUT.bw
echo Removing Temp Files !!
rm $OUTPUT.bedGraph
rm $OUTPUT.sorted.bedGraph
echo Calling Peaks !!
macs2 callpeak -t $OUTPUT.final.sorted.bam --buffer-size 2000 -f BAMPE -g $GENOMESIZE -n $FILENAME.narrowpeaks --call-summits --outdir $PEAKCALLDIR/$FILENAME.narrowpeaks
macs2 callpeak -t $OUTPUT.final.sorted.bam --buffer-size 2000 -f BAMPE -g $GENOMESIZE -n $FILENAME.broadpeaks --broad --broad-cutoff 0.1 --outdir $PEAKCALLDIR/$FILENAME.broadpeaks