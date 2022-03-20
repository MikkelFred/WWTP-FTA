devtools::install_github("CarlesCG/FaultTree")

library(FaultTree)


#Top event(N, ID = 1)
wwtp<-ftree.make(type="or", name="Failure in", name2="BOD standard")

#Failure in areation tank event(A2, ID = 2)
wwtp<-addProbability(wwtp, at=1, prob=0.00001, name="Failure in", name2="areation tank")

#Failure in secondary sedimentation event(A1, ID = 3)
wwtp<-addLogic(wwtp, at=1, type="or", name="Failure in", name2="secondary sedimentation")

#Weir perfomance event(B6, ID = 4)
wwtp<-addLogic(wwtp, at=3, type="or", name="Weir", name2="perfomance")
wwtp<-addProbability(wwtp, at=4, prob=0.02, name="Equipment", name2="failure")
wwtp<-addProbability(wwtp, at=4, prob=0.03, name="Design", name2="problem")

# Hydralic shock and load event(B5, ID = 5)
wwtp<-addLogic(wwtp, at=3, type="or", name="Hydralic shock ", name2="and load")
wwtp<-addProbability(wwtp, at=7, prob=0.045, name="High infiltration", name2="flow")
wwtp<-addProbability(wwtp, at=7, prob=0.15, name="Operator", name2="error")

# Short circuting event(B4, ID = 10)
wwtp<-addLogic(wwtp, at=3, type="or", name="Short circuting")
wwtp<-addProbability(wwtp, at=10, prob=0.02, name="Equipment", name2="failure")
wwtp<-addProbability(wwtp, at=10, prob=0.03, name="Design", name2="problem")

# Rising event(B3, ID = 13)
wwtp<-addLogic(wwtp, at=3, type="and", name="Rising")
wwtp<-addProbability(wwtp, at=13, prob=0.03, name="High", name2="retention time")
wwtp<-addLogic(wwtp, at=13, type="and", name="Reduce sludge", name2="disposal rate")
wwtp<-addProbability(wwtp, at=15, prob=0.027, name="Sludge pump", name2="malfunction")
wwtp<-addProbability(wwtp, at=15, prob=0.5, name="Operator", name2="absence")

# Bulking (B2, ID = 18)
wwtp<-addLogic(wwtp, at=3, type="and", name="Reduce sludge", name2="disposal rate")
wwtp<-addProbability(wwtp, at=18, prob=0.03, name="No selector")
wwtp<-addProbability(wwtp, at=18, prob=0.03, name="Completely mix", name2="regime")

#Increase of sludge blanket thickness (B1, ID = 21)
wwtp<-addLogic(wwtp, at=3, type="or", name="Increase of sludge", name2 = "blanket thickness")
wwtp<-addProbability(wwtp, at=21, prob=0.02, name="Eqiupment", name2="failure")
wwtp<-addLogic(wwtp, at=21, type="and", name="Reduce sludge", name2="disposal rate")
wwtp<-addProbability(wwtp, at=23, prob=0.027, name="Sludge pump", name2="malfunction")
wwtp<-addProbability(wwtp, at=23, prob=0.5, name="Operator", name2="absence")

ftree2html(wwtp, write_file=TRUE) 
browseURL("wwtp.html")

