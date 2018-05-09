#!/usr/bin/perl
use Capture::Tiny ':all';
use English qw' -no_match_vars ';
print "\nOperating System is $OSNAME\n";
##### COMPUTATIONAL SUITE FOR BIOINFORMATICIANS & BIOLOGISTS ########
print "\n\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\n";
print "\nCSBB \- Computational Suite For Bioinformaticians and Biologists\n";
print "\n\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\n";
print "\nVersion\_3.0\n";
print "\nDeveloped and maintained by Praneet Chaturvedi\!\!\n";
print "\nPlease report issues and bugs on https://github.com/csbbcompbio/CSBB-v3.0\n";


################# TIME STAMP START ##################
my @timestamp;
open(TS,"TimeStamp_CSBB-v3.0.txt");
while(my $data = <TS>)
{
 chomp $data;
 push(@timestamp,$data);
}
close TS;
my $lastruncsbb=pop(@timestamp);
if($lastruncsbb eq "")
{
 my $timestamp_first = localtime(time);
 print "\nCSBB-v3.0 First run on $timestamp_first\n";
}
else
{
 print "\nCSBB-v3.0 Last run \: $lastruncsbb\n";
}
open(TS,">>TimeStamp_CSBB-v3.0.txt");
my $timestamp = localtime(time);
print "\nCurrent Run: $timestamp\n";
print TS "$timestamp\n";
close TS;
################# TIME STAMP END ##################


################ Log Directory ###################
use Cwd;
my $cwd = getcwd;
my $log_dir=$cwd."\/".'CSBB-v3.0_Logs';
if(-d $log_dir)
{
 print "\n$log_dir directory is already present\, CSBB will use the same to write module logs\n";
 sleep(1);
}
else
{
 mkdir($log_dir);
 print "\n$log_dir directory is created\, CSBB will use this directory to write module logs\n";
 sleep(1);
}
############### Log Directory End ###############



###Asking user input###
my $user_input=$ARGV[0]; chomp $user_input; ###user input through command line ##


#######################################################################
#######################################################################
############ CALLING MODULES BASED ON USER INPUT ###########

if(($user_input eq "--install")||($user_input eq "install"))
{
 &install;
}
if(($user_input eq "--help")||($user_input eq "help"))
{
 &help;
}
if(($user_input eq "UpperQuantile")||($user_input eq "--UpperQuantile")||($user_input eq "UQ"))
{
 my $file=$ARGV[1];
 &upperquantile($file);
}
if(($user_input eq "ExpressionToZscore")||($user_input eq "--ExpressionToZscore")||($user_input eq "E2Z"))
{
 my $file=$ARGV[1];
 &expressiontozscore($file);
}
if(($user_input eq "BasicStats")||($user_input eq "--BasicStats")||($user_input eq "BS"))
{
 my $file=$ARGV[1];
 &basicstats($file);
}
if(($user_input eq "ExtractGeneInfo")||($user_input eq "--ExtractGeneInfo")||($user_input eq "EGI"))
{
 my $file=$ARGV[1];
 my $file1=$ARGV[2];
 &extractgeneinfo($file,$file1);
}
if(($user_input eq "ExpressionPlot")||($user_input eq "--ExpressionPlot")||($user_input eq "EP"))
{
 my $file=$ARGV[1];
 &expressionplot($file);
}
if(($user_input eq "InteractiveHeatmap")||($user_input eq "--InteractiveHeatmap")||($user_input eq "IH"))
{
 my $file=$ARGV[1];
 my $clustering_type=$ARGV[2];
 my $color_theme=$ARGV[3];
 &interactiveheatmap($file,$clustering_type,$color_theme);
}
if(($user_input eq "CorrelationProfiles")||($user_input eq "--CorrelationProfiles")||($user_input eq "CP"))
{
 my $file=$ARGV[1];
 my $threshold=$ARGV[2];
 my $genesofinterest=$ARGV[3];
 my $typeOfCorr=$ARGV[4];
 &correlationprofile($file,$threshold,$genesofinterest,$typeOfCorr);
}
if(($user_input eq "Biogrid-Gene-Protein-Search")||($user_input eq "--Biogrid-Gene-Protein-Search")||($user_input eq "Biogrid"))
{
 my $organism=$ARGV[1];
 my $file=$ARGV[2];
 &biogrid($organism,$file);
}
if(($user_input eq "DifferentialExpression")||($user_input eq "--DifferentialExpression")||($user_input eq "DE"))
{
 my $file=$ARGV[1];
 my $numbercontrol=$ARGV[2];
 my $numbertreatment=$ARGV[3];
 my $countsthreshold=$ARGV[4];
 my $numbersamples=$ARGV[5];
 my $typeOfNormalization=$ARGV[6];
 &de($file,$numbercontrol,$numbertreatment,$countsthreshold,$numbersamples,$typeOfNormalization);
}
if(($user_input eq "PCA")||($user_input eq "--PCA"))
{
 my $file=$ARGV[1];
 &pca($file);
}
if(($user_input eq "NMF")||($user_input eq "--NMF"))
{
 my $file=$ARGV[1];
 &nmf($file);
}
if(($user_input eq "ProcessPublicData")||($user_input eq "--ProcessPublicData"))
{
 my $file=$ARGV[1];
 my $path=$ARGV[2];
 &ProcessPublic($file,$path);
}
if(($user_input eq "InteractiveScatterPlot")||($user_input eq "--InteractiveScatterPlot")||($user_input eq "IPS"))
{
 $file=$ARGV[1];
 $colx=$ARGV[2];
 $coly=$ARGV[3];
 $colenrichment=$ARGV[4];
 &interactivesp($file,$colx,$coly,$colenrichment);
}
if(($user_input eq "Process-RNASeq_SingleEnd")||($user_input eq "--Process-RNASeq_SingleEnd")||($user_input eq "RNASeq-Single"))
{
 my $file=$ARGV[1]; ####### Fastq File
 my $species=$ARGV[2]; ########### Works for human, mouse, frog and zebrafish
 my $Output_folder_name=$ARGV[3]; ######## Output folder name
 my $phred_qual=$ARGV[4];  #### Phred quality 33 or 64 [[[[ 33 if Ilumina encoding 1.8+ and rest 64]
 &ProcessRNASeqSingle($file,$species,$Output_folder_name,$phred_qual);
}
if(($user_input eq "Process-RNASeq_PairedEnd")||($user_input eq "--Process-RNASeq_PairedEnd")||($user_input eq "RNASeq-Paired"))
{
 my $file1=$ARGV[1]; ####### Fastq File pair 1
 my $file2=$ARGV[2]; ####### Fastq File pair 2
 my $species=$ARGV[3]; ########### Works for human, mouse, frog and zebrafish
 my $Output_folder_name=$ARGV[4]; ######## Output folder name
 my $phred_qual=$ARGV[5];  #### Phred quality 33 or 64 [[[[ 33 if Ilumina encoding 1.8+ and rest 64]
 &ProcessRNASeqPaired($file1,$file2,$species,$Output_folder_name,$phred_qual);
}
if(($user_input eq "Process-ChIP-ATAC_SingleEnd")||($user_input eq "--Process-ChIP-ATAC_SingleEnd")||($user_input eq "ChIP-ATAC-Single"))
{
 my $file=$ARGV[1]; ####### Fastq File
 my $species=$ARGV[2]; ########### Works for human, mouse, frog and zebrafish
 my $Output_folder_name=$ARGV[3]; ######## Output folder name
 my $phred_qual=$ARGV[4];  #### Phred quality 33 or 64 [[[[ 33 if Ilumina encoding 1.8+ and rest 64]
 my $exp_type=$ARGV[5]; #### Experiment type : ATAC, CHIP-TF or CHIP-EPIGENETIC
 &ProcessChIPATACSingleEnd($file,$species,$Output_folder_name,$phred_qual,$exp_type);
}
if(($user_input eq "Process-ChIP-ATAC_PairedEnd")||($user_input eq "--Process-ChIP-ATAC_PairedEnd")||($user_input eq "ChIP-ATAC-Paired"))
{
 my $file1=$ARGV[1]; ####### Fastq File pair 1
 my $file2=$ARGV[2]; ####### Fastq File pair 2
 my $species=$ARGV[3]; ########### Works for human, mouse, frog and zebrafish
 my $Output_folder_name=$ARGV[4]; ######## Output folder name
 my $phred_qual=$ARGV[5];  #### Phred quality 33 or 64 [[[[ 33 if Ilumina encoding 1.8+ and rest 64]
 my $exp_type=$ARGV[6]; #### Experiment type : ATAC, CHIP-TF or CHIP-EPIGENETIC
 &ProcessChIPATACPairedEnd($file1,$file2,$species,$Output_folder_name,$phred_qual,$exp_type);
}
if(($user_input eq "Generate-TPM-Counts-Matrix")||($user_input eq "--Generate-TPM-Counts-Matrix")||($user_input eq "GenerateMatrix"))
{
 my $RSEM_res_dir=$ARGV[1];
 my $Species=$ARGV[2];
 my $output_dir=$ARGV[3];
 &GenerateTPMCounts($RSEM_res_dir,$Species,$output_dir);
}
if($user_input eq "")
{
 sleep(1);
 &help;
} 
if($user_input eq "Citation")
{
 &cite;
}



