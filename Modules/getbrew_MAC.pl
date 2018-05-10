#### version1.0
  #### Auto install Dependencies
#### version1.1
  #### Auto download Biogrid data and install RSEM and SRA TOOLKIT along with other dependencies
print "\nCSBB is installing a CPAN module so please allow access if required\n";
system('sudo', 'perl', '-MCPAN', '-e', 'install Bundle::CPAN');
system('sudo', 'perl', '-MCPAN', '-e', 'install File::chdir');
use Cwd;
my $cwd = getcwd;
my $dir_to_install=$ARGV[0];
chomp $$dir_to_install;
system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"');
system('brew', 'update');
system('brew', 'doctor');
system('brew','install','homebrew/science/samtools');
system('brew','upgrade','samtools');
system('brew','install','homebrew/science/bowtie2');
system('brew','install','homebrew/science/bedtools');
system('brew','install','homebrew/science/fastqc');
system('brew','install','wget');
system('brew','install','pandoc');
system('brew','cask','install','java');
system('brew','install','gcc');
print "\nInstalling SRA Toolkit\n";
my $script_to_install_sratoolkit=$cwd."\/"."Modules"."\/"."Install_SRAtoolkit_Mac.pl";
system("perl","$script_to_install_sratoolkit","$dir_to_install");
print "\nMaking bash scripts executable\n";
my $bash1=$dir_to_install."\/"."RNA-SEQ_SINGLE-END.sh";
system('chmod' ,'+x' ,$bash1);
my $bash2=$dir_to_install."\/"."RNA-SEQ_PAIRED-END.sh";
system('chmod' ,'+x' ,$bash2);
my $bash3=$dir_to_install."\/"."Bedgraph_Bigwig_MAC"."\/"."bedGraphToBigWig";
system('chmod' ,'+x' ,$bash3);
my $bash4=$dir_to_install."\/"."CHIP-ATAC-Seq_SingleEnd.sh";
system('chmod' ,'+x' ,$bash4);
my $bash5=$dir_to_install."\/"."CHIP-ATAC-Seq_PairedEnd.sh";
system('chmod' ,'+x' ,$bash5);
print "\nInstalling RSEM\n";
my $script_to_install_rsem=$cwd."\/"."Modules"."\/"."Install_RSEM_MAC.pl";
system("perl","$script_to_install_rsem","$dir_to_install");
print "\nInstalling MACS2\n";
system('sudo pip install numpy');
system('sudo pip install MACS2');
print "\nDownloading Files from SourceForge\.Net\n";
my $script_to_download=$cwd."\/"."Modules"."\/"."Download_Files_from_sourceforge.pl";
system("perl","$script_to_download","$dir_to_install");
print "\nDownloading Indexes from SourceForge\.Net\n";
my $script_to_download1=$cwd."\/"."Modules"."\/"."Download_RSEM_Bowtie2_Indexes_Sourceforge.pl";
system("perl","$script_to_download1","$dir_to_install");
