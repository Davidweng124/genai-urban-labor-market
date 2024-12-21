//Stata comes with example datasets	
	help dta_examples
	sysuse auto.dta
//Descriptive statistics	
	summarize
//Simple regression
	regress price mpg rep78 headroom trunk weight length turn displacement gear_ratio foregin
	