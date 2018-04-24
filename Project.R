install.packages("splitstackshape")
library("splitstackshape")

#Download dataset
PRAMS2011<-read.csv("/Users/laeti/OneDrive/Jr/Spring/USD/PRAMStat_2011.csv")

#Keep useful variables
PRAMS_var<-PRAMS2011[c(2,6,8,9,11,17,18,19)]
PRAMS_morbidity <- subset(PRAMS_var, (Question=="After your baby was born  was he or she put in an intensive care unit?"|Question=="The baby's weight  classified as low birth weight (LBW) if the weight was less than or equal to 2500 grams or normal birth weight (NBW) if the weight was greater than 2500 grams"|Question=="Indicator of infant currently alive"))
PRAMS_breakout <- subset(PRAMS_morbidity, (Break_Out_Category=="Smoked 3 months before Pregnancy"|Break_Out_Category=="Smoked last 3 months of Pregnancy"))

#Separate by variable
ICU_3B <- na.omit(subset(PRAMS_breakout, (Question=="After your baby was born  was he or she put in an intensive care unit?"&Break_Out_Category=="Smoked 3 months before Pregnancy"), select=c(LocationAbbr,Response,Sample_Size,Break_Out)))
ICU_3L <- na.omit(subset(PRAMS_breakout, (Question=="After your baby was born  was he or she put in an intensive care unit?"&Break_Out_Category=="Smoked last 3 months of Pregnancy"), select=c(LocationAbbr,Response,Sample_Size,Break_Out))) 

#change variable names too, then merge tables

BW_3B <- na.omit(subset(PRAMS_breakout, (Question=="The baby's weight  classified as low birth weight (LBW) if the weight was less than or equal to 2500 grams or normal birth weight (NBW) if the weight was greater than 2500 grams"&Break_Out_Category=="Smoked 3 months before Pregnancy"), select=c(LocationAbbr,Response,Sample_Size,Break_Out)))
BW_3L <-na.omit(subset(PRAMS_breakout, (Question=="The baby's weight  classified as low birth weight (LBW) if the weight was less than or equal to 2500 grams or normal birth weight (NBW) if the weight was greater than 2500 grams"&Break_Out_Category=="Smoked last 3 months of Pregnancy"), select=c(LocationAbbr,Response,Sample_Size,Break_Out)))
  
Mortality_3B <-
Mortality_3L <-

#By ICU
missing_ICUb3 <- subset(PRAMS_breakout, (Question=="After your baby was born  was he or she put in an intensive care unit?"&Break_Out==""), select=c(LocationAbbr,Data_Value))

#By birth weight
missing_BWb3 <- subset(PRAMS_breakout, (Question=="The baby's weight  classified as low birth weight (LBW) if the weight was less than or equal to 2500 grams or normal birth weight (NBW) if the weight was greater than 2500 grams"&Break_Out_Category=="Smoked 3 months before Pregnancy"&Break_Out==""), select=c(LocationAbbr,Data_Value))
missing_BWl3 <- subset(PRAMS_breakout, (Question=="The baby's weight  classified as low birth weight (LBW) if the weight was less than or equal to 2500 grams or normal birth weight (NBW) if the weight was greater than 2500 grams"&Break_Out_Category=="Smoked last 3 months of Pregnancy"&Break_Out==""), select=c(LocationAbbr,Data_Value))

#By pregnancy outcome, whether still alive 
missing_aliveb3 <- subset(PRAMS_breakout, (Question=="Indicator of infant currently alive"&Break_Out_Category=="Smoked 3 months before Pregnancy"&Break_Out==""), select=c(LocationAbbr,Data_Value))
missing_alivel3 <- subset(PRAMS_breakout, (Question=="Indicator of infant currently alive"&Break_Out_Category=="Smoked last 3 months of Pregnancy"&Break_Out==""), select=c(LocationAbbr,Data_Value))

missing <-merge(missing_ICUb3,missing_BWb3,id=LocationAbbr,all=TRUE)

#15618 In the 3 months before you got pregnant how many cigarettes did you smoke on an average day? None, < 1/day, 1-5/day, 6-10/day, 11-20/day, 21-40/day, 41+/day 
#Variables
#Topic Morbidity - Infant
#After born, baby put in ICU?
#The baby's weight classified as LBW
#Break out: Smoked 3 months before pregnancy, smoked last 3 months of pregnancy