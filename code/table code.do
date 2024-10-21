//Table 1
use $data\job_industry2018-2024.dta ,clear
	collapse (mean) exposure_dwa_beta ave_education ave_experience ave_wage, by(position_level1)
	reg exposure_dwa_beta ave_education 
	outreg2 using $output\table1.xls,replace
	reg exposure_dwa_beta ave_experience
	outreg2 using $output\table1.xls,append
	reg exposure_dwa_beta ave_wage
	outreg2 using $output\table1.xls,append
	reg exposure_dwa_beta ave_education ave_experience ave_wage
	outreg2 using $output\table1.xls,append
	

//Table 2 Panel A
	use $data\job_industry.dta ,clear
	
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	
	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[1]
	gen ln_indus=ln(industryvalue)
	
	
	reg rate exposure_dwa_beta ln_indus 
	outreg2 using $output\table2.xls,replace
	reg rate exposure_dwa_beta ln_indus if quarter==1
	outreg2 using $output\table2.xls,append
	reg rate exposure_dwa_beta ln_indus if quarter==2
	outreg2 using $output\table2.xls,append
	reg rate exposure_dwa_beta ln_indus if quarter==3
	outreg2 using $output\table2.xls,append
	reg rate exposure_dwa_beta ln_indus if quarter==4
	outreg2 using $output\table2.xls,append
	
//Table 2 Panel B	
	
	use $data\job_industry.dta ,clear
	gen quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[1]
	gen ln_indus=ln(industryvalue)
	
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023)
	outreg2 using $output\table2_iv.xls,replace
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==1
	outreg2 using $output\table2_iv.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==2
	outreg2 using $output\table2_iv.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==3
	outreg2 using $output\table2_iv.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==4
	outreg2 using $output\table2_iv.xls,append
	
