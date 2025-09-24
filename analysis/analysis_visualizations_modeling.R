## analysis_visualizations.R

# reminder of the research question: 
# "For the USA in Men’s 100m Backstroke, by how many seconds does the best USA time change per Olympic year?"

# install.packages(c("dplyr","ggplot2","ggpubr","broom"))  # run once
library(dplyr)
library(ggplot2)
library(ggpubr)
library(broom) 

# import data
swimming_data <- read.csv("/Users/noraadadurova/Desktop/Math_261A/projects/MATH261A-project-template/data/cleaned_olympic_swimming.csv", 
                          header = TRUE)

# let's see how does this data look
head(swimming_data)
summary(swimming_data)

# selecting one event for simple linear regression
usa_backstroke_men_swimming <- swimming_data |>
  filter(team_std == "USA",
         stroke == "Backstroke",
         gender == "Men") |>
  group_by(year) |>
  summarize(best_time = min(results, 
                            na.rm = TRUE),
            groups = "drop") 

# check how events' table looks by itself
head(usa_backstroke_men_swimming)

# scatter plot
ggplot(usa_backstroke_men_swimming, 
       aes(x = year, 
           y = best_time)) +
  geom_point(size = 2) +
  labs(title = "USA Men’s 100m Backstroke: Best Time per Olympics",
       x = "Olympic Year", 
       y = "Best USA Time (sec)") +
  theme_pubr()

# add line to scatter plot
ggplot(usa_backstroke_men_swimming, 
       aes(x = year, 
           y = best_time)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", 
              linewidth = 0.5) +
  labs(title = "USA Men’s 100m Backstroke: Best Time per Olympics",
       x = "Olympic Year", 
       y = "Best USA Time (sec)") +
  theme_pubr()

# adding labels for points
ggplot(usa_backstroke_men_swimming, 
       aes(year, 
           best_time, 
           label = year)) +
  geom_point(size = 2) +
  ggrepel::geom_text_repel(size = 3) +   # install.packages("ggrepel") if needed
  geom_smooth(method = "lm", 
              se = TRUE, 
              linewidth = 0.8) +
  labs(title = "USA Trend with Year Labels", 
       x = "Year", 
       y = "Best USA Time (sec)") +
  theme_pubr()

# save this visualization for the pdf report
p_usa_trend <- ggplot(usa_backstroke_men_swimming, 
                      aes(year, 
                          best_time, 
                          label = year)) +
  geom_point(size = 2) +
  ggrepel::geom_text_repel(size = 3) +   # install.packages("ggrepel") if needed
  geom_smooth(method = "lm", 
              se = TRUE, 
              linewidth = 0.8) +
  labs(title = "USA Trend with Year Labels", 
       x = "Year", 
       y = "Best USA Time (sec)") +
  theme_pubr()

ggsave("/Users/noraadadurova/Desktop/Math_261A/projects/fig-usa-trend.png", 
       p_usa_trend, 
       width = 7, 
       height = 4, 
       dpi = 300)

# fitting the simple linear regression
fit <- lm(best_time ~ year, data = usa_backstroke_men_swimming)
summary(fit)
confint(fit, "Year")

# let's check assinments
aug <- augment(fit)

# Residuals vs Fitted
ggplot(aug, aes(.fitted, .resid)) +
  geom_point(alpha = 0.8) +
  geom_hline(yintercept = 0, 
             linetype = 2) +
  labs(title = "Residuals vs Fitted", 
       x = "Fitted values", 
       y = "Residuals") +
  theme_pubr()

# save the Residuals vs Fitted plot for the report
residuals_plot <- ggplot(aug, aes(.fitted, .resid)) +
  geom_point(alpha = 0.8) +
  geom_hline(yintercept = 0, 
             linetype = 2) +
  labs(title = "Residuals vs Fitted", 
       x = "Fitted values", 
       y = "Residuals") +
  theme_pubr()

ggsave("/Users/noraadadurova/Desktop/Math_261A/projects/residuals_plot.png", 
       residuals_plot, 
       width = 7, 
       height = 4, 
       dpi = 300)

# QQ-plot of residuals
ggplot(aug, aes(sample = .std.resid)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "QQ-Plot of Standardized Residuals") +
  theme_pubr()

# save the QQ-plot for the report
qq_plot <- ggplot(aug, aes(sample = .std.resid)) +
  stat_qq() +
  stat_qq_line() +
  labs(title = "QQ-Plot of Standardized Residuals") +
  theme_pubr()

ggsave("/Users/noraadadurova/Desktop/Math_261A/projects/qq_plot.png", 
       qq_plot, 
       width = 7, 
       height = 4, 
       dpi = 300)


# comparing USA vs another team in the same style
compare <- swimming_data |>
  filter(stroke == "Backstroke", 
         gender == "Men") |>
  group_by(team_std, 
           year) |>
  summarize(best_time = min(results, 
                            na.rm = TRUE), 
            .groups = "drop") |>
  filter(team_std %in% c("USA","GER"))  # pick any two

ggplot(compare, 
       aes(year, 
           best_time, 
           color = team_std)) +
  geom_point(alpha = 0.9) +
  geom_smooth(method = "lm", 
              se = FALSE, 
              linewidth = 0.9) +
  labs(title = "Best Time per Olympics: USA vs GER (Men’s 100 Back)",
       x = "Year", 
       y = "Best Time (sec)") +
  theme_pubr()
