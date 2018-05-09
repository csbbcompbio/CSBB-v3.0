###Version1.0
  #### can make pre-downloaded RSEM
###Version1.1
  #### auto  download and install RSEM 
use File::chdir;
my $dir_to_install=$ARGV[0];
chdir $dir_to_install;
system('wget https://github.com/deweylab/RSEM/archive/v1.3.0.tar.gz');
system('tar -vxzf v1.3.0.tar.gz');
system('rm v1.3.0.tar.gz');
system('mv RSEM-1.3.0 RSEM');
my $FinalRSEM_dir=$dir_to_install."\/"."RSEM";
chdir $FinalRSEM_dir;
system('make');