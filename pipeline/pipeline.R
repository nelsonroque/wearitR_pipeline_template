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
run_pipeline(data_path = "data", config_path = "config.json", use_labels=T)