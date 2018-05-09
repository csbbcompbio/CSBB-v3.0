###Version1.0
  #### Download Indexes from sourceforge useraccount
use File::chdir;
my $dir_to_download=$ARGV[0];
chdir $dir_to_download;
print "\nDo you wish to download the RSEM indexes for RNA\-SEQ pipelines \: options \: yes or no\n";
my $option=<stdin>;chomp $option;
if($option eq "yes")
{
 print "\nDownloading RSEM indexes for HUMAN\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/RSEM_HUMAN.zip');
 sleep(1);
 print "\nDownloading RSEM indexes for MOUSE\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/RSEM_MOUSE.zip');
 sleep(1);
 print "\nDownloading RSEM indexes for XENOPUS LAEVIS\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/RSEM_LAEVIS.zip');
 sleep(1);
 print "\nDownloading RSEM indexes for XENOPUS TROP\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/RSEM_TROP.zip');
 sleep(1);
 print "\nDownloading RSEM indexes for ZEBRAFISH\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/RSEM_ZEBRAFISH.zip');
 sleep(1);
 print "\nNow will unzip all the indexes and prep for usuage\n";
 system('unzip RSEM_HUMAN.zip');
 system('unzip RSEM_MOUSE.zip');
 system('unzip RSEM_LAEVIS.zip');
 system('unzip RSEM_TROP.zip');
 system('unzip RSEM_ZEBRAFISH.zip');
 system('rm RSEM_HUMAN.zip');
 system('rm RSEM_MOUSE.zip');
 system('rm RSEM_LAEVIS.zip');
 system('rm RSEM_TROP.zip');
 system('rm RSEM_ZEBRAFISH.zip');
 print "\nRSEM Idexes for Human, Mouse, Frog and Zebrafish are downloaded and unpacked\n";
}
if($option eq "no")
{
 print "\nCSBB is not downloading RSEM Indexes for human, mouse, frog and zebrafish \: Please Note CSBB will not be able to run RNA\-SEQ pipelines without the indexes\n";
 sleep(1);
 print"\nIf you wish to download then please run install module again and prompt for yes or go to https://sourceforge.net/projects/csbb-repository/files/?source=navbar for downloading indexes\n";
}
print "\nDo you wish to download the Bowtie2 indexes for ChIP\/ATAC\-SEQ pipelines \: options \: yes or no\n";
my $option1=<stdin>;chomp $option1;
if($option1 eq "yes")
{
 print "\nDownloading Bowtie2 indexes for HUMAN\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Bowtie_indexes_HUMAN.zip');
 sleep(1);
 print "\nDownloading Bowtie2 indexes for MOUSE\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Bowtie_indexes_MOUSE.zip');
 sleep(1);
 print "\nDownloading Bowtie2 indexes for XENOPUS LAEVIS\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Bowtie_indexes_LAEVIS.zip');
 sleep(1);
 print "\nDownloading Bowtie2 indexes for XENOPUS TROP\n";
 system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Bowtie_indexes_TROP.zip');
 print "\nFinished downloading RSEM and Bowtie2 indexes\n";
 sleep(1);
 print "\nNow will unzip all the indexes and prep for usuage\n";
 system('unzip Bowtie_indexes_HUMAN.zip');
 system('unzip Bowtie_indexes_MOUSE.zip');
 system('unzip Bowtie_indexes_LAEVIS.zip');
 system('unzip Bowtie_indexes_TROP.zip');
 system('rm Bowtie_indexes_HUMAN.zip');
 system('rm Bowtie_indexes_MOUSE.zip');
 system('rm Bowtie_indexes_LAEVIS.zip');
 system('rm Bowtie_indexes_TROP.zip');
 print "\nBowtie2 Idexes for Human, Mouse and Frog are downloaded and unpacked\n";
}
if($option1 eq "no")
{
 print "\nCSBB is not downloading Bowtie2 Indexes for human, mouse and frog \: Please Note CSBB will not be able to run ChIP\/ATAC\-SEQ pipelines without the indexes\n";
 sleep(1);
 print"\nIf you wish to download then please run install module again and prompt for yes or go to https://sourceforge.net/projects/csbb-repository/files/?source=navbar for downloading indexes\n";
}