proc pdf_paper_size {pdf} {
	set sizes [exec bash -c "pdfinfo  $pdf | grep \"Page size\" | grep -Eo '\[-+\]?\[0-9\]*\\.?\[0-9\]+'"]
	set doc_dim "[expr int([lindex $sizes 0])] [expr int([lindex $sizes 1])]"
	set ISO_SIZES [dict create A0 "2384 3370" A1 "1684 2384" A2 "1190 1684" A3 "842 1190" A4 "595 842" Letter "612 792" A5 "420 595" A6 "298 420" A7 "210 298" A8 "148 210"]
	dict for {std size} $ISO_SIZES {
		set width [lindex $size 0]
		set height [lindex $size 1]
		
		set dwidth [lindex $doc_dim 0]
		set dheight [lindex $doc_dim 1]
		
		set errmarw [list [expr $width - 1] $width [expr $width + 1]]
		set errmarh [list [expr $height - 1] $height [expr $height + 1]]
		
		if {$dwidth > $dheight} {
			if {[lsearch $errmarh $dwidth] != -1 & [lsearch $errmarw $dheight] != -1} {
				return "[append $std H]"
			}
		} else {
			if {[lsearch $errmarh $dheight] != -1 & [lsearch $errmarw $dwidth] != -1} {
				return "[append $std V]"
			}
		}
	}
}