#########################################################################
#########################################################################
##### MODULES CODE DOWN HERE ##########

#####################  HELP MODULE ####################
sub help
{
 print "\nPlease See README and White-Paper for getting detailed instructions on running CSBB-v3.0\n";
 print "\n\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\n";
 print "\n				Please See \: Please run install module if using CSBB\-v3\.0 for first time \[just one time process\]		\n";
 sleep(2);
 print "\nPlease use options below to run CSBB \- Computational Suite For Bioinformaticians and Biologists\n";
 print "\nOptions\:\:\n";
 print "\nCitation                       \-\-\-\> for citing CSBB please use url : https://github.com/csbbcompbio/CSBB-v3.0\n\n";
 print "\ninstall                        \-\-\-\> for installing all the required dependencies for Pipelines \:\:only one time process\n\n";
 print "\nUpperQuantile                  \-\-\-\> for performing upper quantile normalization\n\n";
 print "\nBasicStats                     \-\-\-\> for obtaining stats like mean\, median\, standard deviation\, variance\, Sum\, min and max for each Gene Expression profile\n\n";
 print "\nExpressionToZscore             \-\-\-\> for obtaining z-scores for Gene Expression in samples\n\n";
 print "\nExtractGeneInfo                \-\-\-\> for obtaining info\/expression of list genes from a huge matrix gene info\/expression\n\n";
 print "\nExpressionPlot                 \-\-\-\> for generating line plot visualizing expression\/information of genes\/entities across samples\/objects\n\n";
 print "\nInteractiveHeatmap             \-\-\-\> for generating interactive heatmaps for expression data\. User has three options on clustering type and four choices on color theme\. Please read README for descriptions and run command\.\n\n";
 print "\nCorrelationProfiles            \-\-\-\> for obtaining genes correlation profile termed as positively and negatively correlated based on User threshold\. One can obtain profile for all genes or just genes of interest \(For genes of interest user needs to provide the path to gene list file\)\. Heatmap will only be displayed for genes of interest\n\n";
 print "\nBiogrid\-Gene\-Protein\-Search \-\-\-\> for obtaining gene\-protein interactions for Human and Mouse for genes of interest\n\n";
 print "\nDifferentialExpression         \-\-\-\> for obtaining DE genes in RNA-SEQ expriments\. Uses RUVSeq package in R\n\n";
 print "\nPCA                            \-\-\-\> for performing Principal Component Analysis\n";
 print "\nNMF                            \-\-\-\> for performing Nonnegative Matrix Factorization on Samples in Expression dataset\n";
 print "\nProcessPublicData              \-\-\-\> for processing public data \[Includes downloading .sra files from SRA, mapping to reference genome and running processing pipelines based on Assay Type for human, mouse, frog and zebrafish\]\n";
 print "\nInteractiveScatterPlot         \-\-\-\> for generating Interactive Scatter plot based on user preference\. User needs to provide path to the file\, Column number for x\-axis values\, Column number for y\-axis values and Column number which user needs for color factorization \(If users provides No color factorization will not be done\) Please see README for extensive explanation\n";
 print "\nProcess\-RNASeq\_SingleEnd     \-\-\-\> for processing Single End RNASeq data using RSEM for human, mouse, frog and zebrafish\n";
 print "\nProcess\-RNASeq\_PairedEnd     \-\-\-\> for processing Paired End RNASeq data using RSEM for human, mouse, frog and zebrafish\n";
 print "\nGenerate-TPM-Counts-Matrix     \-\-\-\> for generating TPM and Counts Matrix for Both Isoforms and Genes using CSBB RNA-seq result directory and species of interest\n";
 print "\nProcess-ChIP-ATAC_SingleEnd    \-\-\-\> for processing Single End ChIP and ATAC Seq data for human, mouse and frog\n";
 print "\nProcess-ChIP-ATAC_PairedEnd    \-\-\-\> for processing Paired End ChIP and ATAC Seq data for human, mouse and frog\n";
}
##################### MODULE END #####################


##################### Log Module Start #####################
sub logCSBB
{
 my $stdout=@_[0];chomp $stdout; my $stderr=@_[1]; chomp $stderr; my $exit=@_[2]; chomp $exit; my $module_name=@_[3]; chomp $module_name;
 my $outfile1="CSBB"."\_".$module_name."\_"."LOG"; my $outfile2="CSBB"."\_".$module_name."\_"."ERROR"; my $outfile3="CSBB"."\_".$module_name."\_"."EXIT-STATUS";
 open(LOG,">>CSBB-v3.0_Logs/$outfile1.txt"); open(ERROR,">>CSBB-v3.0_Logs/$outfile2.txt"); open(EXIT,">>CSBB-v3.0_Logs/$outfile3.txt");
 print LOG "$stdout\n"; print ERROR "$stderr\n"; print EXIT "$exit\n";
 close LOG; close ERROR; close EXIT;
}
##################### MODULE END #####################


#################### MODULE CITATION #################
sub cite
{
 print "Please CITE CSBB using following url : https://github.com/csbbcompbio/CSBB-v3.0\n";
}
##################### MODULE END #####################


