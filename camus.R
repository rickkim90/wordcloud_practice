#R  기본경로 설정
setwd("C:/dev/r_work")

library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
text <- readLines("test_michael sandel_watson.txt") 

docs <- Corpus(VectorSource(text))
toSpace <-content_transformer(function(x,pattern) gsub(pattern,"",x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs,removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("blabla1","blabla2"))

docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v), freq=v)
head(d,10)
set.seed(1234)
png("camus_temp.png")

wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))

dev.off()