{smcl}
{* *! version 0.1.0 09oct2013}{...}

{title:Title}

{phang}
{bf : argmax} {hline 2} find observation number of a numeric variable's max value{p_end}

{title:Syntax}
{p 8 17 2}
{cmdab:argmax}
{varname}
[ {cmd:,} {it:options} ]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opth eval(varlist)}}specify variables to evaluate at
	returned observation number(s){p_end}

{synopt:{opth by(varlist)}}specify variables to group by when finding max value; 
	{cmd:argmax} will find the max value's observation number (or {it:numbers} 
	if there are ties) per each group implied by {it:varlist}{p_end}
{synoptline}
{p2colreset}{...}


{title:Description}

{phang}
{cmd:argmax} finds the observation number of the maximum value of the given 
	numeric variable {it:varname}. If there is a tie for maximum value, then 
	{cmd:argmax} finds all observation numbers at which the maximun value is 
	obtained. If the option {opt eval(varlist)} is specified, then {cmd:argmax} 
	also finds the values of these variables at the calculated observation 
	number(s). If {opt by(varlist)} is specified, then {cmd:argmax} does the 
	above for each group implied by the specified variables.
	
	Maximum values, observation numbers, and group numbers are put in
	return matrix {cmd:r(values)}, along with any {opt eval} variables.

	
{title:Examples}

      {com}. sysuse auto
      {txt}(1978 Automobile Data)
      
      {com}. argmax price
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,3]
            group  obs_num    price
      r1 {res}       1       13    15906
      {reset}
      {com}. argmax price , eval(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,4]
            group  obs_num    price    rep78
      r1 {res}       1       13    15906        3
      {reset}
      {com}. argmax price , by(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,3]
            group  obs_num    price
      r1 {res}       1       48     4934
      {txt}r2 {res}       2       12    14500
      {txt}r3 {res}       3       13    15906
      {txt}r4 {res}       4       55     9735
      {txt}r5 {res}       5       74    11995
      {reset}
      {com}. argmax price , by(rep78) eval(rep78 mpg)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,5]
            group  obs_num    price    rep78      mpg
      r1 {res}       1       48     4934        1       18
      {txt}r2 {res}       2       12    14500        2       14
      {txt}r3 {res}       3       13    15906        3       21
      {txt}r4 {res}       4       55     9735        4       25
      {txt}r5 {res}       5       74    11995        5       17
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
The number of rows in {cmd:r(values)} is determined by the number of tied maximun
values in each group implied by {opt by(varlist)}, or just the number of tied
maximun values if {opt by(varlist)} is not used.

{title:Author}

{pstd}
James Fiedler, Universities Space Research Association{break}
Email: {browse "mailto:jrfiedler@gmail.com":jrfiedler@gmail.com}
