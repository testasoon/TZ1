#!/bin/bash

if [[ $# != 2 ]]; then
  echo "Write only two paths."
  exit 1
fi

dir_from=$1
dir_to=$2

if [[ !  -d $dir_from  || ! -d $dir_to ]]; then
  echo "Write correct paths."
  exit 1
fi

DIRS=("$dir_from")
FILES=()
PATHS_TO_FILES=()
count=0
while [ $count != ${#DIRS[*]} ]
do
  for i in `ls ${DIRS[$count]}`
  do
    if [[ -d "${DIRS[$count]}/$i" ]]; then
      DIRS+=("${DIRS[$count]}/$i")
    elif [[ -f "${DIRS[$count]}/$i" ]]; then
      FILES+=("$i")
      PATHS_TO_FILES+=("${DIRS[$count]}")
    fi
  done
  count=$(( count + 1 ))
done

for(( index = 0; index < ${#FILES[@]}; index++ ))
do
  if [[ -f "$dir_to/${FILES[$index]}" ]]; then
    count=1
    while [ -f "$dir_to/$count-${FILES[$index]}" ]
    do
      count=$(( count + 1 ))
    done
    cp "${PATHS_TO_FILES[$index]}/${FILES[$index]}" "$dir_to/$count-${FILES[$index]}"
  else
    cp "${PATHS_TO_FILES[$index]}/${FILES[$index]}" "$dir_to/${FILES[$index]}"
  fi
done
echo ${#FILES[@]}