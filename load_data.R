# Load Data
library(tidyverse)
main <- read.csv("ba_main.csv")
certs <- read.csv("ba_certs.csv")
skills <- read.csv("ba_skills.csv")
main <- main[,c("BGTJobId", "CleanTitle", "CanonTitle", "Specialty", "Employer", "SectorName", "City", "State", "County", "FIPSState", "FIPSCounty", "FIPS", "Lat", "Lon", "Degree", "MaxDegree", "Exp", "MaxExp", "MinSalary", "MaxSalary", "MinHrlySalary", "MaxHrlySalary", "PayFrequency", "SalaryType", "JobHours", "TaxTerm")]
# key BGTJobId
job <- merge(main, certs, by.x = "BGTJobId", by.y = "BGTJobId", all.x = TRUE, all.y = TRUE)
job <- merge(job, skills, by.x = "BGTJobId", by.y = "BGTJobId", all.x = TRUE, all.y = TRUE)

job <- filter(job, CanonTitle %in% c("Business Analyst","Management Analyst"))
save(job, file ="combined_data.rData")
