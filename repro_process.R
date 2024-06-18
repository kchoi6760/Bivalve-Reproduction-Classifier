library(dplyr)
library(tidyr)
library(readxl)
library(data.table)
library(here)
library(ggplot2)

families<-read.csv(here("data","families.csv"))%>%
  select(query,family)%>%
  rename(Species = query)
repro<-read.csv(here("data","reprodata.csv"))%>%
  left_join(families,by="Species")%>%
  mutate(SiteID = factor(SiteID),
         LatMin = ifelse(LatDeg<0,LatMin*(-1),LatMin),
         LongMin = ifelse(LongDeg<0,LongMin*(-1),LongMin),
         Longitude = LongDeg + LongMin/60,
         Latitude = LatDeg + LatMin/60)%>%
  select(-c(LatMin,LongMin,LatDeg,LongDeg,X))%>%
  mutate_at(5:13,
         .funs = function(x) x /12
    )

northern<-repro %>%
  filter(Latitude>=0)
southern<-repro%>%
  filter(Latitude<0)%>%
  mutate_at(5:13,
            .funs = function(x) x + 0.5
  )%>%
  mutate_at(5:13, ~ ifelse(. > 1, . - 1, .))
repro<-bind_rows(northern,southern)

setwd(here("data","environment data","chl"))
files<- list.files(pattern = ".csv")
chl<-Map(cbind, lapply(files, data.table::fread, sep=",",header=FALSE), filename = files)%>%
  rbindlist(fill=TRUE)%>%
  rename(time = V1,
         chla.ugL = V2,
         SiteID = filename)%>%
  mutate(SiteID = gsub("chl.csv","",SiteID))

setwd(here("data","environment data","sal"))
files<- list.files(pattern = ".csv")
sal<-Map(cbind, lapply(files, data.table::fread, sep=",",header=FALSE), filename = files)%>%
  rbindlist(fill=TRUE)%>%
  rename(time = V1,
         salinity.PSU = V2,
         SiteID = filename)%>%
  mutate(SiteID = gsub("sal.csv","",SiteID))

setwd(here("data","environment data","temp"))
files<- list.files(pattern = ".csv")
temp<-Map(cbind, lapply(files, data.table::fread, sep=",",header=FALSE), filename = files)%>%
  rbindlist(fill=TRUE)%>%
  rename(time = V1,
         salinity.PSU = V2,
         SiteID = filename)%>%
  mutate(SiteID = gsub(".csv","",SiteID))

repro %>%
  select(spawnstart,spawnend,peak1)%>%
  pivot_longer(cols = c(spawnstart,spawnend,peak1),names_to = "event")%>%
  mutate(event = factor(event,levels=c("spawnstart","peak1","spawnend")))%>%
  ggplot()+
  geom_histogram(aes(value),binwidth = 1/12)+
  xlab("Time of year of event")+
  facet_grid(event~.)+
  theme_bw(base_size = 16)

repro %>%
  select(spawnstart2,spawnend2,peak2)%>%
  pivot_longer(cols = c(spawnstart2,spawnend2,peak2),names_to = "event")%>%
  mutate(event = factor(event,levels=c("spawnstart2","peak2","spawnend2")))%>%
  ggplot()+
  geom_histogram(aes(value),binwidth = 1/12)+
  xlab("Time of year of event")+
  facet_grid(event~.)+
  theme_bw(base_size = 16)

repro %>%
  select(spawnstart3,spawnend3,peak3)%>%
  pivot_longer(cols = c(spawnstart3,spawnend3,peak3),names_to = "event")%>%
  mutate(event = factor(event,levels=c("spawnstart3","peak3","spawnend3")))%>%
  ggplot()+
  geom_histogram(aes(value),binwidth = 1/12)+
  xlab("Time of year of event")+
  facet_grid(event~.)+
  theme_bw(base_size = 16)


