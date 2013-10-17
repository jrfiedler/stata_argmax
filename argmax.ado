program argmax, rclass
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
	
	mata: find_maxes("`varlist'", "`groupvar'", "`touse'", ///
	                 "`matname'", "`by'", "`eval'")
	
	matrix colnames `matname' = obs_num `varlist' `by' `eval'
	
	return clear
	return matrix values = `matname'
	
end

mata
	void find_maxes(string scalar input_name,
	                string scalar byvar_name,
                    string scalar touse_name,
	                string scalar matname,
	                string scalar original_byvar_names,
	                string scalar eval_names)
	{
		real colvector input
		real colvector byvar
		real matrix original_byvars, eval, this_group
		
		real scalar i, n, n_rows
		real scalar N, group, n_groups
		real colvector group_maxes, n_vals, all_vals
		real colvector seen
		pointer(real matrix) colvector group_vals
		
		st_view(input, ., input_name)
		st_view(byvar, ., byvar_name)
		st_view(touse, ., touse_name)
		
		N = length(input)
		if (original_byvar_names != "") {
			st_view(original_byvars, ., original_byvar_names)
		}
		else {
			original_byvars = J(N, 0, .)
		}
		if (eval_names != "") {
			st_view(eval, ., eval_names)
		}
		else {
			eval = J(N, 0, .)
		}
	
		n_groups = colmax(byvar)
		group_maxes = J(n_groups, 1, .)
		group_vals = J(n_groups, 1, NULL)
		n_vals = J(n_groups, 1, .)
		seen = J(n_groups, 1, 0)
		
		for (i = 1; i <= N; i++) {
			if (!touse[i]) {
				continue
			}
			group = byvar[i]
			if (!seen[group]) {
				group_maxes[group] = input[i]
				group_vals[group] = &(i, input[i], original_byvars[i, .], eval[i, .])
				n_vals[group] = 1
				seen[group] = 1
			}
			else if (input[i] > group_maxes[group]) {
				group_maxes[group] = input[i]
				group_vals[group] = &(i, input[i], original_byvars[i, .], eval[i, .])
				n_vals[group] = 1
			}
			else if (input[i] == group_maxes[group]) {
				group_vals[group] = &(*(group_vals[group]) \ 
				                      i, input[i], original_byvars[i, .], eval[i, .])
				n_vals[group] = n_vals[group] + 1
			}
		}
		
		if (sum(n_vals) > strtoreal(st_macroexpand("`=c(matsize)'"))) {
			printf("{err}too many minima (%s) for ", strofreal(sum(n_vals))) 
			printf("current matsize (%s);\n", st_macroexpand("`=c(matsize)'"))
			printf("use {cmd}set matsize {err} to increase matsize\n")
			exit(908)
		}
		
		all_vals = J(sum(n_vals), 2 + cols(original_byvars) + cols(eval), .)
		n = 1
		for (i = 1; i <= n_groups; i++) {
			this_group = *group_vals[i]
			n_rows = rows(this_group)
			all_vals[(n::(n + n_rows - 1)), .] = this_group
			n = n + n_rows
		}
		
		st_matrix(matname, all_vals)
	}
end