#################### Install MODULE ##################
sub install
{
 use Cwd;
 my $cwd = getcwd;
 print "\nInstalling Required dependencies on your system\.\. Please allow access to CSBB when prompted \.\. This is one time installation\n";
 sleep(0.5);
 my $scripttoinstall=$cwd."\/"."Modules"."\/"."getbrew_MAC.pl";
 my $dirto_install=$cwd."\/"."Modules";
 system("perl","$scripttoinstall","$dirto_install") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 print "\nRequired modules successfully insatlled\n";
}
##################### MODULE END #####################


#################### UPPER QUANTILE MODULE ##################
sub upperquantile
{
 use Cwd;
 my $cwd = getcwd;
 print "\nUpper Quantile Normalization module loaded\n";
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $header;my $path;
 my $counter=0;
 my $counter1=0;
 open(F,$file);
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter++;
  if($counter==1)
  {
   $header=$data;
  }
 }
 close F;
 print "\nStored Header Info\n";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."Uquantile_normalization.r";
 print "\nPerforming Upper Quantile Normalization\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "Quantile"."\_"."Normalized"."\_".$filename;
 open(OUT,">$path/$outfile");
 my $newhead=$header;
 print OUT "$header\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close F;
  close OUT;
  unlink $Rfile;
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "\nPlease see file $outfile for results in $path\n";
}
############################ MODULE END ############################


########################### EXPRESSIONTOZSCORE MODULE ##################
sub expressiontozscore
{
 print "\nExpressionToZscore module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $header;my $path;
 my $counter=0;
 my $counter1=0;
 open(F,$file);
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter++;
  if($counter==1)
  {
   $header=$data;
  }
 }
 close F;
 print "\nStored Header Info\n";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."Zscore_Calculator.r";
 print "\nPerforming Zscore Normalization\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "Zscores"."\_".$filename;
 open(OUT,">$path/$outfile");
 my $newhead=$header;
 print OUT "$header\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter1++;
  if($counter1==1)
  {}
  else
  {
   print OUT "$data\n";
  }
 }
 close F;
 close OUT;
 unlink $Rfile;
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile for results in $path\n";
}
################################## MODULE END #############################


################################# BASICSTATS MODULE ########################
sub basicstats
{
 print "\nBasicStats module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $path;
 my $counter1=0;
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."BasicStats.r";
 print "\nCalculating Basic Stats for all entities in the $file\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "BasicStats"."\_".$filename;
 open(OUT,">$path/$outfile");
 print OUT "Gene\tMean\tMedian\tMedian Adjusted Deviation\tStandard Deviation\tVariance\tMinimum\tMaximum\tSum\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter1++;
  if($counter1==1)
  {}
  else
  {
   print OUT "$data\n";
  }
 }
 close F;
 close OUT;
 unlink $Rfile;
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile for results in $path\n";
}
###################################### MODULE END ################################


############################### EXTRACTGENEINFO MODULE ##########################
sub extractgeneinfo
{
 use Cwd;
 my $cwd = getcwd;
 print "\nExtractGeneInfo module loaded\n";
 my $file1=@_[0];chomp $file1;
 my $file2=@_[1];chomp $file2;
 if($file1 eq "")
 {
  print "\nPlease provide the path to the Expression\/Info file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file1=<stdin>;chomp $file1;
 }
 if($file2 eq "")
 {
  print "\nPlease provide the path to the Gene List file \.\. Please use header in the file CSBB assumes first line as header\.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file2=<stdin>;chomp $file2;
 }
 my $start_time=time();
 print "\nRunning Extract Gene Info Module\n";
 my $dirtoperl=$cwd."\/"."Modules"."\/"."extract_gene_info.pl";
 ($stdout, $stderr, $exit) = capture {
   system("perl","$dirtoperl","$file1","$file2") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile for results\n";
}
##################################### MODULE END ##################################


##################################### MODULE EXPRESSION PLOT START ###########################
sub expressionplot
{
 print "\nExpressionPlot Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."Line_Graph.r";
 print "\nGenerating Expression Plots\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run Complete\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds\n";
 print "\nExpression plot is generated and is saved in $path\n";
}
######################################### MODULE END ###############################


#################################### INTERACTIVE HEATMAP MODULE ###################
sub interactiveheatmap
{
 print "\nInteractive Heatmap module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;my $clustering_type=@_[1];chomp $clustering_type;my $color_theme=@_[2];chomp $color_theme;
 if($file eq "")
 {
  print "\nPlease provide the path to the Expression file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 if($clustering_type eq "")
 {
  print "\nPlease provide Clustering type\. Options are 1\. Row\_Clust for only row clustering 2\. Col\_Clust for Column CLustering 3\. Row\_Col\_Clust for both way clustering\n";
  $clustering_type=<stdin>;chomp $clustering_type;
 }
 if($color_theme eq "")
 {
  print "\nPlease provide Color theme\. Options are 1\. YellowGreenOrange 2\. BlueWhiteRed 3\. YellowBlackBlue 4\. GreenWhitePurple\n";
  $color_theme=<stdin>;chomp $color_theme;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 print "\nRunning R in Background\n";
 print "\n$file\n";
 if($clustering_type eq "Row_Clust")
 {
  print "runing\n";
  my $dirtoR=$cwd."\/"."Modules"."\/"."Row_Clust.r";
  print "\nRunning Interactive Heatmap Module with Row Clust and $color_theme color theme\n";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$color_theme) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR Run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nBoth Interactive and Static Heatmaps are saved in the folder $path\n";
 }
 if($clustering_type eq "Col_Clust")
 {
  my $dirtoR=$cwd."\/"."Modules"."\/"."Col_Clust.r";
  print "\nRunning Interactive Heatmap Module with Col Clust and $color_theme color theme\n";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$color_theme) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR Run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nBoth Interactive and Static Heatmaps are saved in the folder $path\n";
 }
 if($clustering_type eq "Row_Col_Clust")
 {
  my $dirtoR=$cwd."\/"."Modules"."\/"."Row_Col_Clust.r";
  print "\nRunning Interactive Heatmap Module with Row-Col Clust and $color_theme color theme\n";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$color_theme) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR Run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nBoth Interactive and Static Heatmaps are saved in the folder $path\n";
 }
}
############################# MODULE END ######################################


