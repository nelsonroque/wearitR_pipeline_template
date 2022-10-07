devtools::install_github("nelsonroque/m2c2R", force=T) 
library(m2c2R) 
lsf.str("package:m2c2R")

# score and summarise data 
files_in_zip <- list.files('data/')
files_in_zip

# ==============================================================================

# STEP 4) READ ALL FILES ----- 

# get filename that matches pattern for each task filename ('Symbol-Search') -----
fn_cogtask_dotmemory <- files_in_zip[grepl("dotmemory_", files_in_zip)]
fn_cogtask_symbolsearch <- files_in_zip[grepl("symbolsearch_", files_in_zip)]
fn_cogtask_shoppinglist <- files_in_zip[grepl("shoppinglist_", files_in_zip)]
fn_cogtask_stroop <- files_in_zip[grepl("stroop_", files_in_zip)]

# ==============================================================================

# read in raw cognitive data and get distinct records ----

raw_cogtask_dotmemory <- m2c2R::read_m2c2_local(fn_cogtask_dotmemory , na=".") %>% distinct()
raw_cogtask_symbolsearch <- m2c2R::read_m2c2_local(fn_cogtask_symbolsearch , na=".") %>% distinct()
raw_cogtask_shoppinglist <- m2c2R::read_m2c2_local(fn_cogtask_shoppinglist , na=".") %>% distinct()
raw_cogtask_stroop <- m2c2R::read_m2c2_local(fn_cogtask_stroop , na=".") %>% distinct()

# ==============================================================================

# score trial-level data
scored_cogtask_dotmemory <- m2c2R::score_dot_memory(raw_cogtask_dotmemory)
scored_cogtask_symbolsearch <- m2c2R::score_symbol_search(raw_cogtask_symbolsearch)
scored_cogtask_shoppinglist <- m2c2R::score_shopping_list(raw_cogtask_shoppinglist)
scored_cogtask_stroop <- m2c2R::score_stroop(raw_cogtask_stroop)

# ==============================================================================

# produce aggregates at `participant_id` level
summary_cogtask_dotmemory_person <- m2c2R::summary_dot_memory(scored_cogtask_dotmemory, group_var = c("participant_id"))
summary_cogtask_symbolsearch_person <- m2c2R::summary_symbol_search(scored_cogtask_symbolsearch, group_var = c("participant_id"))
summary_cogtask_shoppinglist_person <- m2c2R::summary_shopping_list(scored_cogtask_shoppinglist, group_var = c("participant_id"))
summary_cogtask_stroop_person <- m2c2R::summary_stroop(scored_cogtask_stroop, group_var = c("participant_id"))

# ==============================================================================

# produce aggregates at `participant_id x wearit_uuid` level

summary_cogtask_dotmemory_personsession <- m2c2R::summary_dot_memory(scored_cogtask_dotmemory, group_var = c("participant_id", "wearit_uuid"))
summary_cogtask_symbolsearch_personsession <- m2c2R::summary_symbol_search(scored_cogtask_symbolsearch, group_var = c("participant_id", "wearit_uuid"))
summary_cogtask_shoppinglist_personsession <- m2c2R::summary_shopping_list(scored_cogtask_shoppinglist, group_var = c("participant_id", "wearit_uuid"))
summary_cogtask_stroop_personsession <- m2c2R::summary_stroop(scored_cogtask_stroop, group_var = c("participant_id", "wearit_uuid"))

# ==============================================================================

# simple row validation (did scoring affect data structure?) ----
# e.g., testing_scored and testing_maintask_filter_edshould have the same number of rows
nrow(scored_cogtask_dotmemory) == nrow(raw_cogtask_dotmemory)
nrow(scored_cogtask_symbolsearch) == nrow(raw_cogtask_symbolsearch)
nrow(scored_cogtask_shoppinglist) == nrow(raw_cogtask_shoppinglist)
nrow(scored_cogtask_stroop) == nrow(raw_cogtask_stroop)

# ==============================================================================

# STEP 7) EXPORT FILES ----

if(!dir.exists("output")) {
  dir.create("output")
  setwd("output")
} else {
  setwd("output")
}

# ==============================================================================

# export study data -----


m2c2R::qcsv(raw_cogtask_dotmemory)
m2c2R::qcsv(raw_cogtask_symbolsearch)
m2c2R::qcsv(raw_cogtask_shoppinglist)
m2c2R::qcsv(raw_cogtask_stroop)

m2c2R::qcsv(scored_cogtask_dotmemory)
m2c2R::qcsv(scored_cogtask_symbolsearch)
m2c2R::qcsv(scored_cogtask_shoppinglist)
m2c2R::qcsv(scored_cogtask_stroop)

m2c2R::qcsv(summary_cogtask_dotmemory_person)
m2c2R::qcsv(summary_cogtask_symbolsearch_person)
m2c2R::qcsv(summary_cogtask_shoppinglist_person)
m2c2R::qcsv(summary_cogtask_stroop_person)

m2c2R::qcsv(summary_cogtask_dotmemory_personsession)
m2c2R::qcsv(summary_cogtask_symbolsearch_personsession)
m2c2R::qcsv(summary_cogtask_shoppinglist_personsession)
m2c2R::qcsv(summary_cogtask_stroop_personsession)

