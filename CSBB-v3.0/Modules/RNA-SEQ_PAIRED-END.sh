#!/bin/bash
FASTQ1=$1
FASTQ2=$2
QUAL=$3
BOWTIE_PATH=$4
RSEM_PATH=$5
RSEM_INDEX=$6
OUTPUT=$7
FASTQC_OUT=$8
BAMTOBIGWIG=$9
CHROMSIZE=${10}
echo Started Fastqc Run !!
fastqc -o $FASTQC_OUT $FASTQ1
fastqc -o $FASTQC_OUT $FASTQ2
echo Started RSEM Run !!
$RSEM_PATH --output-genome-bam --paired-end --num-threads 4 $QUAL --bowtie2 --bowtie2-path $BOWTIE_PATH $FASTQ1 $FASTQ2 $RSEM_INDEX $OUTPUT
samtools sort $OUTPUT.genome.bam -o $OUTPUT.genome.sorted.bam
samtools index $OUTPUT.genome.sorted.bam
echo Converting BAM to BigWig!!
bedtools genomecov -bg -split -ibam $OUTPUT.genome.sorted.bam -g $CHROMSIZE > $OUTPUT.bedGraph
sort -k 1,1 -k2,2n $OUTPUT.bedGraph > $OUTPUT.sorted.bedGraph
$BAMTOBIGWIG $OUTPUT.sorted.bedGraph $CHROMSIZE $OUTPUT.bw
echo Removing Temp Files !!
rm $OUTPUT.bedGraph
rm $OUTPUT.sorted.bedGraph
rm $OUTPUT.genome.bam
rm $OUTPUT.transcript.bam