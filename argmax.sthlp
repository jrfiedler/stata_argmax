{smcl}
{* *! version 1.0.0 15apr2014}{...}

{title:Title}

{phang}
{bf : argmax} {hline 2} find observation number of a numeric variable's max value{p_end}

{title:Syntax}
{p 8 17 2}
{cmdab:argmax}
{varname}
{ifin}
[ {cmd:,} {it:options} ]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opth eval(varlist)}}evaluate specified variables at
	returned observation number(s){p_end}

{synopt:{opth by(varlist)}}group by specified variables when finding max value; 
	{cmd:argmax} will find the max value's observation number (or {it:numbers} 
	if there are ties) per each group implied by {it:varlist}{p_end}
{synoptline}
{p2colreset}{...}


{title:Description}

{phang}
{cmd:argmax} finds the observation number of the maximum value of the given 
	numeric variable {it:varname}. Missing values are excluded. If the maximum 
	value occurs in multiple observations, then {cmd:argmax} finds all such 
	observations. If the option {opt eval(varlist)} is specified, then {cmd:argmax} 
	also returns the values of these variables at the calculated observation 
	numbers. If {opt by(varlist)} is specified, then {cmd:argmax} does the 
	above for each group implied by these variables (excluding missing values).
	
{pmore}
	Maximum values and observation numbers are put in return matrix 
	{cmd:r(values)}, along with any {opt by} and {opt eval} variables. If
	any of the {opt by} variables are string, their values will be replaced
	by integer values in the {cmd:r(values)} matrix. If any of the {opt eval}
	variables are string, their values will be the missing value "." in the 
	{cmd:r(values)} matrix.

	
{title:Examples}

      {com}. sysuse auto
      {txt}(1978 Automobile Data)
      
      {com}. argmax price
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,2]
          obs_num    price
      r1 {res}      13    15906
      {reset}
      {com}. argmax price , eval(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,3]
          obs_num    price    rep78
      r1 {res}      13    15906        3
      {reset}
      {com}. argmax price , by(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,3]
          obs_num    price    rep78
      r1 {res}      48     4934        1
      {txt}r2 {res}      12    14500        2
      {txt}r3 {res}      13    15906        3
      {txt}r4 {res}      55     9735        4
      {txt}r5 {res}      74    11995        5
      {reset}
      {com}. argmax price , by(rep78) eval(mpg)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,4]
          obs_num    price    rep78      mpg
      r1 {res}      48     4934        1       18
      {txt}r2 {res}      12    14500        2       14
      {txt}r3 {res}      13    15906        3       21
      {txt}r4 {res}      55     9735        4       25
      {txt}r5 {res}      74    11995        5       17
      {reset}
	  
{pstd}
If a variable in the {opt by} option is a string variable, then the values
that show up in the {cmd:r(values)} matrix are integer values corresponding
to the string's position when sorted.
	  
      {com}. gen brand = word(make, 1)
      
      . argmax price if !foreign , by(brand)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[11,3]
           obs_num    price    brand
       r1 {res}       2     4749        1
      {txt} r2 {res}       9    10372        4
      {txt} r3 {res}      13    15906        5
      {txt} r4 {res}      15     5705        6
      {txt} r5 {res}      23     6342        8
      {txt} r6 {res}      24     4389       10
      {txt} r7 {res}      27    13594       12
      {txt} r8 {res}      33     6303       14
      {txt} r9 {res}      41    10371       15
      {txt}r10 {res}      45     6486       17
      {txt}r11 {res}      47     5798       18
      {reset}


{title:Stored results}

{pstd}
{cmd:testcase} stores the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(values)}}matrix with columns containing {break}
						1) obs. number(s), {break}
						2) {it:varname} value, {break}
						3..) {opt by} variable values, if any, and 
						{opt eval} variable values, if any{p_end}
{p2colreset}{...}

{pstd}
The number of rows in {cmd:r(values)} is determined by the number of tied maximun
values in each group implied by {opt by(varlist)} (excluding missing values), or 
just the number of tied maximun values if {opt by(varlist)} is not used.


{title:See also}

{help argmin:argmin}


{title:Author}

{pstd}
James Fiedler, Universities Space Research Association{break}
Email: {browse "mailto:jrfiedler@gmail.com":jrfiedler@gmail.com}
