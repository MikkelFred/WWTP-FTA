devtools::install_github("CarlesCG/FaultTree")

library(FaultTree)


#Top event(ID = 1)
wwtp<-ftree.make(type="or", name="Failure in", name2="BOD standard")

#Failure in areation tank event(ID = 2)
wwtp<-addProbability(wwtp, at=1, prob=0.1, name="Failure in", name2="areation tank")

#Fiailure in secondary sedimentation event(ID = 3)
wwtp<-addLogic(wwtp, at=1, type="or", name="Failure in", name2="secondary sedimentation")

#Weir perfomance event(ID = 4)
wwtp<-addLogic(wwtp, at=3, type="or", name="Weir", name2="perfomance")
wwtp<-addProbability(wwtp, at=4, prob=0.1, name="Equipment", name2="failure")
wwtp<-addProbability(wwtp, at=4, prob=0.9, name="Design", name2="problem")

# Hydralic shock and load event(ID = 5)
wwtp<-addLogic(wwtp, at=3, type="or", name="Hydralic shock ", name2="and load")
wwtp<-addProbability(wwtp, at=7, prob=0.1, name="High infiltration", name2="flow")
wwtp<-addProbability(wwtp, at=7, prob=0.9, name="Operator", name2="error")

# Short circuting event(ID = 10)
wwtp<-addLogic(wwtp, at=3, type="or", name="Short circuting")
wwtp<-addProbability(wwtp, at=10, prob=0.1, name="Equipment", name2="failure")
wwtp<-addProbability(wwtp, at=10, prob=0.9, name="Design", name2="problem")

# Rising event(ID = 13)
wwtp<-addLogic(wwtp, at=3, type="and", name="Rising")
wwtp<-addProbability(wwtp, at=13, prob=0.1, name="High", name2="retention time")
#wwtp<-addLogic(wwtp, at=13, type="inhibit", name="High", name2="retention time")
#wwtp<-addProbability(wwtp, at=14, prob=0.9, name="Design", name2="problem")
wwtp<-addLogic(wwtp, at=13, type="and", name="Reduce sludge", name2="disposal rate")
wwtp<-addProbability(wwtp, at=15, prob=0.1, name="Sludge pump", name2="malfunction")
wwtp<-addProbability(wwtp, at=15, prob=0.9, name="Operator", name2="absence")

# Bulking (ID = 18)
wwtp<-addLogic(wwtp, at=3, type="and", name="Reduce sludge", name2="disposal rate")
wwtp<-addProbability(wwtp, at=18, prob=0.1, name="No selector")
wwtp<-addProbability(wwtp, at=18, prob=0.9, name="Completely mix", name2="regime")

#Increase of sludge blanket thickness (ID = 21)
wwtp<-addLogic(wwtp, at=3, type="or", name="Increase of sludge", name2 = "blanket thickness")
wwtp<-addProbability(wwtp, at=21, prob=0.1, name="Eqiupment", name2="failure")

wwtp<-addLogic(wwtp, at=21, type="and", name="Reduce sludge", name2="disposal rate")
wwtp<-addProbability(wwtp, at=23, prob=0.1, name="Sludge pump", name2="malfunction")
wwtp<-addProbability(wwtp, at=23, prob=0.9, name="Operator", name2="absence")

ftree2html(wwtp, write_file=TRUE) 
browseURL("wwtp.html")

