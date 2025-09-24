## cleaning_data.R

# reminder of the research question: 
# "For the USA in Men’s 100m Backstroke, by how many seconds does the best USA time change per Olympic year?"

# import raw data
swimming_data <- read.csv("/Users/noraadadurova/Desktop/Math_261A/projects/MATH261A-project-template/data/raw_olympic_swimming.csv", 
                 header = TRUE)

# show the first 5 raws from the dataset
head(swimming_data)

# get general info on the dataset
summary(swimming_data)
str(swimming_data)

# let's check for missing data
anyNA(swimming_data)

# note: got FALSE so there are no NA or NaN values in swimming_data

# let's check the values of columns that we need for model
# dist_m == 100
unique(swimming_data$dist_m)

# columns Team: Team == "USA"
unique(swimming_data$Team)

# note that there are changes to team name from 1970 to 2020
# according to googling:
# Russia-related: RUS (Russia), ROC (Russian Olympic Committee, 2020–2022 sanctions), URS (Soviet Union, pre-1992), and EUN (Unified Team, 1992 made up largely of former USSR republics).
# Germany-related: GER (unified Germany), FRG (West Germany), GDR (East Germany).
# Czech/Slovak lineage: TCH (Czechoslovakia) split into CZE and SVK. So, TCH + SVK are historically linked.
# HKG (Hong Kong) is NOT the same as CHN (China) for Olympic purposes.
# PUR (Puerto Rico) is NOT included into USA.
# BLR, UKR, KAZ are successor states of URS but NOT included in Russia.
swimming_data_updated <- swimming_data |>
  # 1) standardizing team codes into a single column for Russia and Germany
  mutate(team_std = case_when(
    Team %in% c("RUS","ROC","URS","EUN") ~ "RUS",
    Team %in% c("GER","FRG","GDR")       ~ "GER",
    TRUE                                 ~ Team
  )) |> 
  # 2) dropping Czechoslovakia/Czech/Slovak rows 
  filter(!Team %in% c("TCH","SVK","CZE"))

# let's check results for data cleaning
length(unique(swimming_data$Team))
length(unique(swimming_data_updated$team_std))

unique(swimming_data$Team)
unique(swimming_data_updated$team_std)

# columns Gender: Gender == "Men"
unique(swimming_data_updated$Gender)

# columns Stroke: Stroke == "Backstroke"
unique(swimming_data_updated$Stroke)

# checking is the data available for all countries in this category
# Gender == "Men" and Stroke == "Backstroke"
men_back <- swimming_data_updated |>
  filter(Gender == "Men", 
         Stroke == "Backstroke") |>
  filter(!is.na(team_std), 
         !is.na(Year))

head(men_back)

all_years <- sort(unique(men_back$Year))

head(all_years)

# building coverage table by team
coverage <- men_back |>
  group_by(team_std) |>  # analyzing one team at a time
  summarise(
    n_years = n_distinct(Year),
    years   = paste(sort(unique(Year)), 
                    collapse = ", "),
    .groups = "drop") |>
  mutate(has_all_years = n_years == length(all_years)) # flagging teams that appear in every year present in your subset

# teams that have results for each year
teams_all_years <- coverage |> 
  filter(has_all_years) |> 
  pull(team_std)

teams_all_years

# got character(0) so no teams have data for all years

# let's find two most covered teams in tearms of recoreds per year
top_covered_contries <- swimming_data_updated |>
  filter(Gender == "Men", 
         Stroke == "Backstroke") |>
  filter(!is.na(team_std), 
         !is.na(Year)) |>
  group_by(team_std) |>
  summarise(n_years = n_distinct(Year), 
            .groups = "drop") |>
  slice_max(order_by = n_years, 
            n = 5, 
            with_ties = TRUE) |>
  arrange(desc(n_years), 
          team_std)

top_covered_contries

# checking the new dataset before saving it
head(swimming_data_updated)

# let's drop irrelevant to the analysis columns
# make the remain columns start with lowercase
swimming_data_updated <- swimming_data_updated |>
  select(-any_of(c("Location", 
                   "dist_m", 
                   "Team", 
                   "Rank", 
                   "time_period"))) |>
  rename_with(tolower)

# check the results of changes
head(swimming_data_updated)

# let's now save the updated dataset
path <- "/Users/noraadadurova/Desktop/Math_261A/projects/MATH261A-project-template/data/cleaned_olympic_swimming.csv"
write.csv(swimming_data_updated, 
          file = path, 
          row.names = FALSE)

