#!/usr/bin/env bash

while true; do
  acpiout=$(LC_ALL=C acpi -b)
  stat=$(echo $acpiout| awk '{print $3}' | sed '$s/,$//')
  batt=$(echo $acpiout| awk '{print $4}' | sed '$s/,$//')
  batt_escape='\x01'

  if [ $stat == "Discharging" ]; then
    if (( ${batt::-1} < 10 )); then
      batt_escape='\x04'
    else
      batt_escape='\x03'
    fi
  fi

  time=$(date +%R)
  setroot=$(echo -e "${batt_escape} ⚡ ${batt} \x01| ${time}")
  xsetroot -name "$setroot"
  sleep 60
done
