###Version1.0
  #### auto download and install SRA TOOLKIT
use File::chdir;
my $dir_to_install=$ARGV[0]; #### path to SRA TOOLKIT directory
chdir $dir_to_install;
system('wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.0/sratoolkit.2.9.0-ubuntu64.tar.gz');
system('wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.0/sratoolkit.2.9.0-centos_linux64.tar.gz');
system('tar -vxzf sratoolkit.2.9.0-ubuntu64.tar.gz');
system('tar -vxzf sratoolkit.2.9.0-centos_linux64.tar.gz');
system('rm sratoolkit.2.9.0-centos_linux64.tar.gz');
system('rm sratoolkit.2.9.0-ubuntu64.tar.gz');
my $finalSRAdir=$dir_to_install."\/"."sratoolkit.2.9.0-ubuntu64";
my $finalSRAdir1=$dir_to_install."\/"."sratoolkit.2.9.0-centos_linux64";
system('chmod' ,'+x' ,$finalSRAdir);
system('chmod' ,'+x' ,$finalSRAdir1);