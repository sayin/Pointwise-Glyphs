package require PWI_Glyph 2.17.2

set blockToSplit [pw::GridEntity getByName "blk-1"]

set _TMP(split_params) [list]
set numberOfSplitLocations 10

# get dimensions of block
set blockDims [$blockToSplit getDimensions]
puts [ format "Dimensions of block : %s" $blockDims ]

# get I dimension
set blockIDimension [lindex $blockDims 0]
puts [ format "I Dimension of block : %s" $blockIDimension ]

# calculate split locations: 
#	What id the number of grid pts along I is not a multiple of numberOfSplitLocations?
#	In that case, use your own logic to figure out how to space them
#	This sample code exits
set myRemainder [ expr { $blockIDimension % $numberOfSplitLocations } ]
puts [ format "Checking if number of blocks is a factor of dimension: remainder = %s" $myRemainder]


	# It is a prefect multiple, so now loop
set myGap [ expr {round($blockIDimension / $numberOfSplitLocations )} ]
puts [ format "Gap = %s" $myGap ]

for  {set myCounter 1} {$myCounter < $numberOfSplitLocations} {incr myCounter} { 
	set myLocation [ expr { $myCounter*$myGap } ]
	lappend _TMP(split_params) [lindex [list $myLocation 1 1 ::pw::BlockStructured_1] 0]
	puts [ format "Will split at %s ..." $myLocation ]
}
		# now split the block
$blockToSplit split -I $_TMP(split_params)

	# clean up - remove the variables created above
unset _TMP(split_params)
unset myLocation
unset myCounter
unset blockIDimension
unset numberOfSplitLocations
unset myRemainder
