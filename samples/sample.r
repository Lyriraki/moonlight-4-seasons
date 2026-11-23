# R sample: vector, data frame, function, pipe, ggplot
library(dplyr)
library(ggplot2)

MAX_ROWS <- 100L
ratio <- 3.14
name <- "Alex"
is_ok <- TRUE
missing <- NA

# Function with default values
calculate_total <- function(price, qty = 1, discount = 0) {
  subtotal <- price * qty
  if (discount > 0) {
    subtotal <- subtotal * (1 - discount)
  } else if (is.na(discount)) {
    stop("Invalid discount")
  }
  return(subtotal)
}

df <- data.frame(
  name  = c("Coffee", "Tea", "Milk"),
  price = c(15000, 8000, 12000),
  qty   = c(2L, 1L, 3L),
  stringsAsFactors = FALSE
)

result <- df %>%
  mutate(total = price * qty) %>%
  filter(total > 10000) %>%
  arrange(desc(total))

for (i in seq_len(nrow(result))) {
  cat(sprintf("%s: %.2f\n", result$name[i], result$total[i]))
}

numbers <- sapply(1:5, function(x) x^2)
print(paste("Squares:", paste(numbers, collapse = ", ")))

p <- ggplot(df, aes(x = name, y = price, fill = name)) +
  geom_col() +
  labs(title = "Product Prices", x = "Name", y = "Price ($)") +
  theme_minimal()

tryCatch(
  calculate_total(1000, discount = NA),
  error = function(e) message("Failed: ", conditionMessage(e)),
  finally = cat("Done\n")
)
