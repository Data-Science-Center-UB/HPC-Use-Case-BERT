# Load necessary libraries
library(reticulate)
library(purrr)
library(tidyverse)
library(DT)

# load transformers module 
transformer <- import("transformers")
autotoken <- transformer$AutoTokenizer
autoModelClass <- transformer$AutoModelForSequenceClassification

# Load tokenizer and model (ensure these are loaded before using them)
tokenizer <- transformer$AutoTokenizer$from_pretrained("cardiffnlp/twitter-roberta-base-sentiment")
model <- transformer$AutoModelForSequenceClassification$from_pretrained("cardiffnlp/twitter-roberta-base-sentiment")

# Import torch (needed for softmax conversion)
torch <- import("torch")

# Load data
eval_df <- read_csv("eval_comment.csv") |> 
  pull(Comment)

# Tokenize the Text Data for the Model
inputs <- tokenizer(eval_df, padding=TRUE, truncation=TRUE, return_tensors='pt')

# Get Model Predictions
outputs <- model(inputs$input_ids, attention_mask=inputs$attention_mask)

# Convert Model Outputs into Probabilities
predictions <- torch$nn$functional$softmax(outputs$logits, dim=1L)

# Convert Model Output into a Data Frame
pred_table <- predictions$tolist()
pred_table <- as.data.frame(do.call(rbind, pred_table))
colnames(pred_table) <- c("negative", "neutral", "positive")

# Round results
pred_table <- pred_table %>%
  mutate(across(everything(), ~ round(.x, 2)))

# Combine predictions with the original comments
df_final <- tibble(comment = eval_df) %>%
  bind_cols(pred_table)

# Save results
write_csv(df_final, "BERT_results.csv")