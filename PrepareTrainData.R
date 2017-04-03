indeed = read.table(file = "train.tsv", sep = '\t', header = TRUE, stringsAsFactors = FALSE, quote = "\"")
indeedTrain = indeed
indeedTrain$Part = ifelse( grepl("part",indeedTrain$tags), 1, 0)
indeedTrain$Full = ifelse( grepl("full",indeedTrain$tags), 1, 0)
indeedTrain$Licence = ifelse( grepl("licence",indeedTrain$tags), 1, 0)
indeedTrain$TwoYears = ifelse( grepl("2-4-years",indeedTrain$tags), 1, 0)
indeedTrain$Salary = ifelse( grepl("salary",indeedTrain$tags), 1, 0)
indeedTrain$Bsdegree = ifelse( grepl("bs-degree",indeedTrain$tags), 1, 0)
indeedTrain$Associate = ifelse( grepl("associate",indeedTrain$tags), 1, 0)
indeedTrain$Ms_or_phd = ifelse( grepl("ms-or-phd",indeedTrain$tags), 1, 0)
indeedTrain$Hourly = ifelse( grepl("hourly",indeedTrain$tags), 1, 0)
indeedTrain$OneYear = ifelse( grepl("1-year",indeedTrain$tags), 1, 0)
indeedTrain$FiveYears = ifelse( grepl("5-plus-years",indeedTrain$tags), 1, 0)
indeedTrain$Supervising = ifelse( grepl("supervising",indeedTrain$tags), 1, 0)

indeedTrain$tags = NULL

library(tm)
corpus = Corpus(VectorSource(indeedTrain$description))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)

frequencies = DocumentTermMatrix(corpus)
sparse = removeSparseTerms(frequencies, 0.98)
indeedSparse = as.data.frame(as.matrix(sparse))
colnames(indeedSparse) = make.names(colnames(indeedSparse))
indeedSparse$Part = indeedTrain$Part
indeedSparse$Full = indeedTrain$Full
indeedSparse$Salary = indeedTrain$Salary
indeedSparse$Hourly = indeedTrain$Hourly
indeedSparse$Licence = indeedTrain$Licence
indeedSparse$Bsdegree = indeedTrain$Bsdegree
indeedSparse$Ms_or_phd = indeedTrain$Ms_or_phd
indeedSparse$Associate = indeedTrain$Associate
indeedSparse$OneYear = indeedTrain$OneYear
indeedSparse$TwoYears = indeedTrain$TwoYears
indeedSparse$FiveYears = indeedTrain$FiveYears
indeedSparse$Supervising = indeedTrain$Supervising

library(caTools)
split = sample.split(indeedSparse$Full, SplitRatio = 0.7)
train = subset(indeedSparse, split == TRUE)
test = subset(indeedSparse,  split == FALSE)

write.csv(train, "indeedTrain.csv")
write.csv(test, "indeedTest.csv")
