#!/usr/bin/perl
use File::Copy;

# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if (!$num_args) {
   print "\nUsage: name.pl <Linux or Windows> < MySql Root Password>\n";
   exit;
   } elsif (($ARG[0] eq "Linux") and $num_args != 2) {
	print "\nUsage: name.pl Missing MySql Root password\n";
	print $num_args;
        exit;
    }


# OS and password for mysql root
$OS=$ARGV[0];
$password=$ARGV[1];

#Determine which OS will be created
if ($OS eq 'Linux') {
    print "He chose $OS\n";
    #Create copy of vagrantfile
    copy("VagrantfileLinux","Vagrantfile");
    $file = "Vagrantfile"; 
    #Read file in so password can be updated
    open my $in,  '<',  $file      or die "Can't read old file: $!";
    open my $out, '>', "$file.new" or die "Can't write new file: $!";

    while( <$in> )   # print the lines before the change
    {
        #Get line to update password
    	print $out $_;
    	if ($. == 11) { 
	print $.;
	my $line = <$in>;
	print $line;
	$line =~ s/\b(testpassword)\b/$password/g;
	print $out $line;
	}
    }
    #Overwrite Vagrantfile with new updated Vagrantfile
    move("$file.new","$file");
    #Create Linux VM 
    system('vagrant up');

  } elsif ($OS eq "Windows"){
    print "He chose $OS\n";
    #Create Vagrant file to create Windows VM
    copy("VagrantfileWin","Vagrantfile");
    #Create Window VM
    system('vagrant up');
	} else {
	#If no valid parameters have been inputed. 
	print "Invalid Input\n";
}