############################# CORRELATION PROFILES ############################
sub correlationprofile
{
 print "\nCorrelationProfiles module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];my $threshold=@_[1];my $genesofinterest=@_[2];chomp $file;chomp $threshold;chomp $genesofinterest;my $negativethreshold=-1*$threshold; my $typeOfCorr=@_[3]; chomp ;$typeOfCorr;
 if($file eq "")
 {
  print "\nPlease provide the path to the Gene Expression file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file = <stdin>;chomp $file;
 }
 if($threshold eq "")
 {
  print "\nPlease provide correlation threshold \.\. Threshold Range is -1 to 1\n";
  $threshold = <stdin>;chomp $threshold;
 }
 if($genesofinterest eq "")
 {
  print "\nPlease provide genes of interest\. Options are all or Path to gene list file \.\. You can drag and drop from finder window \.\. Please remove space at the end\n";
  $genesofinterest = <stdin>;chomp $genesofinterest;
 }
 if($typeOfCorr eq "")
 {
  print "\nPlease provide Correlation type\. Options are pearson or spearman or kendall\n";
  $typeOfCorr = <stdin>;chomp $typeOfCorr;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 if($genesofinterest eq "all")
 {
  print "\nRunning R in background to perform correlations \.\.\. please be patient\.\.\.\n";
  my $dirtoR=$cwd."\/"."Modules"."\/"."Correlation_for_Matrix.r";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$typeOfCorr) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR Run complete \.\.\. Now writing header with perl\n";
  my $Rfile = $path."\/"."temporaryfile"."\."."txt";
  my $counter=0;my $header;my $counter1=0;
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   chomp $data;
   $counter++;
   if($counter==1)
   {
    $header=$data;
   }
  }
  close F;
  my $mainhead="Entity"."\t".$header;
  my $correlation_file_R=$path."\/"."Correlation"."\_"."Profiles"."\_".$filename;
  open(OUT,">$correlation_file_R");
  open(F,"$Rfile");
  print OUT "$mainhead\n";
  while(my $data = <F>)
  {
   chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close OUT;
  close F;
  unlink $Rfile;
  print "\nCorrelation Profiles outputted\.\. Now obtaining positive and negative correlated entities\n";
  my $dirtoperl=$cwd."\/"."Modules"."\/"."obtain_positive_negative_correlation_set.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirtoperl","$path","$filename","$correlation_file_R","$threshold") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nPositive and Negative correlation profiles obtained\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nCorrelation Profiles results are saved in $path\n";
 }
 if($genesofinterest =~/.txt/)
 {
  &extractgeneinfo($file,$genesofinterest);
  my @filepath_new=split(/\//,$genesofinterest);
  my $filename_new=pop(@filepath_new);
  my $path_new;
  foreach my $m(@filepath_new)
  {
   if($m eq "")
   {}
   else
   {
    $path_new=$path_new."\/".$m;
   }
  }
  my $extractinfo_result="Expression"."\_".$filename_new;
  my $temp=$path_new."\/".$extractinfo_result;
  print "\nRunning R in background to perform correlations \.\.\. please be patient\.\.\.\n";
  my $dirtoR=$cwd."\/"."Modules"."\/"."Correlation_for_Matrix.r";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path_new,$extractinfo_result,$typeOfCorr) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  unlink $temp;
  print "\nR Run complete \.\.\. Now writing header with perl\n";
  my $Rfile = $path_new."\/"."temporaryfile"."\."."txt";
  my $counter=0;my $header;my $counter1=0;
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   chomp $data;
   $counter++;
   if($counter==1)
   {
    $header=$data;
   }
  }
  close F;
  my $mainhead="Entity"."\t".$header;
  my $correlation_file_R=$path."\/"."Correlation"."\_"."Profiles"."\_".$filename_new;
  open(OUT,">$correlation_file_R");
  open(F,"$Rfile");
  print OUT "$mainhead\n";
  while(my $data = <F>)
  {
   chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close OUT;
  close F;
  unlink $Rfile;
  my $dirtoR1=$cwd."\/"."Modules"."\/"."Row_Col_Clust_Correlation_input.r";
  print "\nInteractive Heatmap Module loaded\n";
  print "\nRunning R for generating heatmap using Correlation values\n";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR1,$path_new,$correlation_file_R) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR run complete \.\.\.\. Heatmap generated now finding positively and negatively correlated entity sets using perl\n";
  my $dirtoperl=$cwd."\/"."Modules"."\/"."obtain_positive_negative_correlation_set.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirtoperl","$path_new","$filename_new","$correlation_file_R","$threshold") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nCorrelation Profiles files are saved in $path_new\n";
 }
}
####################################### MODULE END ####################################


