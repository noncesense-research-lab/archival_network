echo Run in the directory with your Monero log files to extract alternative block and reorg events
echo --------
grep -B2 Hydrogen\|Wolfram\|Helium\|Lithium\|ALTERNATIVE\|REORG\|stopped\ successfully -E bitmonero.log* > output_log_to_share.txt

# Note: grep is a command that searches for text in files, {Hydrogen, Wolfram, Helium, and Lithium} are Monero release names, and {"ALTERNATIVE" and "REORG"} search strings are used to extract the relevant events. The "> output_log_to_share.txt" stores the extracted log events in a file with that name. 
# Feel free to change the output filename.
echo --------
echo Please share results at https://github.com/mitchellpkt/Monero_AltBlock_Research 
echo or email anonymously to IsthmusCrypto@protonmail.com
