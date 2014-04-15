Stata package for finding argmax and argmin
===========================================

Installing
----------

You can clone the Git repo with

    git clone https://github.com/jrfiedler/stata_argmax

Or you can download a zip archive by clicking on the "Download ZIP" button on the right side of this page.

Syntax
------

**argmax** _varname_ [_if_] [_in_] [, _options_]

**argmin** _varname_ [_if_] [_in_] [, _options_]

_options:_

1. **by**(_varlist_)

  - group by specified variables when finding values; the values will  be calculated separately in each group implied by _varlist_
        
2. **eval**(_varlist_)

  - evaluate specified variables at returned observation number(s)

Description
-----------
**argmax**/**argmin** finds the observation number of the max/min value of the given numeric variable _varname_. Missing values are excluded. If the max/min value occurs in multiple observations, then **argmax**/**argmin** finds all such observations. If the option **eval**(_varlist_) is specified, then **argmax**/**argmin** also returns the values of these variables at the calculated observation numbers. If **by**(_varlist_) is specified, then **argmax**/**argmin** does the above for each group implied by these variables (excluding missing values).

Max/min values and observation numbers are put in return matrix **r(values)**, along with any **by** and **eval** variables. If any of the **by** variables are string, their values will be replaced by integer values in the **r(values)** matrix. If any of the **eval** variables are string, their values will be the missing value "." in the **r(values)** matrix.



Example usage
-------------

    . sysuse auto
    (1978 Automobile Data)
    
    . argmax price
    
    . matrix list r(values)
    
    r(values)[1,2]
        obs_num    price
    r1       13    15906
    
    . argmax price , eval(rep78)
    
    . matrix list r(values)
    
    r(values)[1,3]
        obs_num    price    rep78
    r1       13    15906        3
    
    . argmax price , by(rep78)
    
    . matrix list r(values)
    
    r(values)[5,3]
        obs_num    price    rep78
    r1       48     4934        1
    r2       12    14500        2
    r3       13    15906        3
    r4       55     9735        4
    r5       74    11995        5
    
    . argmax price , by(rep78) eval(mpg)
    
    . matrix list r(values)
    
    r(values)[5,4]
        obs_num    price    rep78      mpg
    r1       48     4934        1       18
    r2       12    14500        2       14
    r3       13    15906        3       21
    r4       55     9735        4       25
    r5       74    11995        5       17


Author
-----
James Fiedler (jrfiedler at gmail dot com)