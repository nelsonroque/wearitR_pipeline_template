# change to FALSE after initial package install -----
FIRST_RUN = TRUE

# install packages on first run ----
if(FIRST_RUN) {
    # list of packages required on machine if developing on this R Package ---
    packages_req_dev = c("rlist", "skimr", "tidyverse", "devtools") # optional: "dataReporter"

    # install them ---
    install.packages(packages_req_dev)
}

# install latest package version ----
devtools::install_github("nelsonroque/wearitR", force=T)

# load lib ----
library(wearitR)

# `data_path` = directory relative to the RProj (in this case, `data`)
# `config_path` = file path to JSON configuration file (in this case, `config.json`)
config_file = "config.json"
data_path = "data"
study_config = read_studyconfig(config_file)
run_pipeline_survey(data_path, config_file, use_labels = T, drop_deprecated = T, expected_headers=3)
run_pipeline_cogdata(data_path, config_file)


# run the scoring script for any cognitive assessment
# NOTE: need to edit `m2c2R_scoring_pipeline.R` for the specific cog tasks in the protocol
#source("m2c2R_scoring_pipeline.R")
