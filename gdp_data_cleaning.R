library(tidyverse)
library(janitor)
library(stringr)

dir()
dir(path= "GDP Data")


"GDP Data/NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
  read_csv() ->ap_df
view(ap_df)


ap_df %>% pull(Item) %>% unique()

"NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
  str_split("-") %>% 
  unlist()-> state_name_vector

state_name_vector[2]->st_name

ap_df %>%
  slice(-c(7,11,27:33)) %>% 
  pivot_longer(-c(1,2), names_to = "year", values_to = "gsdp") %>% 
  clean_names() %>% 
  select(-1) %>% 
  mutate(state= st_name)->state_df %>% view()
  

list.files("GDP Data/") 



## from "GDP Data" folder, exclude GSDP.csv & take only NAD files

##step 1
dir(path= "GDP Data",
    pattern = "NAD")->state_files
state_files  

##step 2
# Extract state names from file name


for (i in state_files){
  print(paste0("File name:", i))
i %>% 
  str_split("-") %>% 
  unlist()-> state_name_vector

state_name_vector[2]->st_name

print(paste0("state name:", i))

paste0("GDP Data/", i) %>% 
  read_csv()->st_df1
st_df1 %>% 
  slice(-c(7,11,27:33)) %>% 
  pivot_longer(-c(1,2), names_to = "year", values_to = "gsdp") %>% 
  clean_names() %>% 
  select(-1) %>% 
  mutate(state= st_name)->state_df 
print(state_df)
}

##step 4
#read all csv files 

tempdf<-tibble()

for (i in state_files){
  print(paste0("File name:", i))
  i %>% 
    str_split("-") %>% 
    unlist()-> state_name_vector
  
  state_name_vector[2]->st_name
  
  print(paste0("state name:", i))
  
  paste0("GDP Data/", i) %>% 
    read_csv()->st_df1
  st_df1 %>% 
    slice(-c(7,11,27:33)) %>% 
    pivot_longer(-c(1,2), names_to = "year", values_to = "gsdp") %>% 
    clean_names() %>% 
    select(-1) %>% 
    mutate(state= st_name)->state_df 
  print(state_df)
  bind_rows(tempdf, state_df)->tempdf
}

tempdf->final_statewise_gsdp

#step5===
#save final_statewise_gsdp in csv

final_statewise_gsdp %>% 
  write_csv("final_statewise_gsdp.csv")


