# step-1. text repository "Corpus". For that create a folder in a working directory, where the .txt file is stored. All texts from this folder are being uploaded into corpus. Then the tm package process it:
library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(SnowballC)
Mariana <- Corpus(DirSource("/Users/pauline/Documents/R/36_SCRIPT-Wordcloud/text/"))
# step-2. look up
inspect(Mariana)
# step-3. clean up and sort corpus of words:
Mariana <- tm_map(Mariana, stripWhitespace)
Mariana <- tm_map(Mariana, tolower)
Mariana <- tm_map(Mariana, removeWords, stopwords("english"))
Mariana <- tm_map(Mariana, stemDocument)
# step-4. plot word could:
wordcloud(Mariana, scale=c(5,0.3),
min.freq=1,
max.words=300,
random.order=F,
rot.per=0.35, use.r.layout=FALSE,
colors=brewer.pal(8, "Dark2"),
vfont=c("sans serif","plain"))
