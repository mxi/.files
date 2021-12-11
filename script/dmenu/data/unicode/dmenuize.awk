#!/usr/bin/awk -f

BEGIN {
	FS = "\t";
}

{
	print $1 " " $2 "\t" $3 "\t" $4;
}
