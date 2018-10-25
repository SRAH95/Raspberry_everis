#!/bin/bash

ar=(1 2 3 4 5 6)
reverse()
{
	arr=("${!1}")
	arr_reversed=()
	min=1
	max=${#arr[*]}
	#declare -p arr
	while (($min <= $max)); do
		arr_reversed+=(${arr[-$min]})
		min=$((min+1))
	done
	#declare -p arr_new
}

reverse ar[@]
ar1=${arr_reversed}
declare -p ar1
declare -p ar
declare -p arr_reversed
