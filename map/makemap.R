#make map for website

library("terra")

continents <- vect("map/shapefiles/World_Continents/World_Continents.shp")
conts<-subset(continents, continents$CONTINENT!="Europe" & continents$CONTINENT!="Asia")
              
countries <- vect("G:/Shared drives/2022 FIRE-SA/Team Archive/Website/map data/IPUMSI_world_release2020/world_countries_2020.shp")

DRC <- subset(countries, countries$CNTRY_NAME=="Congo, DRC")
DRC$legend<-"Artisanal Cobalt Mines"

states <- vect("map/shapefiles/cb_2018_us_state_20m/cb_2018_us_state_20m.shp")

us<-subset(states, states$NAME!="Hawaii" & states$NAME!="Alaska" & states$NAME!="Puerto Rico")
usagg<-aggregate(us)
usagg$legend<-"Corporate ESG Reports"

bay<-subset(states, 
            states$NAME=="Maryland" | 
              states$NAME=="District of Columbia" |
              states$NAME=="Virginia" |
              states$NAME=="Delaware")

bay$legend<-"Plastic Bans & Water Pollution"

fl <- subset(states, states$NAME=="Florida")

fl$legend<-"Citrus Canker"

cities <- vect("map/shapefiles/cb_2018_us_cbsa_20m/cb_2018_us_cbsa_20m.shp")

lr <- subset(cities, 
             cities$NAME == "Houston-The Woodlands-Sugar Land, TX" | 
               cities$NAME== "Phoenix-Mesa-Scottsdale, AZ" |
               cities$NAME== "Minneapolis-St. Paul-Bloomington, MN-WI" |
               cities$NAME== "Charlotte-Concord-Gastonia, NC-SC") 

lr$legend<-"Light Rails & Air Pollution"

pal<-c("#AD7231", "#FFCD00", "#e6e6e6", "#C8102E", "#2FA7D0")

box <- rbind(DRC, usagg, fl, lr, bay)

png('images/map.png', width = 1000, height = 500, units = "px")
plot(box, "legend", col=pal, border=F, axes=F, box=T,
     plg=list(title="Ongoing Projects", title.adj=0.1, title.cex=2.5,
              bty="o", box.col="white", cex=2, x=-25, y=50.15, box.lwd=10))
lines(conts, col="#7f7f7f", alpha=0.3)
dev.off()