###################################### BIOGRID MODULE START ##########################
sub biogrid
{
 print "\nBiogrid\-Gene\-Protein\-Search Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $organism=@_[0];chomp $organism;my $file=@_[1]; chomp $file;
 if($organism eq "")
 {
  print "\nPlease provide Oraganism of interest\.Options are 1\. Human 2\. Mouse\n";
  $organism=<stdin>;chomp $organism;
 }
 if($file eq "")
 {
  print "\nPlease provide the path to the Gene list file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 if($organism eq "Human")
 {
  my $dirtoperl=$cwd."\/"."Modules"."\/"."Biogrid_ppi_Human.pl";
  print "\nRunning BioGrid PPI extraction module\n";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirtoperl","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nGene Protein interaction results are saved in $path\n";
 }
 if($organism eq "Mouse")
 {
  my $dirtoperl=$cwd."\/"."Modules"."\/"."Biogrid_ppi_Mouse.pl";
  print "\nRunning BioGrid PPI extraction module\n";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirtoperl","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nGene Protein interaction results are saved in $path\n";
 }
}
################################### MODULE END ##########################


################################## DIFFERENTIAL EXPRESSION MODULE ###############
sub de
{
 print "\nDifferentialExpression Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];my $numbercontrol=@_[1];my $numbertreatment=@_[2];my $countsthreshold=@_[3];my $numbersamples=@_[4];my $typeOfNorm=@_[5];
 chomp $file;chomp $numbercontrol;chomp $numbertreatment;chomp $countsthreshold;chomp $numbersamples;
 if($file eq "")
 {
  print "\nPlease provide the path to the Counts file \.\. Please place the all control samples before all treatment samples \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 if($numbercontrol eq "")
 {
  print "\nPlease provide the Number of Control Samples\n";
  $numbercontrol=<stdin>;chomp $numbercontrol;
 }
 if($numbertreatment eq "")
 {
  print "\nPlease provide the Number of Treatment Samples\n";
  $numbertreatment=<stdin>;chomp $numbertreatment;
 }
 if($countsthreshold eq "")
 {
  print "\nPlease provide the Counts threshold \n";
  $countsthreshold=<stdin>;chomp $countsthreshold;
 }
 if($numbersamples eq "")
 {
  print "\nPlease provide the number of samples you want to apply counts filtering\n";
  $numbersamples=<stdin>;chomp $numbersamples;
 }
 if($typeOfNorm eq "")
 {
  print "\nPlease provide the Type of Normalization you want to apply options : 1) UpperQuantile 2) UpperQuantile+Empirical \[\[ PLEASE SEE \:\:\: Normalization type is based on sequencing data quality\]\]\]\n";
  $typeOfNorm=<stdin>;chomp $typeOfNorm;
 }
 if($typeOfNorm eq "UpperQuantile")
 {
  my $start_time=time();
  my $path;
  my @filepath=split(/\//,$file);
  my $filename=pop(@filepath);
  foreach my $m(@filepath)
  {
   if($m eq "")
   {}
   else
   {
    $path=$path."\/".$m;
   }
  }
  my $dirtoR=$cwd."\/"."Modules"."\/"."RUVseq.r";
  print "\nRunning R in background to perform DE using RUVSeq \[Normalization \: UpperQuantile\] \.\.\. \(please be patient\)\n";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$numbercontrol,$numbertreatment,$countsthreshold,$numbersamples) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR Run complete \.\.\. Now writing header with perl\n";
  my $Rfile = $path."\/"."temporaryfile"."\."."txt";
  my $outfile = "DE_Using_UQ_Normalization"."\_".$filename;
  open(OUT,">$path/$outfile");
  print OUT "Gene\tlogFC\tlogCPM\tLR\tPvalue\tFDR\n";
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   $data =~ s/^\s+|\s+$//g;
   chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close F;
  close OUT;
  unlink $Rfile;
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "\nPlease see file $outfile in $path for results\n";
 }
 if($typeOfNorm eq "UpperQuantile+Empirical")
 {
  my $start_time=time();
  my $path;
  my @filepath=split(/\//,$file);
  my $filename=pop(@filepath);
  foreach my $m(@filepath)
  {
   if($m eq "")
   {}
   else
   {
    $path=$path."\/".$m;
   }
  }
  my $dirtoR=$cwd."\/"."Modules"."\/"."RUVseq_with_empirical.r";
  print "\nRunning R in background to perform DE using RUVSeq \[Normalization \: UpperQuantile \+ Empirical\] \.\.\. \(please be patient\)\n";
  ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$numbercontrol,$numbertreatment,$countsthreshold,$numbersamples) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  print "\nR Run complete \.\.\. Now writing header with perl\n";
  my $Rfile = $path."\/"."temporaryfile"."\."."txt";
  my $outfile = "DE_Using_UQplusEmpirical_Normalization"."\_".$filename;
  open(OUT,">$path/$outfile");
  print OUT "Gene\tlogFC\tlogCPM\tLR\tPvalue\tFDR\n";
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   $data =~ s/^\s+|\s+$//g;
   chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close F;
  close OUT;
  unlink $Rfile;
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "\nPlease see file $outfile in $path for results\n";
 }
}
##################################### MODULE END #################################


##################################### MODULE PCA START ###########################
sub pca
{
 print "\nPCA Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."PCA.r";
 print "\nGenerating PCA plot for $file\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run Complete\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds\n";
 print "\nPCA plot is generated and is saved in $path\n";
}
######################################### MODULE END ###############################


####################################### NMF CLUST MODULE START #####################
sub nmf
{
 use Cwd;
 my $cwd = getcwd;
 print "\nNMF Clustering module loaded\n";
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."NMF.r";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 print "\nIf more than 1000 genes and 14 samples \.\.\. estimated running time is 5 to 10 mins\n";
 print "\nGenerating NMF plot for $file\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run Complete\.\.\.\.\.\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nNMF ConsensusMap saved in $path\n";
}
#################################### MODULE END ####################################


#################################### Process Public Data MODULE START ########################
sub ProcessPublic
{
 use Cwd;
 my $cwd = getcwd;
 print "\nProcessPublicData module loaded\n";
 my $file=@_[0];chomp $file;my $path=@_[1];chomp $path;
 if($file eq "")
 {
  print "\nPlease provide the path to SRA Data Table File \.\. You can drag and drop the folder from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 if($path eq "")
 {
  print "\nPlease provide the path to result directory \.\. You can drag and drop the folder from finder window \.\. Please remove space at the end\n";
  $path=<stdin>;chomp $path;
 }
 my $counter=0;
 my $path_to_sratoolkit_prefetch=$cwd."\/"."Modules/sratoolkit.2.9.0-mac64/bin/./prefetch";
 my $path_to_sratoolkit_fastqdump=$cwd."\/"."Modules/sratoolkit.2.9.0-mac64/bin/./fastq-dump";
 my $username = getpwuid $UID;
 open(F,"$file");
 while(my $data = <F>)
 {
  chomp $data;
  if($data =~ /#/)
  {}
  else
  {
   $counter++;
   if($counter == 1)
   {}
   else
   {
    my @arr_data=split(/\t/,$data);
    my $SRRid=$arr_data[0]; my $species=$arr_data[1]; my $Assay=$arr_data[2]; my $readtype=$arr_data[3]; my $samplename=$arr_data[4];
    my $start_time=time();
    print "\nDownloading $SRRid via prefetch\n";
    ($stdout, $stderr, $exit) = capture {
     system($path_to_sratoolkit_prefetch, $SRRid)==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
    };
    &logCSBB($stdout,$stderr,$exit,$user_input);
    my $SRA=$SRRid."\."."sra";
    my $current_path_to_srafile='/Users/'.$username.'/ncbi/public/sra/'.$SRA;
    my $new_path_to_srafile=$path."\/".$samplename."\."."sra";
    ($stdout, $stderr, $exit) = capture {
     system('mv', $current_path_to_srafile, $new_path_to_srafile)==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
    };
    &logCSBB($stdout,$stderr,$exit,$user_input);
    print "\nCoverting $samplename\.sra to Fastq File\n";
    ($stdout, $stderr, $exit) = capture {
     system($path_to_sratoolkit_fastqdump, '--split-3', '-O', $path, $new_path_to_srafile)==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
    };
    &logCSBB($stdout,$stderr,$exit,$user_input);
    print "\nDeleting $samplename\.sra\n";
    ($stdout, $stderr, $exit) = capture {
    system('rm', $new_path_to_srafile);
    };
    &logCSBB($stdout,$stderr,$exit,$user_input);
    if(($Assay eq "RNA-SEQ")&&($readtype eq "SINGLE-END"))
    {
     my $fastq_file=$path."\/".$samplename."\."."fastq";
     my $quality_encoding="phred33";
     print "\nCalling RNA-Seq Single end pipeline to process $samplename\.fastq\n";
     &ProcessRNASeqSingle($fastq_file,$species,$path,$quality_encoding);
    }
    if(($Assay eq "RNA-SEQ")&&($readtype eq "PAIRED-END"))
    {
     my $fastq_file1=$path."\/".$samplename."\_1"."\."."fastq";
     my $fastq_file2=$path."\/".$samplename."\_2"."\."."fastq";
     my $quality_encoding="phred33";
     print "\nCalling RNA-Seq Paired end pipeline to process $samplename\_1\.fastq and $samplename\_2\.fastq\n";
     &ProcessRNASeqPaired($fastq_file1,$fastq_file2,$species,$path,$quality_encoding);
    }
    if(($Assay eq "ChIP-TF")||($Assay eq "ChIP-Epigenetic")||($Assay eq "ATAC"))
     {
      if($readtype eq "SINGLE-END")
      {
       my $fastq_file=$path."\/".$samplename."\."."fastq";
       my $quality_encoding="phred33";
       print "\nCalling ChIP\/ATAC-Seq Single end pipeline to process $samplename\.fastq\n";
       &ProcessChIPATACSingleEnd($fastq_file,$species,$path,$quality_encoding,$Assay);
      }
      if($readtype eq "PAIRED-END")
      {
       my $fastq_file1=$path."\/".$samplename."\_1"."\."."fastq";
       my $fastq_file2=$path."\/".$samplename."\_2"."\."."fastq";
       my $quality_encoding="phred33";
       print "\nCalling ChIP\/ATAC-Seq Paired end pipeline to process $samplename\_1\.fastq and $samplename\_2\.fastq\n";
       &ProcessChIPATACPairedEnd($fastq_file1,$fastq_file2,$species,$path,$quality_encoding,$Assay);
      }
     }
    my $end_time=time();
    my $total_time=$end_time-$start_time;
    print "\nRun Complete in $total_time seconds \.\.\. Please see $path for processed results\n";
   }
  }
 }
 close F;
 print "\nAll the SRA data has been processed \.\.\. Please see $path for results\n";
}
################################### MODULE END ######################################


####################################### INTERACTIVE SCATTER PLOT MODULE START ################
sub interactivesp
{
 use Cwd;
 my $cwd = getcwd;
 print "\nInteractiveScatterPlot module loaded\n";
 my $file=@_[0];my $colx=@_[1];my $coly=@_[2];my $colenrichment=@_[3];
 chomp $file;chomp $colx;chomp $coly;chomp $colenrichment;
 if($file eq "")
 {
  print "\nYou have forgot to provide path to the file\n";
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 if($colx eq "")
 {
  print "\nYou have forgot to provide column number for x\-axis values\n";
  print "\nPlease provide column number for x\-axis values\n";
  $colx=<stdin>;chomp $colx;
 }
 if($coly eq "")
 {
  print "\nYou have forgot to provide column number for y\-axis values\n";
  print "\nPlease provide column number for y\-axis values\n";
  $coly=<stdin>;chomp $coly;
 }
 if($colenrichment eq "")
 {
  print "\nYou have forgot to provide column number for color factorization\. You can also say No for no color factorization\n";
  print "\nPlease provide column number for color factorization\n";
  $colenrichment=<stdin>;chomp $colenrichment;
 }
 my $start_time=time();
 my $path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $path=$path."\/".$m;
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."Interactive_ScatterPlot.r";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 print "\nGenerating Interactive and Static Scatter plot for $file\n";
 ($stdout, $stderr, $exit) = capture {
   system(Rscript,$dirtoR,$path,$filename,$colx,$coly,$colenrichment) ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
 };
 &logCSBB($stdout,$stderr,$exit,$user_input);
 print "\nR Run Complete\.\.\.\.\.\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nBoth Interactive and Static ScatterPlots saved in the $path\n";
}
######################################## MODULE END ###########################


#################### Process RNASeq Single End Data MODULE  ##################
sub ProcessRNASeqSingle
{
 use Cwd;
 my $cwd = getcwd;
 print "\nProcess-RNASeq_SingleEnd module loaded\n";
 my $file=@_[0];chomp $file; my $species=@_[1]; chomp $species; my $output_folder=@_[2]; chomp $output_folder;my $phred_qual=@_[3]; chomp $phred_qual;
 if($file eq "")
 {
  print "\nPlease provide the path to the Fastq File \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 if($species eq "")
 {
  print "\nPlease provide the species \.\. Options : human or mouse or xenopus-leavis or xenopus-trop or zebrafish\n";
  $species=<stdin>;chomp $species;
 }
 if($output_folder eq "")
 {
  print "\nPlease provide Output folder path\n";
  $output_folder=<stdin>;chomp $output_folder;
 }
 if($phred_qual eq "")
 {
  print "\nPlease provide phred quality encoding \.\. Options phred33 or phred64 or solexa\n";
  $phred_qual=<stdin>;chomp $phred_qual;
 }
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 my @arr_split_me;
 if($filename =~ /.fastq/)
 {
  @arr_split_me=split(/\.fastq/,$filename);
 }
 if($filename =~ /.fq/)
 {
  @arr_split_me=split(/\.fq/,$filename);
 }
 my $new_dir_for_result=$output_folder."\/".$arr_split_me[0];
 my $bowtie_path="/usr/local/bin/";
 my $fastqc_result_directory=$output_folder."\/"."Quality_Check_Reports";
 my $quality_encoding="\-"."\-".$phred_qual."\-"."quals";
 my $rsem_path=$cwd."\/"."Modules"."\/"."RSEM"."\/"."rsem-calculate-expression";
 my $RNASEQbash=$cwd."\/"."Modules"."\/"."./RNA-SEQ_SINGLE-END.sh";
 if(-d $fastqc_result_directory)
 {
  print "\n$fastqc_result_directory already exists \.\. CSBB will use the same to write results of Quality check\n";
 }
 else
 {
  mkdir($fastqc_result_directory);
  print "\nCSBB is creating $fastqc_result_directory for writing Quality Check results\n";
 }
 print "\nCSBB will use Fastqc for Quality Check, RSEM for mapping and quantification and UCSC utilities for generating Bigwig Files\n";
 if( $species eq "human")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_HUMAN/human";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."human_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "mouse")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_MOUSE/mouse";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."mouse_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "xenopus-leavis")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_LAEVIS/Laevis";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Laevis_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "xenopus-trop")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_TROP/Trop";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Trop_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "zebrafish")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_ZEBRAFISH/Zebrafish";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Zebrafish_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
}
############################ MODULE END ############################


#################### Process RNASeq Paired End Data MODULE  ##################
sub ProcessRNASeqPaired
{
 use Cwd;
 my $cwd = getcwd;
 print "\nProcess-RNASeq_PairedEnd module loaded\n";
 my $file1=@_[0];chomp $file1; my $file2=@_[1]; chomp $file2; my $species=@_[2]; chomp $species; my $output_folder=@_[3]; chomp $output_folder;my $phred_qual=@_[4]; chomp $phred_qual;
 if($file1 eq "")
 {
  print "\nPlease provide the path to the Fastq File pair 1 \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file1=<stdin>;chomp $file1;
 }
 if($file2 eq "")
 {
  print "\nPlease provide the path to the Fastq File pair 2 \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file2=<stdin>;chomp $file2;
 }
 if($species eq "")
 {
  print "\nPlease provide the species \.\. Options : human or mouse or xenopus-leavis or xenopus-trop or zebrafish\n";
  $species=<stdin>;chomp $species;
 }
 if($output_folder eq "")
 {
  print "\nPlease provide Output folder path\n";
  $output_folder=<stdin>;chomp $output_folder;
 }
 if($phred_qual eq "")
 {
  print "\nPlease provide phred quality encoding \.\. Options phred33 or phred64 or solexa\n";
  $phred_qual=<stdin>;chomp $phred_qual;
 }
 my @filepath1=split(/\//,$file1);
 my $filename1=pop(@filepath1);
 my @filepath2=split(/\//,$file2);
 my $filename2=pop(@filepath2);
 my @arr_split_me;
 if($filename1 =~ /.fastq/)
 {
  @arr_split_me=split(/\.fastq/,$filename1);
 }
 if($filename1 =~ /.fq/)
 {
  @arr_split_me=split(/\.fq/,$filename1);
 }
 my $new_output_folder=$output_folder."\/".$arr_split_me[0];
 my $bowtie_path="/usr/local/bin/";
 my $fastqc_result_directory=$output_folder."\/"."Quality_Check_Reports";
 my $quality_encoding="\-"."\-".$phred_qual."\-"."quals";
 my $rsem_path=$cwd."\/"."Modules"."\/"."RSEM"."\/"."rsem-calculate-expression";
 my $RNASEQbash=$cwd."\/"."Modules"."\/"."./RNA-SEQ_PAIRED-END.sh";
 if(-d $fastqc_result_directory)
 {
  print "\n$fastqc_result_directory already exists \.\. CSBB will use the same to write results of Quality check\n";
 }
 else
 {
  mkdir($fastqc_result_directory);
  print "\nCSBB is creating $fastqc_result_directory for writing Quality Check results\n";
 }
 print "\nCSBB will use Fastqc for Quality Check, RSEM for mapping and quantification and UCSC utilities for generating Bigwig Files\n";
 if( $species eq "human")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_HUMAN/human";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."human_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file1", "$file2", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_output_folder", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "mouse")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_MOUSE/mouse";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."mouse_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file1", "$file2", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_output_folder", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "xenopus-leavis")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_LAEVIS/Laevis";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Laevis_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file1", "$file2", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_output_folder", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "xenopus-trop")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_TROP/Trop";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Trop_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file1", "$file2", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_output_folder", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if($species eq "zebrafish")
 {
  my $rsem_index=$cwd."\/"."Modules"."\/"."RSEM_ZEBRAFISH/Zebrafish";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Zebrafish_chrom_sizes.genome";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$RNASEQbash", "$file1", "$file2", "$quality_encoding", "$bowtie_path", "$rsem_path", "$rsem_index", "$new_output_folder", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed Fastqc and RSEM run on the file $filename1 and $filename2\.\.\. Please see results in $output_folder\n";
 }
}
############################ MODULE END ############################


########################### GenerateTPMCounts MODULE ###############
sub GenerateTPMCounts
{
 use Cwd;
 my $cwd = getcwd;
 print "\nGenerate\-TPM\-Counts\-Matrix module loaded\n";
 my $RSEM_res_dir=@_[0]; chomp $RSEM_res_dir; my $Species=@_[1]; chomp $Species; my $output_dir=@_[2]; chomp $output_dir;
 if($RSEM_res_dir eq "")
 {
  print "\nPlease provide RNA\-Seq result directory\n";
  $RSEM_res_dir=<stdin>;chomp $RSEM_res_dir;
 }
 if($Species eq "")
 {
  print "\nPlease provide Species \.\. Options \: human or mouse or xenopus-leavis or xenopus-trop or zebrafish \n";
  $Species=<stdin>;chomp $Species;
 }
 if($output_dir eq "")
 {
  print "\nPlease provide Output Directoy \.\. You can drag and drop the output directory from Finder window\n";
  $output_dir=<stdin>;chomp $output_dir;
 }
 if($Species eq "human")
 {
  print "Read all parameters \.\. Starting execution\n";
  my $start_time=time();
  my $mappingfile=$cwd."\/"."Modules"."\/"."Human_Map.txt";
  my $dirToScript=$cwd."\/"."Modules"."\/"."TPM_COUNT_Matrix_CSBB.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirToScript","$RSEM_res_dir","$mappingfile","$output_dir") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "Run Completed in $total_time seconds\.\. Please see Expression Files in $output_dir\n";
 }
 if($Species eq "mouse")
 {
  print "Read all parameters \.\. Starting execution\n";
  my $start_time=time();
  my $mappingfile=$cwd."\/"."Modules"."\/"."Mouse_Map.txt";
  my $dirToScript=$cwd."\/"."Modules"."\/"."TPM_COUNT_Matrix_CSBB.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirToScript","$RSEM_res_dir","$mappingfile","$output_dir") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "Run Completed in $total_time seconds\.\. Please see Expression Files in $output_dir\n";
 }
 if($Species eq "xenopus-leavis")
 {
  print "Read all parameters \.\. Starting execution\n";
  my $start_time=time();
  my $mappingfile=$cwd."\/"."Modules"."\/"."Laevis_Map.txt";
  my $dirToScript=$cwd."\/"."Modules"."\/"."TPM_COUNT_Matrix_CSBB.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirToScript","$RSEM_res_dir","$mappingfile","$output_dir") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "Run Completed in $total_time seconds\.\. Please see Expression Files in $output_dir\n";
 }
 if($Species eq "xenopus-trop")
 {
  print "Read all parameters \.\. Starting execution\n";
  my $start_time=time();
  my $mappingfile=$cwd."\/"."Modules"."\/"."Trop_Map.txt";
  my $dirToScript=$cwd."\/"."Modules"."\/"."TPM_COUNT_Matrix_CSBB.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirToScript","$RSEM_res_dir","$mappingfile","$output_dir") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "Run Completed in $total_time seconds\.\. Please see Expression Files in $output_dir\n";
 }
 if($Species eq "zebrafish")
 {
  print "Read all parameters \.\. Starting execution\n";
  my $start_time=time();
  my $mappingfile=$cwd."\/"."Modules"."\/"."Zebrafish_Map.txt";
  my $dirToScript=$cwd."\/"."Modules"."\/"."TPM_COUNT_Matrix_CSBB.pl";
  ($stdout, $stderr, $exit) = capture {
   system("perl","$dirToScript","$RSEM_res_dir","$mappingfile","$output_dir") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "Run Completed in $total_time seconds\.\. Please see Expression Files in $output_dir\n";
 }
}
######################### MODULE END #################################



