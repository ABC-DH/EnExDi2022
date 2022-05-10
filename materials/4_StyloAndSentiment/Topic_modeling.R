# This is an R script file, created by Simone
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line and press Ctrl+Enter
# (the command will be automatically copy/pasted into the console)

# before everything starts: check the working directory!

# required packages:
# install.packages("stylo")

### Instructions
# the script will prepare corpus for topic modeling via the online platform jsLDA https://mimno.infosci.cornell.edu/jsLDA/jslda.html 
# to run the script, you need to have a selection of texts in ".txt" files in a folder called "corpus"
# you will have to define the number of topics and the length of text chunks
# careful: number of topics should be the same you will use in the online platform!!

### Define variables
len_split <- 1000 # length of the split texts
no_topics <- 25 # number of topics

#################
### From this point on, you can run the full script without changing anything 

library(stylo)

### Prepare the corpus
tm_corpus <- list()
texts_list <- list.files("corpus", full.names = T)

for(i in 1:length(texts_list)){
  
  # read txt files
  loaded_file <- readLines(texts_list[i], warn = F)
  # save the texts inside a provisional variable
  tm_corpus[[i]] <- paste(loaded_file, collapse = "\n")
  
  # define a new title for the output text
  new_title <- gsub(pattern = "corpus/|.txt", replacement = "", x = texts_list[i])
  names(tm_corpus)[i] <- new_title
  
  # print progress
  print(i)
  
}

### remove the result of previous processes
file.remove("topic_modeling_files/corpus.txt")

### Main loop to generate final files
counter <- no_topics
all_labels <- character()
for(i in 1:length(tm_corpus)){
  text_tmp <- tm_corpus[[i]]
  tokenized_text <- unlist(strsplit(text_tmp, "\\W"))
  tokenized_text <- tokenized_text[-which(tokenized_text=="")]
  len_limit <- length(tokenized_text)
  print(len_limit)
  split_dim <- trunc(len_limit/len_split)
  tokenized_text_split <- split(tokenized_text, ceiling(seq_along(tokenized_text)/len_split))
  tokenized_text_split <- tokenized_text_split[-length(tokenized_text_split)]
  tokenized_text_split <- unlist(lapply(tokenized_text_split, function(x) paste(x, collapse = " ")))
  for(n in 1:length(tokenized_text_split)){
    cat(counter, "\t", paste(names(tm_corpus)[i], n, sep = "_"), "\t", tolower(tokenized_text_split[n]), "\n", file = "topic_modeling_files/corpus.txt", append = T, sep = "")
    all_labels[counter] <- paste(names(tm_corpus)[i], n, sep = "_")
    counter <- counter+1
  }
}
all_labels <- all_labels[-which(is.na(all_labels))]

### Write accompanying files (useful for visualizations in Gephi)
Id <- 0:(counter-1)
Label <- c(paste("Topic", 0:(no_topics-1), sep = "_"), all_labels)
group <- strsplit(Label, split = "_")
group <- sapply(group, function(x) x[1])
labels_df <- data.frame(Id, Label, group, stringsAsFactors = F)
write.csv(labels_df, file = "topic_modeling_files/gephi_nodes.csv",row.names = F)
