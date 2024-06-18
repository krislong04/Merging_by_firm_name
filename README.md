# Merging_by_firm_name
This file contains code and instructions for merging firms by Organization Name for the KU Trade War Lab

Merging data by organization names is difficult because they often contain slight differences when entered into a dataset manually (ie."Firm Inc.", vs. "Firm Inc", vs. "Firm Incorporated.") I find that the fuzzy match function does not work well because the discrepancies between names are often abbreviations. Allowing a three character distance does not match "Company" to "Co.". This file contains code for an alternate strategy, which involves using regex expressions to create a key column that has the organization names stripped of these common differereces but distinct enough to match. 