#################### Process ChIP-ATAC Seq Single End Data MODULE  ##################
sub ProcessChIPATACSingleEnd
{
 use Cwd;
 my $cwd = getcwd;
 print "\nProcess-ChIP/ATAC-Seq_SingleEnd module loaded\n";
 my $file=@_[0];chomp $file; my $species=@_[1]; chomp $species; my $output_folder=@_[2]; chomp $output_folder;my $phred_qual=@_[3]; chomp $phred_qual;my $exp_type=@_[4]; chomp $exp_type;
 if($file eq "")
 {
  print "\nPlease provide the path to the Fastq File \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file=<stdin>;chomp $file;
 }
 if($species eq "")
 {
  print "\nPlease provide the species \.\. Options : human or mouse or xenopus-leavis and xenopus-trop\n";
  $species=<stdin>;chomp $species;
 }
 if($output_folder eq "")
 {
  print "\nPlease provide Output folder path\n";
  $output_folder=<stdin>;chomp $output_folder;
 }
 if($phred_qual eq "")
 {
  print "\nPlease provide phred quality encoding \.\. Options phred33 or phred64 or solexa\n";
  $phred_qual=<stdin>;chomp $phred_qual;
 }
 if($exp_type eq "")
 {
  print "\nPlease provide Experiment Type \.\. Options ATAC or ChIP-TF or ChIP-Epigenetic\n";
  $exp_type=<stdin>;chomp $exp_type;
 }
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 my @arr_split_me;
 if($filename =~ /.fastq/)
 {
  @arr_split_me=split(/\.fastq/,$filename);
 }
 if($filename =~ /.fq/)
 {
  @arr_split_me=split(/\.fq/,$filename);
 }
 my $new_dir_for_result=$output_folder."\/".$arr_split_me[0];
 my $bowtie_path="/usr/local/bin/";
 my $fastqc_result_directory=$output_folder."\/"."Quality_Check_Reports";
 my $peakcalling_directory=$output_folder."\/"."MACS2_RESULTS";
 my $CHIPATACbash=$cwd."\/"."Modules"."\/"."./CHIP-ATAC-Seq_SingleEnd.sh";
 my $filename_to_use=$arr_split_me[0];
 my $quality_encoding="--".$phred_qual;
 if(-d $fastqc_result_directory)
 {
  print "\n$fastqc_result_directory already exists \.\. CSBB will use the same to write results of Quality check\n";
 }
 else
 {
  mkdir($fastqc_result_directory);
  print "\nCSBB is creating $fastqc_result_directory for writing Quality Check results\n";
 }
 if(-d $peakcalling_directory)
 {
  print "\n$peakcalling_directory already exists \.\. CSBB will use the same to write results of Peak Calling\n";
 }
 else
 {
  mkdir($peakcalling_directory);
  print "\nCSBB is creating $peakcalling_directory for writing Peak Calling results\n";
 }
 print "\nCSBB will use Fastqc for Quality Check, Bowtie2 for mapping, MACS2 for peak calling and UCSC utilities for generating Bigwig Files\n";
 if( $species eq "human")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_HUMAN/human";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."human_chrom_sizes.genome";
  my $genomesize="hs";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if( $species eq "mouse")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_MOUSE/mouse";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."mouse_chrom_sizes.genome";
  my $genomesize="mm";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if( $species eq "xenopus-leavis")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_LAEVIS/Laevis";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Laevis_chrom_sizes.genome";
  my $genomesize="3.1e9";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if( $species eq "xenopus-trop")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_TROP/Trop";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Trop_chrom_sizes.genome";
  my $genomesize="1.7e9";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
}
######################### MODULE END #################################


