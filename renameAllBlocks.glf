package require PWI_Glyph 2

			
set masterName "GRIDa"
set i 1

# loop over the number of blocks in the model

foreach thisBlock  [ pw::Grid getAll -type pw::Block ] {
			# construct the new name
	append thisBlockName $masterName $i
			# get the existing name of this block
	set currentName [$thisBlock getName]
			# some debugging info - comment it out if not needed
	puts [ format "oldName: %s, i: %s, thisBlockName: %s" $currentName $i $thisBlockName]
			# rename the block only if the new name != old name
			# if the new name = old name, then Pointwise will enforce
			# uniqueness of the name, which may not be what is wanted
	if { $currentName != $thisBlockName } {
		$thisBlock setName $thisBlockName
	} else {	
			#debugging info, comment if not needed
			puts "Same name, not renamed"	 
	}
	incr i
			#reset the variable for the next time round the loop
	unset thisBlockName	
}

		
unset i
unset masterName
unset thisBlock
unset currentName	
