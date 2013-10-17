{smcl}
{* *! version 0.1.0 09oct2013}{...}

{title:Title}

{phang}
{bf : argmin} {hline 2} find observation number of a numeric variable's min value{p_end}

{title:Syntax}
{p 8 17 2}
{cmdab:argmin}
{varname}
[ {cmd:,} {it:options} ]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opth eval(varlist)}}specify variables to evaluate at
	returned observation number(s){p_end}

{synopt:{opth by(varlist)}}specify variables to group by when finding min value; 
	{cmd:argmin} will find the min value's observation number (or {it:numbers} 
	if there are ties) per each group implied by {it:varlist}{p_end}
{synoptline}
{p2colreset}{...}


{title:Description}

{phang}
{cmd:argmin} finds the observation number of the minimum value of the given 
	numeric variable {it:varname}. If there is a tie for minimum value, then 
	{cmd:argmin} finds all observation numbers at which the minimun value is 
	obtained. If the option {opt eval(varlist)} is specified, then {cmd:argmin} 
	also finds the values of these variables at the calculated observation 
	number(s). If {opt by(varlist)} is specified, then {cmd:argmin} does the 
	above for each group implied by the specified variables.
	
	Minimum values, observation numbers, and group numbers are put in
	return matrix {cmd:r(values)}, along with any {opt eval} variables.

	
{title:Examples}

      {com}. sysuse auto
      {txt}(1978 Automobile Data)
      
      {com}. argmin price
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,3]
            group  obs_num    price
      r1 {res}       1       34     3291
      {reset}
      {com}. argmin price , eval(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,4]
            group  obs_num    price    rep78
      r1 {res}       1       34     3291        3
      {reset}
      {com}. argmin price , by(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,3]
            group  obs_num    price
      r1 {res}       1       40     4195
      {txt}r2 {res}       2       18     3667
      {txt}r3 {res}       3       34     3291
      {txt}r4 {res}       4       29     3829
      {txt}r5 {res}       5       68     3748
      {reset}
      {com}. argmin price , by(rep78) eval(rep78 mpg)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,5]
            group  obs_num    price    rep78      mpg
      r1 {res}       1       40     4195        1       24
      {txt}r2 {res}       2       18     3667        2       24
      {txt}r3 {res}       3       34     3291        3       20
      {txt}r4 {res}       4       29     3829        4       22
      {txt}r5 {res}       5       68     3748        5       31
      {reset}


{title:Stored results}

{pstd}
{cmd:testcase} stores the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(values)}}matrix with columns containing {break}
						1) group number(s) (or 1, if {opt by(varlist)} option not used), {break}
						2) obs. number(s), {break}
						3) {it:varname} value, {break}
						4..) {opt eval} variable values, if any{p_end}
{p2colreset}{...}

{pstd}
The number of rows in {cmd:r(values)} is determined by the number of tied minimun
values in each group implied by {opt by(varlist)}, or just the number of tied
minimun values if {opt by(varlist)} is not used.

{title:Author}

{pstd}
James Fiedler, Universities Space Research Association{break}
Email: {browse "mailto:jrfiedler@gmail.com":jrfiedler@gmail.com}