#################### Process ChIP/ATAC Seq Paired End Data MODULE  ##################
sub ProcessChIPATACPairedEnd
{
 use Cwd;
 my $cwd = getcwd;
 print "\nProcess-ChIP/ATAC-Seq_PairedEnd module loaded\n";
 my $file1=@_[0];chomp $file1; my $file2=@_[1]; chomp $file2; my $species=@_[2]; chomp $species; my $output_folder=@_[3]; chomp $output_folder;my $phred_qual=@_[4]; chomp $phred_qual; my $exp_type=@_[5]; chomp $exp_type;
 if($file1 eq "")
 {
  print "\nPlease provide the path to the Fastq File pair 1 \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file1=<stdin>;chomp $file1;
 }
 if($file2 eq "")
 {
  print "\nPlease provide the path to the Fastq File pair 2 \.\. You can drag and drop the file from finder window \.\. Please remove space at the end\n";
  $file2=<stdin>;chomp $file2;
 }
 if($species eq "")
 {
  print "\nPlease provide the species \.\. Options : human or mouse or xenopus-leavis and xenopus-trop\n";
  $species=<stdin>;chomp $species;
 }
 if($output_folder eq "")
 {
  print "\nPlease provide Output folder path\n";
  $output_folder=<stdin>;chomp $output_folder;
 }
 if($phred_qual eq "")
 {
  print "\nPlease provide phred quality encoding \.\. Options phred33 or phred64 or solexa\n";
  $phred_qual=<stdin>;chomp $phred_qual;
 }
 if($exp_type eq "")
 {
  print "\nPlease provide Experiment Type \.\. Options ATAC or ChIP-TF or ChIP-Epigenetic\n";
  $exp_type=<stdin>;chomp $exp_type;
 }
 my @filepath1=split(/\//,$file1);
 my $filename1=pop(@filepath1);
 my @filepath2=split(/\//,$file2);
 my $filename2=pop(@filepath2);
 my @arr_split_me;
 if($filename1 =~ /.fastq/)
 {
  @arr_split_me=split(/\.fastq/,$filename1);
 }
 if($filename1 =~ /.fq/)
 {
  @arr_split_me=split(/\.fq/,$filename1);
 }
 my $new_dir_for_result=$output_folder."\/".$arr_split_me[0];
 my $bowtie_path="/usr/local/bin/";
 my $fastqc_result_directory=$output_folder."\/"."Quality_Check_Reports";
 my $peakcalling_directory=$output_folder."\/"."MACS2_RESULTS";
 my $CHIPATACbash=$cwd."\/"."Modules"."\/"."./CHIP-ATAC-Seq_PairedEnd.sh";
 my $filename_to_use=$arr_split_me[0];
 my $quality_encoding="--".$phred_qual;
 if(-d $fastqc_result_directory)
 {
  print "\n$fastqc_result_directory already exists \.\. CSBB will use the same to write results of Quality check\n";
 }
 else
 {
  mkdir($fastqc_result_directory);
  print "\nCSBB is creating $fastqc_result_directory for writing Quality Check results\n";
 }
 if(-d $peakcalling_directory)
 {
  print "\n$peakcalling_directory already exists \.\. CSBB will use the same to write results of Peak Calling\n";
 }
 else
 {
  mkdir($peakcalling_directory);
  print "\nCSBB is creating $peakcalling_directory for writing Peak Calling results\n";
 }
 print "\nCSBB will use Fastqc for Quality Check, Bowtie2 for mapping, MACS2 for peak calling and UCSC utilities for generating Bigwig Files\n";
 if( $species eq "human")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_HUMAN/human";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."human_chrom_sizes.genome";
  my $genomesize="hs";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file1", "$file2", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if( $species eq "mouse")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_MOUSE/mouse";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."mouse_chrom_sizes.genome";
  my $genomesize="mm";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file1", "$file2", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if( $species eq "xenopus-leavis")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_LAEVIS/Laevis";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Laevis_chrom_sizes.genome";
  my $genomesize="3.1e9";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file1", "$file2", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
 if( $species eq "xenopus-trop")
 {
  my $bowtie_index=$cwd."\/"."Modules"."\/"."Bowtie_indexes_TROP/Trop";
  my $path_to_bamtobigwig=$cwd."\/"."Modules"."\/"."Bedgraph_Bigwig_MAC"."\/"."./bedGraphToBigWig";
  my $path_to_chromsize=$cwd."\/"."Modules"."\/"."Trop_chrom_sizes.genome";
  my $genomesize="1.7e9";
  my $start_time=time();
  ($stdout, $stderr, $exit) = capture {
   system("$CHIPATACbash", "$file1", "$file2", "$bowtie_index", "$new_dir_for_result", "$fastqc_result_directory", "$path_to_bamtobigwig", "$path_to_chromsize", "$peakcalling_directory", "$genomesize", "$filename_to_use") ==0 or die "\nExcecution Stopped because of errors \.\.\. Contact Praneet Chaturvedi for bugs and issues on github\n";
  };
  &logCSBB($stdout,$stderr,$exit,$user_input);
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  if(($exp_type eq "ATAC")||($exp_type eq "ChIP-TF"))
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."broadpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  if($exp_type eq "ChIP-Epigenetic")
  {
   my $dir_to_delete=$peakcalling_directory."\/".$filename_to_use."\."."narrowpeaks";
   system('rm', '-rf', $dir_to_delete);
  }
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "CSBB completed CHIP-SEQ/ATAC-SEQ run on the file $filename\.\.\. Please see results in $output_folder\n";
 }
}
######################### MODULE END #################################
