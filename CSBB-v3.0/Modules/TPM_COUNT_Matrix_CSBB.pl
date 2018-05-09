####### Version1.1
    ####### Generates TPM AND COUNTS MATRIX FOR HUMAN, MOUSE, FROG AND ZEBARFISH PROCESSESED RNA-SEQ DATA
use List::Util qw(sum);
my $dir = $ARGV[0]; chomp $dir; ######################## Directory of Isoforms results files.
my $mappingfile=$ARGV[1]; chomp $mappingfile; ######################## Mapping File.
my $outpath=$ARGV[2]; chomp $outpath; ######################## Output Directory.
my @samples;my %tpm_hash;my %counts_hash;my $header;my %res_tpm; my %res_counts;my %map;
open(F,"$mappingfile");
while(my $data = <F>)
{
 $data =~ s/^\s+|\s+$//g;
 chomp $data;
 my @arr=split(/\t/,$data);
 if(($arr[0] eq "")||($arr[1] eq ""))
 {}
 else
 {
  $arr[4]=~ s/^\s+|\s+$//g;
  $map{$arr[0]}{$arr[1]}=0;
 }
}
close F;
opendir(F,"$dir");
foreach my $f(readdir(F))
{
 if($f =~ /.isoforms.results/)
 {
  my @arrf=split(/\.isoforms.results/,$f);
  push(@samples,$arrf[0]);
  open(R,"$dir/$f");
  while(my $data = <R>)
  {
   chomp $data;
   my @arr=split(/\t/,$data);
   if(exists $map{$arr[0]})
   {
    foreach my $genes_add(keys %{$map{$arr[0]}})
    {
     my $var=$genes_add."\<".$arr[0]."\>";
     my $value1=$arrf[0]."\t".$arr[5]; ############## Storing TPM VALUES
     $tpm_hash{$var}{$value1}=0;
     my $value2=$arrf[0]."\t".int($arr[4]); ############## Storing COUNTS VALUES
     $counts_hash{$var}{$value2}=0;
    }
   }
   else
   {
    my $var="NoGeneId"."\<".$arr[0]."\>";
    my $value1=$arrf[0]."\t".$arr[5]; ############## Storing TPM VALUES
    $tpm_hash{$var}{$value1}=0;
    my $value2=$arrf[0]."\t".int($arr[4]); ############## Storing COUNTS VALUES
    $counts_hash{$var}{$value2}=0;
   }
  }
  close R;
  print "Read file $f and stored TPM and Counts for Isoforms\r";
 }
}
closedir F;
foreach my $m(@samples)
{
 if($m eq "")
 {}
 else
 {
  $header = $header."\t".$m;
 }
}
my $mainheader = "Gene"."\<"."Transcript"."\>".$header;
print "\nPrepared Header $mainheader\n";
foreach my $m(keys %tpm_hash)
{
 my $finalval = "";
 foreach my $a(@samples)
 {
  my $val = "";
  foreach my $n(keys %{$tpm_hash{$m}})
  {
   my @arr=split(/\t/,$n);
   if($a eq $arr[0])
   {
    $val = $arr[1];
   }
  }
  if($val eq "")
  {
   $finalval=$finalval."\t"."NA";
  }
  else
  {
   $finalval=$finalval."\t".$val;
  }
 }
 $res_tpm{$m}{$finalval}=0;
}
foreach my $m(keys %counts_hash)
{
 my $finalval = "";
 foreach my $a(@samples)
 {
  my $val = "";
  foreach my $n(keys %{$counts_hash{$m}})
  {
   my @arr=split(/\t/,$n);
   if($a eq $arr[0])
   {
    $val = $arr[1];
   }
  }
  if($val eq "")
  {
   $finalval=$finalval."\t"."NA";
  }
  else
  {
   $finalval=$finalval."\t".$val;
  }
 }
 $res_counts{$m}{$finalval}=0;
}
print "\nProcessed TPM and Counts Matrix for Isoforms\n";
open(OUT,">$outpath/Isoforms_TPM_matrix.txt");
print OUT "$mainheader\n";
foreach my $m(keys %res_tpm)
{
 foreach my $n(keys %{$res_tpm{$m}})
 {
  print OUT "$m$n\n";
 }
}
close OUT;
open(OUT,">$outpath/Isoforms_Counts_matrix.txt");
print OUT "$mainheader\n";
foreach my $m(keys %res_counts)
{
 foreach my $n(keys %{$res_counts{$m}})
 {
  print OUT "$m$n\n";
 }
}
close OUT;
my $header_new;my %hash_new;my $length_new;
open(F,"$outpath/Isoforms_TPM_matrix.txt");
while(my $data =<F>)
{
 $data =~ s/^\s+|\s+$//g;
 chomp $data;
 if($data =~/Gene<Transcript>/)
 {
  my @arr=split(/\t/,$data,2);
  $header_new = $arr[1];
 }
 else
 {
  my @arr=split(/\t/,$data,2);
  my @arr1=split(/\</,$arr[0]);
  my $var=$arr1[1]."\t".$arr[1];
  $hash_new{$arr1[0]}{$var}=0;
  my @len=split(/\t/,$arr[1]);
  $length_new=scalar(@len);
 }
}
close F;
print "\nProcessesing and Writing Expression and Counts for Genes\n";
open(OUT,">$outpath/Genes_TPM_Matrix.txt");
print OUT "Gene\t$header_new\n";
foreach my $m(keys %hash_new)
{
 if(($m eq "unnamed.S")||($m eq "unnamed.L")||($m eq "NA"))
 {}
 else
 {
  my $expression="";
  for(my $i=0;$i<=($length_new-1);$i++)
  {
   my $value=0;
   foreach my $n(keys %{$hash_new{$m}})
   {
    my @arr=split(/\t/,$n);
    shift(@arr);
    $value=$value+$arr[$i];
   }
   my $newval=$value;
   $expression=$expression."\t".$newval;
  }
  my @arrexp=split(/\t/,$expression);
  shift(@arrexp);
  my $sumofexp=sum(@arrexp);
  print "Processed Gene $m\r";
  print OUT "$m$expression\n";
 }
}
close OUT;
my $header_new1;my %hash_new1;my $length_new1;
open(F,"$outpath/Isoforms_Counts_matrix.txt");
while(my $data =<F>)
{
 $data =~ s/^\s+|\s+$//g;
 chomp $data;
 if($data =~/Gene<Transcript>/)
 {
  my @arr=split(/\t/,$data,2);
  $header_new1 = $arr[1];
 }
 else
 {
  my @arr=split(/\t/,$data,2);
  my @arr1=split(/\</,$arr[0]);
  my $var=$arr1[1]."\t".$arr[1];
  $hash_new1{$arr1[0]}{$var}=0;
  my @len=split(/\t/,$arr[1]);
  $length_new1=scalar(@len);
 }
}
close F;
open(OUT,">$outpath/Genes_Counts_Matrix.txt");
print OUT "Gene\t$header_new1\n";
foreach my $m(keys %hash_new1)
{
 if(($m eq "unnamed.S")||($m eq "unnamed.L")||($m eq "NA"))
 {}
 else
 {
  my $expression="";
  for(my $i=0;$i<=($length_new1-1);$i++)
  {
   my $value=0;
   foreach my $n(keys %{$hash_new1{$m}})
   {
    my @arr=split(/\t/,$n);
    shift(@arr);
    $value=$value+$arr[$i];
   }
   my $newval=$value;
   $expression=$expression."\t".$newval;
  }
  my @arrexp=split(/\t/,$expression);
  shift(@arrexp);
  my $sumofexp=sum(@arrexp);
  print "Processed Gene $m\r";
  print OUT "$m$expression\n";
 }
}
close OUT;