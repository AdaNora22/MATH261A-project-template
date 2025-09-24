# MATH261A-project-1


## Data 

**Example statement:** Data used in this project is obtained from [SCORE Sports Data Repository](https://data.scorenetwork.org/) provided by [Brendan Karadenes](https://data.scorenetwork.org/swimming/olympic_swimming.html)

## Initial Data Dictionary (raw_olympic_swimming.csv)
| Variable     | Type    | Description                                                                 | Example            | Notes |
|--------------|---------|------------------------------------------------------------------------------|--------------------|-------|
| `Location`   | string  | Host city of the Olympics in which the swimmer competed.                     | `Tokyo`            | —     |
| `Year`       | integer | Calendar year of the Olympic Games.                                          | `2020`             | —     |
| `dist_m`     | integer | Race distance in meters.                                                     | `100`              | In this file, only 100 m events are present. |
| `Stroke`     | string  | Stroke of the event.                                                         | `Backstroke`       | One of: `Backstroke`, `Breaststroke`, `Butterfly`, `Freestyle`. |
| `Gender`     | string  | Division of the event.                                                       | `Men`              | Values: `Men`, `Women`. |
| `Team`       | string  | IOC three-letter country/NOC code associated with the swimmer.               | `USA`              | Historical codes appear (e.g., `URS`, `EUN`, `GDR`, `FRG`, `ROC`). |
| `Athlete`    | string  | Athlete’s full name.                                                         | `Ryan Murphy`      | —     |
| `Results`    | numeric | Official time to complete the race (seconds).                                | `52.19`            | —     |
| `Rank`       | integer | Finishing place in the event.                                                | `1`                | 1 = gold, 2 = silver, 3 = bronze, etc.; ties possible. |
| `time_period`| string  | Era indicator used by the source dataset. | `recent` | Values: `recent`, `early`


## Cleaned Data Dictionary (cleaned_olympic_swimming.csv)
| Variable     | Type    | Description                                                                 | Example            | Transform / Notes |
|--------------|---------|------------------------------------------------------------------------------|--------------------|-------------------|
| `year`       | integer | Calendar year of the Olympic Games.                                          | `2020`             | Unchanged from source. |
| `stroke`     | string  | Stroke of the event.                                                         | `Backstroke`       | Filtered to relevant stroke in analyses; source had {Backstroke, Breaststroke, Butterfly, Freestyle}. |
| `gender`     | string  | Event division.                                                              | `Men`              | Analyses use Men; source also has Women. |
| `athlete`    | string  | Athlete’s full name.                                                         | `Ryan Murphy`      | Unchanged. |
| `results`    | numeric | Official finish time in seconds.                                         | `52.19`            | Unchanged; numeric. |
| `team_std`   | string  | Standardized team | `USA` | Values: `USA`, `RUS`, `GER`, etc.


## External Resources

**Example statement:** The final report and code were written by Nora Adadurova, but the following resources were used for preliminary research:
* LLM-based chatbots: ChatGPT 5
* Online forums: Stack Overflow

# Acknowledgments

This project repository is based on the template provided by [Rohan Alexander](https://github.com/RohanAlexander/starter_folder/tree/main).


