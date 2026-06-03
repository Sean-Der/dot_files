#!/usr/bin/env bash

while true; do
  acpiout=$(LC_ALL=C acpi -b)
  stat=$(echo $acpiout| awk '{print $3}' | sed '$s/,$//')
  batt=$(echo $acpiout| awk '{print $4}' | sed '$s/,$//')

  time=$(date +%R)
  echo "⚡ ${batt} | ${time}"
  sleep 60
done
