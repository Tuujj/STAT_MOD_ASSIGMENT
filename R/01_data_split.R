library(here)  # here() builds paths from the project root (where the .Rproj lives)

data <- readRDS(here("data", "ProjectData_2324.rds"))

# Factor (our) categorical variables
data$visit <- factor(data$visit, levels = c(0, 1, 2, 3, 4), labels = c("none", "<=4.5", "<8.8", "<13.5", ">=13.5"))

data$agecat <- factor(data$agecat, levels = c(0, 1, 2, 3, 4), labels = c("<75", "75-79", "80-84", "85-89", "90+"))

data$marital3cat <- factor(data$marital3cat, levels = c(0, 1, 2), labels = c("married", "single/sep/div", "widowed"))

data$chc_04 <- factor(data$chc_04, levels = c(0, 1), labels = c("no", "yes"))

# If needed, this is also a categorical var
# data$spd_02 <- factor(data$spd_02, levels = c(1, 2), labels = c("male", "female")) 

# Ensures we use the same split
set.seed(2026)

n <- nrow(data)
# Perform 80/20 split randomly, would have been grouped if we needed for prediction
train_rows <- sample(1:n, size = round(0.8 * n))

train <- data[train_rows, ]    
test  <- data[-train_rows, ]  

# Check sizes and that no resident ends up in both sets
nrow(train); nrow(test)
length(intersect(train$r_id, test$r_id))  

# Note: We didn't remove Incomplete data isn't removed yet and all columns are still included
saveRDS(train, here("R", "train.rds"))
saveRDS(test,  here("R", "test.rds"))
