indeed = read.table(file = "train.tsv", sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
indeedPart = indeed
indeedPart$Part = ifelse( grepl("part",indeedPart$tags), 1, 0)
indeedPart$Full = ifelse( grepl("full",indeedPart$tags), 1, 0)
indeedPart$tags = NULL
write.csv(indeedPart,"indeedPart.csv")
