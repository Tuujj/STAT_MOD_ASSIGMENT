# Analysis of Continuous Data – Project (MARQUE cohort)

Open `STAT_MOD_ASSIGMENT.Rproj` in RStudio.

## Folders

| Folder | What's in it |
|---|---|
| `data/` | The original data. Don't edit these. `ProjectData_2324.rds` is the dataset we use. |
| `docs/` | Assignment, protocol, technical notes, data dictionary. |
| `R/` | Analysis scripts **and the files they save** (`train.rds`, `test.rds`, `m_final.rds`, `results.rds`). |
| `reports/` | R Markdown reports **and their knitted PDF/HTML**. |

## Run order

1. `R/01_data_split.R`: 80/20 train/test split (seed 2026).
2. `R/02_model_training.R`: crude, main-effects and interaction models.
3. Knit `reports/descriptive_report.Rmd`.

Or run everything at once with `source("run_all.R")`.
