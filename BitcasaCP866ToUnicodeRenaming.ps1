 function ConvertTo-Encoding ([string]$From, [string]$To){
	Begin{
		$encFrom = [System.Text.Encoding]::UTF8
		$encTo = [System.Text.Encoding]::GetEncoding("CP866")
	}
	Process{
		$bytes = $encTo.GetBytes($_)
		$bytes = [System.Text.Encoding]::Convert($encFrom, $encTo, $bytes)
		$encTo.GetString($bytes)
	}
}

foreach( $item in Get-ChildItem -Recurse | Sort-Object -Property FullName –Descending){

 $correctName = $item.Name | ConvertTo-Encoding "Unicode" "CP866"
 if($correctName.Contains("???") -or $correctName -eq $item.Name) {continue}

 $itemParentPath = $item.FullName.Remove($item.FullName.Length - $item.Name.Length);
 $correctFullName = $itemParentPath + $correctName

  "renaming" 
  $item.FullName
  "to"
  $correctFullName

  Rename-Item $item.FullName $correctFullName
 #}
}
