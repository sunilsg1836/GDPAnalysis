library(tidyverse)
library(janitor)

"final_statewise_gsdp.csv" %>% 
  read.csv() %>% 
  rename("sector" = "item")->statewise_gsdp

statewise_gsdp %>% 
  pull(sector) %>% 
  unique()


#questions
#q1. For every financial year, which sector has performed well
#q2. For every financial year, which sector has performed least
#q3. For every financial year, which state has performed well
#q4. For every financial year, which state has performed least
#q5. Top 5 performing states in manufacturing 
#q6. Top 5 performing states in construction
#q7. For FY2016-17, for every state get top performing sector
#q8. For FY2016-17, for every state get top 5 performing sector
#q9. How many states are performing well in Manufacturing,(if Manufacturing is on top3)
#q10.What is the GROSS GSDP of Karnataka for all Financial years


##solutions


#q1. For every financial year, which sector has performed well
view(statewise_gsdp)

statewise_gsdp %>%
  group_by(year, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE)) ->df


df%>% 
  group_by(year) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1)
  
#q2. For every financial year, which sector has performed least  
  
statewise_gsdp %>%
  group_by(year, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE)) ->df


df%>% 
  group_by(year) %>% 
  arrange((total_gsdp)) %>% 
  slice(1)  

#q3. For every financial year, which state has performed well

statewise_gsdp %>%
  group_by(year, sector, state) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE)) ->df


df%>% 
  group_by(year) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1)  

#q4. For every financial year, which state has performed least

statewise_gsdp %>%
  group_by(year, sector, state) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE)) ->df


df%>% 
  group_by(year) %>% 
  arrange((total_gsdp)) %>% 
  slice(1)

#q5. Top 5 performing states in manufacturing

statewise_gsdp %>%
  filter(sector=="Manufacturing") %>% 
  group_by(state) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE)) ->df


df%>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:5)

#q6. Top 5 performing states in construction

statewise_gsdp %>%
  filter(sector=="Construction") %>% 
  group_by(state) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE)) ->df


df%>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:5)

#q7. For FY2016-17, for every state get top performing sector

statewise_gsdp %>%
  filter(year=="2016-17") %>% 
  group_by(state, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE))->df


df%>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1)

#q8. For FY2016-17, for every state get top 5 performing sector

statewise_gsdp %>%
  filter(year=="2016-17") %>% 
  group_by(state, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE))->df


df%>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:5)

#q9. How many states are performing well in Manufacturing,(if Manufacturing is on top3)

statewise_gsdp %>%
  group_by(state, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm =TRUE))->df
df%>% 
  group_by(state) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:3) %>% 
  filter(sector=="Manufacturing")->no_of_states_in_top3_manufacturing

nrow(no_of_states_in_top3_manufacturing)


#10. what is the gross gsdp of karnataka for all financial years

statewise_gsdp %>% 
  filter(state == "Karnataka") %>% 
  group_by(year) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm = T))



#q11. For Karnataka state sector wise percentage contribution in 2015-16

statewise_gsdp %>% 
  filter(year=="2015-16", state == "Karnataka") %>% 
  group_by(year) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm = T)) %>% 
  pull(total_gsdp) -> total

#descending order 
statewise_gsdp %>% 
  filter(year=="2015-16", state == "Karnataka") %>% 
  group_by(sector) %>%
  summarise(percentage = sum((gsdp/total)*100, na.rm = T)) %>% 
  arrange(desc(percentage)) %>% view()

#check whether total percentage adding to 100 
statewise_gsdp %>% 
  filter(year=="2015-16", state == "Karnataka") %>% 
  group_by(sector) %>%
  summarise(percentage = sum((gsdp/total)*100, na.rm = T)) %>% pull(percentage) %>% sum()  






