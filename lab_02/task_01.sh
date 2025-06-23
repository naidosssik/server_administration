#!/bin/bash

read -p "Введите размер шахматной доски: " size

if ! [[ "$size" =~ ^[0-9]+$ ]]; then
  echo "Введите положительное число"
  exit 1
fi

for ((row=0; row<size; row++)); do
  for ((col=0; col<size; col++)); do
    if (( (row + col) % 2 == 0 )); then
      printf "\e[47m  \e[0m"
    else
      printf "\e[40m  \e[0m"
    fi
  done
  echo
done
