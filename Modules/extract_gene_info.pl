 #!/usr/bin/perl
 my $file1=$ARGV[0];my $file2=$ARGV[1]; chomp $file1; chomp $file2;
 my $counter=0;my $header;my %hash;my %hash1;my $path;my %hash_res_new_add;my $counter1=0;my $header_gene_list;
 my @filepath=split(/\//,$file2);
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
 print "\nReading Expression\/Information file\n";
 open(F,"$file1");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter++;
  if($counter == 1)
  {
   my @array=split(/\t/,$data,2);
   $header = $array[1];
  }
  else
  {
   my @array=split(/\t/,$data,2);
   $hash{$array[0]}{$array[1]}=0;
  }
 }
 close F;
 print "\nReading Gene List file\n";
 open(F,"$file2");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter1++;
  if($counter1==1)
  {
   $header_gene_list=$data;
  }
  else
  {
   my @arr=split(/\t/,$data,2);
   if($arr[1] eq "")
   {
    my $val_added="novalprovided";
    $hash1{$arr[0]}{$val_added}=0;
   }
   else
   {
    $hash1{$arr[0]}{$arr[1]}=0;
   }
  }
 }
 close F;
 print "\nExtracting Expression\/Information of genes of interest\n";
 foreach my $m(keys %hash1)
 {
  if(exists $hash{$m})
  {
   foreach my $a(keys %{$hash1{$m}})
   {
    if($a eq "novalprovided")
    {
     foreach my $b(keys %{$hash{$m}})
     {
      $hash_res_new_add{$m}{$b}=0;
     }
    }
    else
    {
     foreach my $b(keys %{$hash{$m}})
     {
      my $var_add=$a."\t".$b;
      $hash_res_new_add{$m}{$var_add}=0;
     }
    }
   }
  }
 }
 my $outfile = "Expression"."\_".$filename;
 open(OUT,">$path/$outfile");
 print OUT "$header_gene_list\t$header\n";
 foreach my $m(keys %hash_res_new_add)
 {
  if($m eq "")
  {}
  else
  {
   foreach my $n(keys %{$hash_res_new_add{$m}})
   {
    print OUT "$m\t$n\n";
   }
  }
 }
 close OUT;