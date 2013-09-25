args verbosity

preserve
clear

input      x   y   z                a                b                c
  0.13698408   4   1   -0.06120226160   -0.58468264341    0.39037570357
  0.64322066   3   2   -0.41095989943   -0.75507795811    0.59137773514
  0.55780172   1   1   -1.23255133629   -0.30485823750   -1.14592885971
           .   0   3    0.33577874303   -0.38997378945   -1.72092008591
  0.68417597   3   2   -2.44594788551    0.37783855200    1.05121922493
  0.10866794   2   1    0.27357900143   -0.94064378738   -0.44974857569
  0.61845815   4   1    0.19940005243    0.68099671602    1.42159521580
           .   1   1   -1.12300813198   -1.13828921318    0.94158077240
  0.55523884   3   2   -0.15233451128   -0.21298247576   -0.40120559931
  0.87144905   1   3   -0.81375277042   -2.15528059006    0.81585699320
  0.25514987   5   2    0.63791871071   -0.96206665039   -0.99483358860
           .   .   2    0.94576072693   -0.41876775026   -0.69305056334
  0.42415571   .   1    0.76043146849   -2.67143821716    0.32857933640
  0.89834619   .   .   -0.71397233009    1.30874621868   -0.53886008263
  0.52192473   .   .    0.38269063830    0.47224110365   -1.11392796040
           .   2   .    1.98802828789    0.16892202199   -1.07475006580
  0.21100765   2   .    0.03275771439    2.02227687836   -0.12167984247
  0.56440920   5   .   -0.11002050340   -2.31917071342   -0.25269839168
  0.26480210   3   0    0.73073166609    0.54437100887   -0.22422334552
           .   4   3   -1.04646348953    2.32995891571   -1.22413969040
  0.27691540   0   2   -0.93804514408   -1.21243774891   -0.56344258785
  0.11801585   4   1   -1.63395857811    0.33342120051   -1.02388262749
  0.40797025   1   2    3.10251164436    0.76736903191   -0.07002779096
  0.72194916   2   1   -0.05675028637   -0.34754949808   -0.80881351233
  0.87169105   1   3    0.23466180265   -1.39644014835   -0.06543352455
  0.46114290   1   2    1.33303964138    1.96523857117    0.58080887794
  0.42167261   0   2   -0.58382374048   -1.54345023632   -1.64932262897
  0.89447457   1   1    0.99552601576    0.82311534882   -1.95377731323
  0.05806616   1   0    1.35750043392   -1.26591360569   -0.27517172694
  0.67594874   3   2   -0.73423129320    1.56911540031   -0.27361765504
end



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (29)
local rmatrix = "values `values' "


noi testcase agrmin , ///
	cmd(argmin x) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (29, 1, 0, 1.357500433921814, -1.265913605690002, -.2751717269420624)
local rmatrix = "values `values' "


noi testcase argmin -eval- , ///
	cmd(argmin x , eval(y z a b c)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')


// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (21 \  ///
                   29 \  ///
                   3 \  ///
                   23 \  ///
                   10 \  ///
                   6 \  ///
                   19 \  ///
                   9 \  ///
                   22 \  ///
                   11)
local rmatrix = "values `values' "


noi testcase argmin -by- , ///
	cmd(argmin x , by(y z)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (21 \  ///
                   23 \  ///
                   10 \  ///
                   6 \  ///
                   19 \  ///
                   9 \  ///
                   22 \  ///
                   11)
local rmatrix = "values `values' "


noi testcase argmin -in- -by- , ///
	cmd(argmin x in 5/25 , by(y z)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (21, -.9380451440811157, -1.212437748908997, -.563442587852478 \  ///
                   29, 1.357500433921814, -1.265913605690002, -.2751717269420624 \  ///
                   3, -1.232551336288452, -.3048582375049591, -1.145928859710693 \  ///
                   23, 3.102511644363403, .7673690319061279, -.0700277909636498 \  ///
                   10, -.8137527704238892, -2.155280590057373, .8158569931983948 \  ///
                   6, .2735790014266968, -.9406437873840332, -.4497485756874085 \  ///
                   19, .7307316660881043, .5443710088729858, -.2242233455181122 \  ///
                   9, -.1523345112800598, -.2129824757575989, -.4012055993080139 \  ///
                   22, -1.633958578109741, .3334212005138397, -1.023882627487183 \  ///
                   11, .6379187107086182, -.962066650390625, -.9948335886001587)
local rmatrix = "values `values' "


noi testcase argmin -by- -eval- , ///
	cmd(argmin x , by(y z) eval(a b c)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (14)
local rmatrix = "values `values' "


noi testcase argmax , ///
	cmd(argmax x) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (14, ., ., -.7139723300933838, 1.308746218681335, -.5388600826263428)
local rmatrix = "values `values' "


noi testcase argmax -eval- , ///
	cmd(argmax x , eval(y z a b c)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (27 \  ///
                   29 \  ///
                   28 \  ///
                   26 \  ///
                   25 \  ///
                   24 \  ///
                   19 \  ///
                   5 \  ///
                   7 \  ///
                   11)
local rmatrix = "values `values' "


noi testcase argmax -by- , ///
	cmd(argmax x , by(y z)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values 
matrix `values' = (21 \  ///
                   23 \  ///
                   25 \  ///
                   24 \  ///
                   19 \  ///
                   5 \  ///
                   7 \  ///
                   11)
local rmatrix = "values `values' "


noi testcase argmax -in- -by-, ///
	cmd(argmax x in 5/25 , by(y z)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')



// r matrix
local rmatrixnames = "values "
tempname values
matrix `values' = (27, -.5838237404823303, -1.543450236320496, -1.649322628974915 \  ///
                   29, 1.357500433921814, -1.265913605690002, -.2751717269420624 \  ///
                   28, .9955260157585144, .823115348815918, -1.953777313232422 \  ///
                   26, 1.33303964138031, 1.965238571166992, .5808088779449463 \  ///
                   25, .234661802649498, -1.396440148353577, -.0654335245490074 \  ///
                   24, -.0567502863705158, -.3475494980812073, -.8088135123252869 \  ///
                   19, .7307316660881043, .5443710088729858, -.2242233455181122 \  ///
                   5, -2.445947885513306, .3778385519981384, 1.05121922492981 \  ///
                   7, .1994000524282455, .6809967160224915, 1.421595215797424 \  ///
                   11, .6379187107086182, -.962066650390625, -.9948335886001587)
local rmatrix = "values `values' "


noi testcase argmax -by- -eval- , ///
	cmd(argmax x , by(y z) eval(a b c)) ///
	verbosity(`verbosity') ///
	rmatrixnames(`rmatrixnames') ///
	rmatrix(`rmatrix')

