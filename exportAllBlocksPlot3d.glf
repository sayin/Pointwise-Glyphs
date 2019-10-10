package require PWI_Glyph 2

# set the solver: Ansys Fluent, 3D for this example
# pw::Application setCAESolver "ANSYS Fluent" 3

# get current working directory
set cwdName [pwd]

# loop on all blocks
    foreach thisBlock  [ pw::Grid getAll -type pw::Block ] {
	set currentBlockName [$thisBlock getName]
	 append currentCaeName $cwdName "/" $currentBlockName ".grd"
		puts [ format "Exporting block %s to %s ..." $currentBlockName $currentCaeName ]
			
# export the block
		
        set thisMode [pw::Application begin GridExport [pw::Entity sort [list $thisBlock]]]
	   $thisMode initialize -type PLOT3D $currentCaeName
		if {![$thisMode verify]} {
		error "Data verification failed."
		} else {
			$thisMode write
			puts "... success."
		}		
		$thisMode end
		unset currentCaeName
	  }

 unset thisBlock
unset currentBlockName
unset thisMode
unset cwdName

