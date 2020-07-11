# Recode
library(quanteda)
library(tidytext)
setwd("/data/user/g/cgrasland/newsbook/corpora/mediacloud/venise")

fic<-list.files()

length(fic)
for (i in 1:length(fic)){

# select media
media<-fic[i]

# Load old file
qd<-readRDS(media)
summary(qd)
df<-tidy(qd)


# Create Quanteda corpus
qd<-corpus(df$text)

## Add id
qd$id<-paste(substr(media,8,13),rownames(df), sep="")

## Add source code
qd$source<-substr(media,4,13)

# Add date
qd$date<-df$time

# add language
qd$lang<-substr(media,1,2)

# Add global meta
meta(qd,"meta_source")<-"Media Cloud "
meta(qd,"meta_time")<-"Created in 2019 during H2020 ODYCCEUS Venice Summer School and completed later"
meta(qd,"meta_author")<-"Elaborated by Claude Grasland, Romain Leconte and Etienne Toureille"

# Create new file
name<-paste("mc_",substr(media, 1,nchar(media)-4),".Rdata",sep="")
saveRDS(qd,name)
}
