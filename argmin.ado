program argmin, rclass
	syntax varname(numeric) [if] [in] , ///
		[ by(varlist) eval(varlist) ]

		
	// check that -eval- varlist is not too big for matsize (unlikely)
	if ("`eval'" != "") {
		local neval = wordcount("`eval'")
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
		qui egen `groupvar' = group(`by') if !missing(`varlist') & `touse'
		qui replace `touse' = 0 if `groupvar' == .
	}
	
	tempname matname
	
	mata: find_mins("`varlist'", "`groupvar'", "`touse'", "`matname'")
	
	// put in values of -eval- varlist, if any
	if ("`eval'" != "") {
		local nvars = wordcount("`eval'")
		local nrows = rowsof(`matname')
		matrix `matname' = (`matname' , J(`nrows', `nvars', .))
		forv j=1(1)`nvars' {
			local var = word("`eval'", `j')
			forv i=1(1)`nrows' {
				local value = `var'[`matname'[`i',2]]
				matrix `matname'[`i', `j'+3] = `value'
			}
		}
	}
	matrix colnames `matname' = group obs_num `varlist' `eval'
	
	return clear
	return matrix values = `matname'
	
end

mata
	void find_mins(string scalar input_name,
	               string scalar byvar_name,
                   string scalar touse_name,
	               string scalar matname)
	{
		real colvector input
		real colvector byvar
		
		real scalar i, j, n
		real scalar N, group, n_groups
		real colvector group_mins, n_vals, all_vals, this_group
		pointer(real matrix) colvector group_vals
		real colvector seen
		
		st_view(input, ., input_name)
		st_view(byvar, ., byvar_name)
		st_view(touse, ., touse_name)
	
		N = length(input)
		n_groups = colmax(byvar)
		group_mins = J(n_groups, 1, .)
		group_vals = J(n_groups, 1, NULL)
		n_vals = J(n_groups, 1, .)
		seen = J(n_groups, 1, 0)
		
		for (i = 1; i <= N; i++) {
			if (!touse[i]) {
				continue
			}
			group = byvar[i]
			if (!seen[group]) {
				group_mins[group] = input[i]
				group_vals[group] = &(i, input[i])
				n_vals[group] = 1
				seen[group] = 1
			}
			else if (input[i] < group_mins[group]) {
				group_mins[group] = input[i]
				group_vals[group] = &(i, input[i])
				n_vals[group] = 1
			}
			else if (input[i] == group_mins[group]) {
				group_vals[group] = &(*(group_vals[group]) \ i, input[i])
				n_vals[group] = n_vals[group] + 1
			}
		}
		
		if (sum(n_vals) > strtoreal(st_macroexpand("`=c(matsize)'"))) {
			printf("{err}too many minima (%s) for ", strofreal(sum(n_vals))) 
			printf("current matsize (%s);\n", st_macroexpand("`=c(matsize)'"))
			printf("use {cmd}set matsize {err} to increase matsize\n")
			exit(908)
		}
		
		all_vals = J(sum(n_vals), 3, .)
		n = 0
		for (i = 1; i <= n_groups; i++) {
			this_group = *(group_vals[i])
			for (j = 1; j <= rows(this_group); j++) {
				n = n + 1
				all_vals[n, 1..3] = (i, this_group[j, 1..2])
			}
		}
		
		st_matrix(matname, all_vals)
	}
end
