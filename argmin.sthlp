{smcl}
{* *! version 1.0.0 15apr2014}{...}

{title:Title}

{phang}
{bf : argmin} {hline 2} find observation number of a numeric variable's min value{p_end}

{title:Syntax}
{p 8 17 2}
{cmdab:argmin}
{varname}
{ifin}
[ {cmd:,} {it:options} ]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opth eval(varlist)}}evaluate specified variables at
	returned observation number(s){p_end}

{synopt:{opth by(varlist)}}group by specified variables when finding min value; 
	{cmd:argmin} will find the min value's observation number (or {it:numbers} 
	if there are ties) per each group implied by {it:varlist}{p_end}
{synoptline}
{p2colreset}{...}


{title:Description}

{phang}
{cmd:argmin} finds the observation number of the minimum value of the given 
	numeric variable {it:varname}. Missing values are excluded. If the minimum 
	value occurs in multiple observations, then {cmd:argmin} finds all such 
	observations. If the option {opt eval(varlist)} is specified, then {cmd:argmin} 
	also returns the values of these variables at the calculated observation 
	numbers. If {opt by(varlist)} is specified, then {cmd:argmin} does the 
	above for each group implied by these variables (excluding missing values).
	
{pmore}
	Minimum values and observation numbers are put in return matrix 
	{cmd:r(values)}, along with any {opt by} and {opt eval} variables. If
	any of the {opt by} variables are string, their values will be replaced
	by integer values in the {cmd:r(values)} matrix. If any of the {opt eval}
	variables are string, their values will be the missing value "." in the 
	{cmd:r(values)} matrix.

	
{title:Examples}

      {com}. sysuse auto
      {txt}(1978 Automobile Data)
      
      {com}. argmin price
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,2]
          obs_num    price
      r1 {res}      34     3291
      {reset}
      {com}. argmin price , eval(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[1,3]
          obs_num    price    rep78
      r1 {res}      34     3291        3
      {reset}
      {com}. argmin price , by(rep78)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,3]
          obs_num    price    rep78
      r1 {res}      40     4195        1
      {txt}r2 {res}      18     3667        2
      {txt}r3 {res}      34     3291        3
      {txt}r4 {res}      29     3829        4
      {txt}r5 {res}      68     3748        5
      {reset}
      {com}. argmin price , by(rep78) eval(mpg)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[5,4]
          obs_num    price    rep78      mpg
      r1 {res}      40     4195        1       24
      {txt}r2 {res}      18     3667        2       24
      {txt}r3 {res}      34     3291        3       20
      {txt}r4 {res}      29     3829        4       22
      {txt}r5 {res}      68     3748        5       31
      {reset}
	  
{pstd}
If a variable in the {opt by} option is a string variable, then the values
that show up in the {cmd:r(values)} matrix are integer values corresponding
to the string's position when sorted.
	  
      {com}. gen brand = word(make, 1)
      
      . argmin price if !foreign , by(brand)
      {res}
      {com}. matrix list r(values)
      {res}
      {txt}r(values)[11,3]
           obs_num    price    brand
       r1 {res}       3     3799        1
      {txt} r2 {res}      10     4082        4
      {txt} r3 {res}      11    11385        5
      {txt} r4 {res}      14     3299        6
      {txt} r5 {res}      20     3984        8
      {txt} r6 {res}      25     4187       10
      {txt} r7 {res}      26    11497       12
      {txt} r8 {res}      34     3291       14
      {txt} r9 {res}      39     4181       15
      {txt}r10 {res}      46     4060       17
      {txt}r11 {res}      52     4172       18
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
The number of rows in {cmd:r(values)} is determined by the number of tied minimun
values in each group implied by {opt by(varlist)} (excluding missing values), or 
just the number of tied minimun values if {opt by(varlist)} is not used.


{title:See also}

{help argmax:argmax}


{title:Author}

{pstd}
James Fiedler, Universities Space Research Association{break}
Email: {browse "mailto:jrfiedler@gmail.com":jrfiedler@gmail.com}
