library(tidyverse)
all_na <- function(x) any(!is.na(x))
diyabc_tidy <- function(input_loc, output_loc, title){
  

input_snp <- suppressWarnings(read_tsv(input_loc, skip = 1))
end.x <- length(input_snp)
end.x.num <- end.x - 3 
names(input_snp)[4:end.x] <- seq(1,end.x.num,1)

input_snp.na <- input_snp %>% select(-SEX) %>% na_if(., 9) %>% add_column(SEX = input_snp$SEX, .before = "POP")
  
input_snp.na$POP <- as.factor(input_snp.na$POP)

comb_cols <- as.character()
for(i in seq_along(levels(input_snp.na$POP))){
  pls <- input_snp.na %>% filter(POP == levels(POP)[i]) %>% select(where(all_na))
  pls_colnames <- colnames(pls)
  comb_cols <- c(comb_cols, pls_colnames)
}

freqs <- table(comb_cols)
freqs_df <- as.data.frame(freqs[freqs >= length(levels(input_snp.na$POP))])
cols2keep <- as.character(freqs_df$comb_cols)
x <- length(cols2keep) - 3
cols2keep_num <- sort(as.numeric(cols2keep[1:x]))

output_snp <- input_snp %>% select("IND", "SEX", "POP", as.character(cols2keep_num))

end.output <- length(output_snp)
names(output_snp)[4:end.output] <- "A"
cat_string <- paste(title, "<NM=1NF> <MAF=Hudson>")
cat(cat_string, file = output_loc, sep = "\n")
write.table(output_snp, output_loc, quote = FALSE, sep = "\t", row.names = FALSE, append = T)
warning("### Make sure the POP value for final row is correct ###")
}