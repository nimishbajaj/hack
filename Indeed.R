indeed = read.table(file = "train.tsv", sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
indeedPart = cbind(indeed[grep("part|full", indeed$tags),])
