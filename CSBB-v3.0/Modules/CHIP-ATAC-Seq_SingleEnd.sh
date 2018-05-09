#!/bin/bash
FASTQ1=$1
BOWTIE_INDEX=$2
OUTPUT=$3
FASTQC_OUT=$4
BAMTOBIGWIG=$5
CHROMSIZE=$6
PEAKCALLDIR=$7
GENOMESIZE=$8
FILENAME=$9
echo Started Fastqc Run !!
fastqc -o $FASTQC_OUT $FASTQ1
echo Started Bowtie2 Run !!
bowtie2 -x $BOWTIE_INDEX -q -U $FASTQ1 -S $OUTPUT.sam
echo Converting sam to bam
samtools view -b -o $OUTPUT.bam $OUTPUT.sam
echo Sorting Bam
samtools sort $OUTPUT.bam -o $OUTPUT.sorted.bam
echo Removing Temp Files !!
rm $OUTPUT.sam
rm $OUTPUT.bam
echo Removing Duplicate Reads !!
samtools markdup -r $OUTPUT.sorted.bam $OUTPUT.final.bam
echo Removing Temp Files !!
rm $OUTPUT.sorted.bam
samtools sort $OUTPUT.final.bam -o $OUTPUT.final.sorted.bam
samtools index $OUTPUT.final.sorted.bam
rm $OUTPUT.final.bam
echo Converting Bam to BigWig !!
bedtools genomecov -bg -ibam $OUTPUT.final.sorted.bam -g $CHROMSIZE > $OUTPUT.bedGraph
sort -k 1,1 -k2,2n $OUTPUT.bedGraph > $OUTPUT.sorted.bedGraph
$BAMTOBIGWIG $OUTPUT.sorted.bedGraph $CHROMSIZE $OUTPUT.bw
echo Removing Temp Files !!
rm $OUTPUT.bedGraph
rm $OUTPUT.sorted.bedGraph
echo Calling Peaks !!
macs2 callpeak -t $OUTPUT.final.sorted.bam --buffer-size 2000 -f BAM -g $GENOMESIZE -n $FILENAME.narrowpeaks --call-summits --outdir $PEAKCALLDIR/$FILENAME.narrowpeaks
macs2 callpeak -t $OUTPUT.final.sorted.bam --buffer-size 2000 -f BAM -g $GENOMESIZE -n $FILENAME.broadpeaks --broad --broad-cutoff 0.1 --outdir $PEAKCALLDIR/$FILENAME.broadpeaks