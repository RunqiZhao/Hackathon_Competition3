# Load Data
library(tidyverse)
main <- read.csv("ba_main.csv")
certs <- read.csv("ba_certs.csv")
skills <- read.csv("ba_skills.csv")
main <- main[,c("BGTJobId", "CleanTitle", "CanonTitle", "Specialty", "Employer", "SectorName", "City", "State", "County", "FIPSState", "FIPSCounty", "FIPS", "Lat", "Lon", "Degree", "MaxDegree", "Exp", "MaxExp", "MinSalary", "MaxSalary", "MinHrlySalary", "MaxHrlySalary", "PayFrequency", "SalaryType", "JobHours", "TaxTerm")]
main <- filter(main, CanonTitle %in% c("Business Analyst","Management Analyst"))

main[main == "na"] <- NA
# remove na in State
main <- filter(main, !is.na(State))

# key BGTJobId
job_cet <- merge(main, certs, by.x = "BGTJobId", by.y = "BGTJobId", all.x = TRUE, all.y = TRUE)
job_skill <- merge(main, skills, by.x = "BGTJobId", by.y = "BGTJobId", all.x = TRUE, all.y = TRUE)

save(job_cet, file ="job_cet.rData")
save(job_skill, file ="job_skill.rData")

# Index
main$certsIdx <- ifelse(main$BGTJobId %in% unique(certs$BGTJobId), 1, 0)
job <- main
# Add Certificate Index
job$CetfIndex <- ifelse(is.na(job$Degree) & is.na(job$MaxDegree) & !is.na(job$certsIdx), "C",
                        ifelse(job$Degree == "Bachelor's" & is.na(job$MaxDegree) & is.na(job$certsIdx), "A",
                               ifelse(job$Degree == "Master's" & is.na(job$MaxDegree) & is.na(job$certsIdx), "B",
                                      ifelse(job$Degree == "Bachelor's" & is.na(job$MaxDegree) & !is.na(job$certsIdx),"AC",
                                             ifelse(job$Degree == "Master's" & is.na(job$MaxDegree) & !is.na(job$certsIdx),"BC",
                                                    ifelse(job$Degree == "Bachelor's" & job$MaxDegree == "Master's" & is.na(job$certsIdx),"AB", NA))))))

save(job, file ="job.rData")