// Table 3		
	use $data\index_city_monthly_prop.dta ,clear////non-public	
	gen chatgpt=1 if year>=2023
	replace chatgpt=0 if chatgpt==.
	gen expo_gpt=chatgpt* exposure_dwa_beta
	* avg. wage 
		reghdfe avg_wage_w2 exposure_dwa_beta expo_gpt, ///
		absorb(time citycode) vce(cluster citycode)
		
	* regression stats
		local num_obs = e(N)
		local r2 = string(e(r2_a), "%6.3f")
	
	outreg2 using $outputs\table_ai_index_association_mix.xls, ///
		excel replace se bracket nocon noobs nor2 ///
		keep(exposure_dwa_beta expo_gpt) ///
		ctitle("Average wage") ///
		addtext("City Effect", "YES", "Year-week Fixed Effect", "YES", "Obs.", `num_obs', "Adjusted R-Squared", `r2')
		
* avg. supwage
	reghdfe avg_supwage_w2 exposure_dwa_beta expo_gpt, ///
		absorb(time citycode) vce(cluster citycode)
		
	* regression stats
		local num_obs = e(N)
		local r2 = string(e(r2_a), "%6.3f")
	
	outreg2 using $outputs\table_ai_index_association_mix.xls, ///
		excel append se bracket nocon noobs nor2 ///
		keep(exposure_dwa_beta expo_gpt) ///
		ctitle("Average maximum wage") ///
		addtext("City Effect", "YES", "Year-week Fixed Effect", "YES", "Obs.", `num_obs', "Adjusted R-Squared", `r2')
		
* avg. infwage
	reghdfe avg_infwage_w2 exposure_dwa_beta expo_gpt, ///
		absorb(time citycode) vce(cluster citycode)
		
	* regression stats
		local num_obs = e(N)
		local r2 = string(e(r2_a), "%6.3f")
	
	outreg2 using $outputs\table_ai_index_association_mix.xls, ///
		excel append se bracket nocon noobs nor2 ///
		keep(exposure_dwa_beta expo_gpt) ///
		ctitle("Average minimum wage") ///
		addtext("City Effect", "YES", "Year-week Fixed Effect", "YES", "Obs.", `num_obs', "Adjusted R-Squared", `r2')
	
	
* post_prop_edu2
	reghdfe post_prop_edu2 exposure_dwa_beta expo_gpt, ///
		absorb(time citycode) vce(cluster citycode)
		
	* regression stats
		local num_obs = e(N)
		local r2 = string(e(r2_a), "%6.3f")
	
	outreg2 using $outputs\table_ai_index_association_mix.xls, ///
		excel append se bracket nocon noobs nor2 ///
		keep(exposure_dwa_beta expo_gpt) ///
		ctitle("Proportion with a bachelor's degree or higher") ///
		addtext("City Effect", "YES", "Year-week Fixed Effect", "YES", "Obs.", `num_obs', "Adjusted R-Squared", `r2')
		
* post_prop_exp2
	reghdfe post_prop_exp2 exposure_dwa_beta expo_gpt, ///
		absorb(time citycode) vce(cluster citycode)
		
	* regression stats
		local num_obs = e(N)
		local r2 = string(e(r2_a), "%6.3f")
	
	outreg2 using $outputs\table_ai_index_association_mix.xls, ///
		excel append se bracket nocon noobs nor2 ///
		keep(exposure_dwa_beta expo_gpt) ///
		ctitle("Proportion with more than three years of experience") ///
		addtext("City Effect", "YES", "Year-week Fixed Effect", "YES", "Obs.", `num_obs', "Adjusted R-Squared", `r2')
		
//Supplementary 
	
///////Robustness check
////Ratio of Number of posts to 2022.08
	use $data\job_industry2022-2024, clear
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[8]
	gen ln_indus=ln(industryvalue)
	
	//reghdfe rate exposure_dwa_beta ln_indus, absorb(quarter )
	reg rate exposure_dwa_beta ln_indus if quarter>=1
	outreg2 using $output\table_robust.xls,replace
	reg rate exposure_dwa_beta  ln_indus if quarter==1
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus  if quarter==2
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus  if quarter==3
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus if quarter==4
	outreg2 using $output\table_robust.xls,append
	
		
//iv		
///total
	use $data\job_industry2022-2024, clear
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[8]
	gen ln_indus=ln(industryvalue)
	
	
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter>=1
	outreg2 using $output\table_iv_robust.xls,replace
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==1
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==2
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==3
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==4
	outreg2 using $output\table_iv_robust.xls,append
	
////Ratio of Number of posts to 2022.09
	use $data\job_industry2022-2024, clear
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[9]
	gen ln_indus=ln(industryvalue)
	
	//reghdfe rate exposure_dwa_beta ln_indus, absorb(quarter )
	reg rate exposure_dwa_beta ln_indus if quarter>=1
	outreg2 using $output\table_robust.xls,replace
	reg rate exposure_dwa_beta  ln_indus if quarter==1
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus  if quarter==2
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus  if quarter==3
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus if quarter==4
	outreg2 using $output\table_robust.xls,append
	
		
//iv		
///total
	use $data\job_industry2022-2024, clear
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[9]
	gen ln_indus=ln(industryvalue)
	
	
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter>=1
	outreg2 using $output\table_iv_robust.xls,replace
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==1
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==2
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==3
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==4
	outreg2 using $output\table_iv_robust.xls,append
	
//////deleting education and automobile production
///total
	use $data\job_industry2022-2024, clear
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	drop if position_level1=="教育/培训" | position_level1=="汽车制造"
	
	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[10]
	gen ln_indus=ln(industryvalue)
	
	
	reg rate exposure_dwa_beta ln_indus if quarter>=1
	outreg2 using $output\table_robust.xls,replace
	reg rate exposure_dwa_beta  ln_indus if quarter==1
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus  if quarter==2
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus  if quarter==3
	outreg2 using $output\table_robust.xls,append
	reg rate exposure_dwa_beta ln_indus if quarter==4
	outreg2 using $output\table_robust.xls,append
	
		
//iv		
///total
	use $data\job_industry2022-2024, clear
	gen quarter=0 if time==750 | time==751 | time==752 | time==753 
	replace quarter=1 if time==754 | time==755 | time==756 | time==757 
	replace  quarter=2 if time==758 | time==759 | time==760 | time==761 
	replace  quarter=3 if time==762 | time==763 | time==764 | time==765 
	replace  quarter=4 if time==766 | time==767 | time==768 | time==769 

	drop if position_level1=="教育/培训" | position_level1=="汽车制造"

	sort position_level1 time
	bysort position_level1: gen rate=num_post[_n]/num_post[10]
	gen ln_indus=ln(industryvalue)
	
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter>=1
	outreg2 using $output\table_iv_robust.xls,replace
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==1
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==2
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==3
	outreg2 using $output\table_iv_robust.xls,append
	ivreg rate  ln_indus (exposure_dwa_beta=lm_aioe_felten2023) if quarter==4
	outreg2 using $output\table_iv_robust.xls,append

	