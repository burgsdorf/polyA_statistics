# Modified by Ilia Burgsdorf, March, 2019
#===========================
use strict;
use warnings;
#===========================

# Create a hash
my %a_mer_count = ();

# Fill the hash with the names from "2" to "30"
for ($k = 2; $k < 31; $k++) {
 $a_mer_count{$k} = '0';
} 

#-------------------------------------------------------------------------
my ($fasta) = @ARGV; 
open (my $in, "<", $fasta) or die "cannot open $fasta";     # IN

# Create automatic output file based on the fasta file name
my $outTABLE = "$ARGV[0].polyA_report";                                                
open(my $out, ">", $outTABLE) or die "cannot open $outTABLE";  # OUT
#-------------------------------------------------------------------------

my $reference;
my $reference_udp;
my $tot_seq_count;
my $tot_polya_count=0;
my $glob_tot_polya_count=0;
my $perc_of_a=0;
my $perc_of_t=0;
my $length=0;
my $number1=0;
my $number2=0;

print "The script is build for two lines fasta sequences (first line is header and the second line is sequence) without empty lines between sequences. Edit your input file accordingly in advance.\n\n\n";
print $out "Seq_name\tlength\tperc_of_A\tperc_of_T\tTotal_number_of_polyA\tA2\tA3\tA4\tA5\tA6\tA7\tA8\tA9\tA10\tA11\tA12\tA13\tA14\tA15\tA16\tA17\tA18\tA19\tA20\tA21\tA22\tA23\tA24\tA25\tA26\tA27\tA28\tA29\tA30\n";

my $fasta_line = <$in>;
chomp($fasta_line);
my $seq_name = substr($fasta_line,1);   #cut ">"
 
while (defined $fasta_line) {
	if (defined $fasta_line) {
		$fasta_line = <$in>; 
		chomp($fasta_line);
		$reference = $fasta_line;  
		$tot_seq_count++;
		# Check polyA (polyT is also polyA) in the sequences. Minimal expected polyA is 2 and maximal is 30
		for ($k = 30; $k > 1; $k--) {
			$pattern1 = "A"x$k;
			$pattern2 = "T"x$k;
			# Avoid case sensitive mistakes
			$reference =~ s/a/A/ig;
			$reference =~ s/t/T/ig;
			if ($reference =~ /$pattern1/) {
				$number1 = () = $reference =~ /$pattern1/gi;    # Similar to "grep -c"  in Bash - count how many do you have of this pattern		
				$reference =~ s/$pattern1/X/ig;                     # Replace the polyA pattern with not related symbol "X" so the count will be fair for the lower polyA
				$tot_polya_count = $tot_polya_count +  $number1;
		    }
		    if ($reference =~ /$pattern2/) {
				$number2 = () = $reference =~ /$pattern2/gi;
				$reference =~ s/$pattern2/X/ig;
				$tot_polya_count = $tot_polya_count +  $number2;
		    }
		    $a_mer_count{$k} = $number1 + $number2;                      # Add to hash with counts of polyA
		    $number1 = 0;
		    $number2 = 0;
		}
		# Count % of A and T in the sequence based on the $fasta_line
		$num_of_a = () = $fasta_line =~ /[Aa]/gi;
		$num_of_t = () = $fasta_line =~ /[Tt]/gi;
		$perc_of_a = $num_of_a*100/(length($fasta_line));	
		$perc_of_t = $num_of_t*100/(length($fasta_line));	
		$length = length($fasta_line);
		print $out "$seq_name\t$length\t$perc_of_a\t$perc_of_t\t$tot_polya_count\t$a_mer_count{2}\t$a_mer_count{3}\t$a_mer_count{4}\t$a_mer_count{5}\t$a_mer_count{6}\t$a_mer_count{7}\t$a_mer_count{8}\t$a_mer_count{9}\t$a_mer_count{10}\t$a_mer_count{11}\t$a_mer_count{12}\t$a_mer_count{13}\t$a_mer_count{14}\t$a_mer_count{15}\t$a_mer_count{16}\t$a_mer_count{17}\t$a_mer_count{18}\t$a_mer_count{19}\t$a_mer_count{20}\t$a_mer_count{21}\t$a_mer_count{22}\t$a_mer_count{23}\t$a_mer_count{24}\t$a_mer_count{25}\t$a_mer_count{26}\t$a_mer_count{27}\t$a_mer_count{28}\t$a_mer_count{29}\t$a_mer_count{30}\n";		
		# Reset hash
		%a_mer_count = ();
		for ($k = 2; $k < 31; $k++) {
 			$a_mer_count{$k} = '0';
		} 
		$glob_tot_polya_count = $glob_tot_polya_count + $tot_polya_count;
		$tot_polya_count = 0;
		$fasta_line = <$in>;                                      # Read next $fasta_line - the next name of the sequence
		if (defined $fasta_line) {
			chomp($fasta_line);
			$seq_name = substr($fasta_line,1);
		}
	}
}

print "Scan for polyA/polyT sequences is finished. $tot_seq_count sequences were processed and $glob_tot_polya_count polyAs were found. File with the polyA_report extension is an output table."; 

close ($in);
close ($out);
