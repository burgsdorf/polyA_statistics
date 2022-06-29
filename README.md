# polyA_statistics
PolyA statistics of the fasta files. 
The script is build for two lines fasta sequences (first line is header and the second line is sequence) without empty lines between sequences

Usage:
perl -w polyA_stat.pl INPUT_FILE.fasta

Summary file will be created in the end (INPUT_FILE.polyA_report):
"
Seq_name	length	perc_of_A	perc_of_T	Total_number_of_polyA	A2	A3	A4	A5	A6	A7	A8	A9	A10	A11	A12	A13	A14	A15	A16	A17	A18	A19	A20	A21	A22	A23	A24	A25	A26	A27	A28	A29	A30
small letters test	65	61.5384615384615	32.3076923076923	4	0	1	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0
big letter test	99	24.2424242424242	38.3838383838384	6	2	2	1	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
"
