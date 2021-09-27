library(data.table) 
library(ggplot2) 
library(ggthemes) 

df <- read.csv('/Users/moonqj/Desktop/Boston University/Fall 2021/BA 810/Project/aug_train.csv')

str(df)

dt <- data.table(df)

str(dt)

# training hour all
training_target_all <- dt[, training_hours]
str(training_target_all)

training_target_all <- data.table(training_target_all)
str(training_target_al)


# training hour 1
training_target_1 <- dt[target == 1,training_hours]
str(training_target_1)

training_target_1 <- data.table(training_target_1)
str(training_target_1)


# training hour 0
training_target_0 <- dt[target == 0,training_hours]
str(training_target_1)

training_target_0 <- data.table(training_target_0)
str(training_target_0)


theme_Ji <- theme_bw()+  
  theme(
    plot.title=element_text(hjust=0.5, vjust=0.5, face='bold.italic'),
    axis.text.x = element_text(face="bold", color="#993333", 
                               size=10, angle=0),
    axis.text.y = element_text(face="bold", color="#993333", 
                               size=10, angle=0),
    axis.title.x = element_text(color="black", size=14, face="bold"),
    axis.title.y = element_text(color="black", size=14, face="bold")
  )

theme_set(theme_Ji)

ggplot(training_target_1, aes(x=training_target_1)) +
  geom_histogram(bins = 10)+
  ggtitle('Looking for a new job (Target = 1)')+
  labs(x = 'training hours', y = 'count')+
  ylim(0,6000)

ggplot(training_target_0, aes(x=training_target_0)) +
  geom_histogram(bins = 10)+
  ggtitle('Not looking for a new job (Target = 0)')+
  labs(x = 'training hours', y = 'count')+
  ylim(0,6000)

ggplot(training_target_all, aes(x=training_target_all)) +
  geom_histogram(bins = 10)+
  ggtitle('Training Hours_Target')+
  labs(x = 'training hours', y = 'count')+
  ylim(0,10000)

ggplot(dt, aes(x = target, fill = relevent_experience))+
  geom_bar(stat = 'count', width = 0.5, position = 'dodge')+
  labs(x='target value', y = 'count')+
  ggtitle("Average bill for 2 people") +
  geom_text(stat='count', aes(label=..count..), position = position_dodge(width = .5), vjust=-.1, size = 3, color = 'brown')+
  scale_fill_hue(name="Sex of payer")+
  theme(
    plot.title=element_text(hjust=0.5, vjust=0.5, face='bold')
  )
 

ggplot(dt, aes(x = target, fill = gender))+
  geom_bar(stat = 'count', width = 0.5, position = 'dodge')+
  geom_text(stat='count', aes(label=..count..), position = position_dodge(width = .5), vjust=-.1, size = 3, color = 'brown')+
  labs(title = 'Looking for a new job or not (gender)')

data.table(training_target_0[1:4777], training_target_1)




