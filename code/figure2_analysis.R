
library(dplyr)
library(lfe)

t <- read.csv('job_city2022-2024.csv')
t <- t %>% mutate(tid = (year-2022)*12 + month - 9, stage = ceiling((tid-1)/4))
t <- t %>% group_by(city, rate_expo) %>% arrange(tid) %>%
  mutate(ref = first(num_post)) %>%
  mutate(num_post_ratio = num_post / ref) %>%
  ungroup()

t <- t %>% group_by(city, rate_expo) %>% arrange(tid) %>%
  mutate(ref = first(industry)) %>%
  mutate(industry_ratio = industry / ref) %>%
  ungroup()

t <- t[!is.na(t$num_post_ratio),]

# exclude the impact of general economic trends and economic trends by industrial sectors
m <- lm(num_post_ratio ~ industry_ratio + as.factor(time), t)
summary(m)
t$num_post_ratio_res <- residuals(m) + m$coefficients[[1]] + m$coefficients[[2]]

# generate the confidence intervals for job posting changes through bootstrapping
s <- aggregate(num_post_ratio_res ~ tier_city+rate_expo+stage, t, mean)
s$ci_l <- 0
s$ci_u <- 0
for (tier_cityn in 1:4){
  for (rate_expon in 1:4){
    for (stagen in 1:4){
      tt <- filter(t, tier_city==tier_cityn, rate_expo==rate_expon, stage==stagen)
      bootstrap_means <- replicate(1000, mean(sample(tt$num_post_ratio_res, nrow(tt), replace = TRUE), na.rm = T))
      ci <- quantile(bootstrap_means, c(0.025, 0.975), na.rm = T)
      s$ci_l[which(s$tier_city==tier_cityn & s$rate_expo==rate_expon & 
                     s$stage==stagen)] <- ci[1]
      s$ci_u[which(s$tier_city==tier_cityn & s$rate_expo==rate_expon & 
                     s$stage==stagen)] <- ci[2]
    }
  }
}
write.csv(s,'fig2.csv')
