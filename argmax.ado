program argmax, rclass
	syntax varname(numeric) [if] [in] , ///
		[ by(varlist) eval(varlist) ]

	
	// check that -eval- varlist is not too big for matsize (unlikely)
	if ("`eval'" != "") {
		local neval = wordcout("`eval'")
		if (`neval' + 1 > c(matsize)) {
			noi di as error "too many variables in -eval- for current matsize"
			exit 103
		}
	}
	
	marksample touse
	
	// create temporary grouping variable for -by- variables
	tempvar groupvar
	if ("`by'" == "") {
		qui gen byte `groupvar' = 1
	}
	else {
		qui egen `groupvar' = group(`by')
	}
	
	tempname matname
	
	mata: input_maxes("`varlist'", "`groupvar'", "`touse'", "`matname'")
	
	// put in values of -eval- varlist, if any
	if ("`eval'" != "") {
		local nvars = wordcount("`eval'")
		local nrows = rowsof(`matname')
		matrix `matname' = (`matname' , J(`nrows', `nvars', .))
		forv j=1(1)`nvars' {
			local var = word("`eval'", `j')
			forv i=1(1)`nrows' {
				local value = `var'[`matname'[`i',1]]
				matrix `matname'[`i', `j'+1] = `value'
			}
		}
		matrix colnames `matname' = obs_num `eval'
	}
	else {
		matrix colnames `matname' = obs_num
	}
	
	return clear
	return matrix values = `matname'
	
end

mata
	void input_maxes(string scalar input_name,
	                string scalar byvar_name,
                    string scalar touse_name,
	                string scalar matname)
	{
		real colvector input
		real colvector byvar
		
		real scalar N
		real scalar group
		real scalar n_groups
		real colvector group_maxes, group_args
		real colvector seen
		
		st_view(input, ., input_name, touse_name)
		st_view(byvar, ., byvar_name, touse_name)
	
		N = length(input)
		n_groups = colmax(byvar)
		group_maxes = J(n_groups, 1, .)
		group_args = J(n_groups, 1, .)
		seen = J(n_groups, 1, 0)
		
		for (i = 1; i <= N; i++) {
			group = byvar[i]
			if (!seen[group]) {
				group_maxes[group] = input[i]
				group_args[group] = i
				seen[group] = 1
			}
			else if (input[i] > group_maxes[group]) {
				group_maxes[group] = input[i]
				group_args[group] = i
			}
		}
		st_matrix(matname, group_args)
	}
end
