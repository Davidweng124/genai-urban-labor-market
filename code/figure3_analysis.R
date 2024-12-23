
library(dplyr)
library(openxlsx)

t <- read.csv('job_city2022-2024.csv')
v <- read.csv('var_resi.csv')

# select cities with the highest exposure to GenAI, using Oct 2022 as the reference point
temp <- filter(t, time=='2022m10')
temp <- filter(temp, expo_city > quantile(temp$expo_city, probs = 0.75))
most_expo_city <- unique(temp$city)
tm <- filter(t, city %in% temp$city)

# compute the seasonal industrial output at the city level
tm$temp <- tm$industry * tm$num_post #to get weighted sum of relevant industrial outputs
tm <- aggregate(cbind(temp, num_post, expo_city) ~ city + time + tier_city, tm, sum)
tm$industry <- tm$temp / tm$num_post
tm$expo_city <- tm$expo_city / 4
# compute relative change of job postings and industrial outputs in each city
tm <- tm %>% group_by(city) %>% arrange(time) %>%
  mutate(ref = first(num_post)) %>%
  mutate(num_post_ratio = num_post / ref) %>%
  mutate(ref = first(industry)) %>%
  mutate(industry_ratio = industry / ref) %>%
  ungroup()
tm <- select(tm, city, time, num_post, expo_city, industry, num_post_ratio, industry_ratio)

# compute the residuals
m <- lm(num_post_ratio ~ exposure + industry_ratio, tm, time=='2024m2')
#summary(m)
tm2 <- filter(tm, time=='2024m2')
tm2$res <- m$residuals
tm2 <- left_join(tm2, v, by='city')
write.xlsx(tm2, file = "fig3.xlsx")

