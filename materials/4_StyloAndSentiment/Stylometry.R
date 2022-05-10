# This is an R script file, created by Simone
# Everything written after an hashtag is a comment
# Everything else is R code
# To activate the code, place the cursor on the corresponding line and press Ctrl+Enter
# (the command will be automatically copy/pasted into the console)

# before everything starts: check the working directory!

# required packages:
# install.packages("stylo")

# call the "stylo" library
library(stylo)

### 1. Delta Analysis

# Stylo works by default on the files in the "corpus" folder inside the working directory
# if you are not there, it will ask you to reach that folder
# HOWEVER, it is always good practice to define the working directory from the beginning
# it can be done via the menu "Session" -> "Set Working Directory" -> "Choose Working Directory"
# in the menu, you will have to browse to the folder that contains the "corpus" folder (NOT to the "corpus" folder itself!)

# to use stylo, write this very simple command:
stylo()
# it has a user interface, so (for simple experiments) it does not require coding

# in the first panel (Input & Language), select: "plain text", "English (ALL)", and "Native encoding"
# Try different experiments:
# 100MFW min and max, 0 increment (features), CA with Classic and Cosine Delta (statistics)
# 2000MFW min and max, 0 increment (features), CA with Classic and Cosine Delta (statistics)
# 200-2000MFW, 200 increment (features), BCT with Classic and Cosine Delta (statistics)

# try also sampling, to see to which is the minimum amount of text for Delta to work 
# sampling: random; sample size: 5000
# sampling: random; sample size: 2000
# sampling: random; sample size: 1000
# sampling: random; sample size: 500

# also, note that each analysis has generated a .csv file that can be opened with Gephi (for network analysis)

# 2. Zeta analysis
# Inside stylo, the Zeta analysis is performed by the "oppose" function
# Oppose works by default on the files in the "primary_set", "secondary set" (and eventually "test_set") folders inside the working directory
# if you are not there, it will ask you to reach that folder

# to use oppose, call the function like that:
oppose()
