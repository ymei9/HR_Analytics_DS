data <- read.csv("cleaned_data_810_10_06.csv")
data$target <- factor(data$target)
#data$city <- factor(data$city)
data$gender <- factor(data$gender)
data$relevent_experience <- factor(data$relevent_experience)
data$enrolled_university <- factor(data$enrolled_university)
data$education_level <- factor(data$education_level)
data$major_discipline <- factor(data$major_discipline)
data$experience <- factor(data$experience)
data$company_size <- factor(data$company_size)
data$company_type <- factor(data$company_type)
data$last_new_job <- factor(data$last_new_job)
install.packages("randomForest")
install.packages("ggplot2")
install.packages("dplyr")

set.seed(123)
test_size <- floor(0.3*nrow(data))
sam <- sample(nrow(data), test_size, replace = FALSE)

train <- data[-sam, 1:12]
test <- data[sam, 1:12]

library(randomForest)
model <- randomForest(target~., data = train, importance = TRUE)
print(model)

pred <- predict(model, test[, 1:11])
table(test=test[, 12], predict = pred)
accuracy <- mean(test[, 12] == pred)
print(accuracy)

varImpPlot(model)

library(ggplot2)
library(dplyr)
importance <-  importance(model)
varImportance <-  data.frame(Variables = row.names(importance),
                           Importance =round(importance[, "MeanDecreaseAccuracy"],2))
rankImportance <- varImportance %>%
  mutate(Rank=paste('#',dense_rank(desc(Importance))))
                     
ggplot(rankImportance,aes(x=reorder(Variables,Importance),
                          y=Importance,fill=Importance)) + 
  geom_bar(stat='identity') + 
  geom_text(aes(x = Variables, y = 0.5, label = Rank),
            hjust=0, vjust=0.55, size = 4, colour = 'red') +
  labs(x = 'Variables') +
  coord_flip() + 
  theme_classic()


