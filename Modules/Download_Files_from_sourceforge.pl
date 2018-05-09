###Version1.0
  #### Download files from sourceforge useraccount
use File::chdir;
my $dir_to_download=$ARGV[0];
chdir $dir_to_download;
print "\nDownloading BIOGRID Files for Human and Mouse\n";
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/BIOGRID-ORGANISM-Homo_sapiens-3.4.160.tab2.txt');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/BIOGRID-ORGANISM-Mus_musculus-3.4.160.tab2.txt');
sleep(1);
print "\nDownloading UCSC maps for human, mouse, frog and zebrafish\n";
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Human_Map.txt');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Mouse_Map.txt');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Laevis_Map.txt');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Trop_Map.txt');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Zebrafish_Map.txt');
print "\nDownloading Chrom Sizes for Human, Mouse, Frog and Zebrafish\n";
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/human_chrom_sizes.genome');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Laevis_chrom_sizes.genome');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/mouse_chrom_sizes.genome');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Trop_chrom_sizes.genome');
system('wget --no-check-certificate https://sourceforge.net/projects/csbb-repository/files/Zebrafish_chrom_sizes.genome');
print "\nAll Required Files are downloaded and unpacked from SourceForge Repository\n";