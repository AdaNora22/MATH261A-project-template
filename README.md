# MATH261A-project-1

## Repository Structure (Context Table)
## Repository Structure (Context Table)

| Path / File                                      | Type        | Purpose / Contents                                                                 | Key Notes |
|--------------------------------------------------|-------------|------------------------------------------------------------------------------------|-----------|
| `analysis/`                                      | folder      | Analysis scripts.                                                                  | —         |
| ├─ `analysis_visualizations_modeling.R`          | R script    | Builds figures (trend, diagnostics) and/or saves plot files.                       | Source in the paper or save images via `ggsave()`. |
| └─ `cleaning_data.R`                             | R script    | Cleans raw data, standardizes team codes, creates `team_std`, exports cleaned CSV. | Produces `data/cleaned_olympic_swimming.csv`. |
| `data/`                                          | folder      | Data files.                                                                        | —         |
| ├─ `cleaned_olympic_swimming.csv`                | CSV         | **Cleaned** dataset used for analysis/modeling.                                    | Output of `cleaning_data.R`. |
| ├─ `olympic_swimming_1912_2020.csv`              | CSV         | Source dataset from SCORE (full historical coverage).                              | Read-only; keep original. |
| └─ `raw_olympic_swimming.csv`                    | CSV         | Raw import (if used) prior to cleaning.                                            | Optional staging file. |
| `paper/`                                         | folder      | Manuscript assets.                                                                 | —         |
| ├─ `paper.qmd`                                   | Quarto      | Main paper (text, math, figures included via chunks).                              | Render to PDF/HTML with Quarto. |
| └─ `paper.pdf`                                   | PDF         | Compiled manuscript.                                                               | Generated from `paper.qmd`. |
| `references.bib`                                 | BibTeX      | Bibliography entries for Quarto citations.                                         | Point to in YAML (`bibliography:`). |
| `MATH261A-project-template.Rproj`                | RProj       | RStudio project file.                                                              | Open to load the project. |
| `.gitignore`                                     | config      | Files/folders Git should ignore.                                                   | Add large data/outputs as needed. |
| `README.md`                                      | Markdown    | Project overview, data dictionary, how to reproduce.                               | You’re editing this file. |
| `git/`                                           | folder      | (If present) Git-related artifacts or placeholders.                                | Optional/unused in many setups. |

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


