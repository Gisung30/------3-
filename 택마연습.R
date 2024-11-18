setwd("C:/work")

library(officer)

trump.speech<-read_docx("Trump_2021_final_speech.docx")

trump.speech.sum<-trump.speech %>% docx_summary()

trump.speech.sum %>% head(2) 


length(trump.speech.sum$doc_index)
#29개가 있다.
View(trump.speech.sum)


#1-3


extracted_texts <- trump.speech.sum$text %>% str_extract('\\[[:alpha:]{1,}')


# Get the indices of non-NA values
valid_indices <- which(!is.na(extracted_texts))

# Extract the corresponding text based on valid indices
result_texts <- trump.speech.sum$text[valid_indices]

# Display the extracted texts
result_texts




trump.speech.sum$text[valid_indices]

# Filter out non-relevant content, leaving only Trump's speech

# Extract text based on valid indices
result_texts <- trump.speech.sum$text[valid_indices]

# Retain only texts starting with "Donald Trump"
filtered_texts <- ifelse(str_detect(result_texts, "^\\[Donald Trump"), result_texts, NA)

# Apply filtering to the original data frame
trump.speech.sum$filtered_text <- trump.speech.sum$text
trump.speech.sum$filtered_text[valid_indices] <- filtered_texts

# Display the filtered texts
trump.speech.sum$filtered_text


# Retain only texts starting with an English letter or "[" (for brackets)
trump.speech.sum$filtered_text <- ifelse(str_detect(trump.speech.sum$filtered_text, "^[A-Za-z\\[]"), trump.speech.sum$filtered_text, NA)

# Remove texts that are only spaces
trump.speech.sum$filtered_text <- ifelse(str_trim(trump.speech.sum$filtered_text) == "", NA, trump.speech.sum$filtered_text)

# Filter out rows where filtered_text is NA
trump.speech.sum <- trump.speech.sum %>% filter(!is.na(filtered_text))


str_extract(unlist(trump.speech.sum$filtered_text),"love")

a<-unlist(trump.speech.sum$filtered_text)


strsplit(a, split = "\n" )

paste(trump.speech.sum$filtered_text," ")


# Count the occurrences of the word "love" (case-insensitive) in the filtered text
love_count <- str_count(trump.speech.sum$filtered_text, regex("love", ignore_case = TRUE))



# Sum up the total occurrences of "love"
total_love_count <- sum(love_count, na.rm = TRUE)

# Display the total count of the word "love"
total_love_count

#아하 결국에는 다 찾을 수 있는것은 맞지만 대소문자의 문제!!!!\

love_count <- str_count(tolower(trump.speech.sum$filtered_text), "love")

airbnb.review.ls



load("airbnb.review.RData")

head(airbnb.review)

str(airbnb.review)

summary(airbnb.review)

sum(is.na(airbnb.review))

airbnb.review.ls<-list()

df <-airbnb.review %>%
  group_by(listing_id) %>%
  summarise(all_words = paste(comments, collapse = " "))

airbnb.review.ls <- df$all_words%>%
  strsplit(' ')

lapply(airbnb.review.ls, head, 15)


airbnb.review.ls

unique(airbnb.review$listing_id)       

unique(airbnb.review$comments)       



lapply(airbnb.review.ls,head,15)





comments_logical <- airbnb.review$comments %>%
  str_detect('automated posting')

#Filter out rows where 'automated posting' appears in the comments
airbnb.review.updated <- airbnb.review %>%
  filter(!comments_logical)

airbnb.review.updated

#Group the updated data by listing_id and concatenate the comments for each listing
df.updated <-airbnb.review.updated %>%
  group_by(listing_id) %>%
  summarise(all_words = paste(comments, collapse = " "))

airbnb.review.ls.updated <- df.updated$all_words%>%
  strsplit(' ')



love_count <- str_count(tolower(airbnb.review.ls.updated), "love")

love_count




# 2-5

# Extract words before and after "love" for the listing_id with the most mentions
comments <- airbnb.review.ls[[3]]

# Find the indices where the word "love" appears
love_indices <- grep("love", comments, ignore.case = TRUE)

# Extract the words before and after "love"
love.neighbor <- data.frame(
  love.before = comments[love_indices - 1],  # Word before "love"
  love.before = comments[love_indices],  # The word "love"
  love.after = comments[love_indices + 1]    # Word after "love"
)

# Output the first 6 rows of the result
head(love.neighbor)


# 2-6

# Clean up meaningless characters and spaces from love.before and love.after
love.neighbor_clean <- love.neighbor %>%
  mutate(love.before = str_squish(str_replace_all(love.before, "[^\\w]", "")),  # Remove all non-word characters
         love.after = str_squish(str_replace_all(love.after, "[^\\w]", "")))    # Remove all non-word characters

# Calculate the frequency of words in love.before and love.after
# Count word frequency for love.before
love_before_freq <- love.neighbor_clean %>%
  count(love.before, sort = TRUE)

# Count word frequency for love.after
love_after_freq <- love.neighbor_clean %>%
  count(love.after, sort = TRUE)

# Output the frequency tables
love_before_freq  # Many determiners and conjunctions, with 'everything' appearing frequently.

love_after_freq  # "Many determiners, conjunctions, and the word 'stay' appear frequently."

#Excluding grammatical terms, "everything" and "stay" are the most frequent.


