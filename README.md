# useful_scripts
A bunch of useful scripts for my day-to-day analyses. To be continually updated

# List of scripts
***

### **diyabc_tidy.R**

Source script for a function that goes through the output file of vcf2diyabc and removes any loci that have 100% missing data for any population (as diyabc-rf cannot handle these). 

Note that:
* For some reason the vcf2diyabc script always makes the POP value for the final row miss a character, so this needs to be added in manually afterwards.
* This function assumes that the sex ratio is <NM=1NF> (as is the case with my systems) and that the MAF algorithm is Hudson's - <MAF=Hudson>

Example use:
```
diyabc_tidy(input_loc, output_loc, title)
input_loc = path to input .snp file
output_loc = path to where output file should be saved and what it should be named
title = title to go on Row 1 of output .snp file

diyabc_tidy("crob/ALL_SITES/crob_neutral.DIYABC.snp", "crob/ALL_SITES/test_1.snp", title = "WAUS_MAN_MEL_ROW")
```
