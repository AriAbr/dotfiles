#!/bin/bash

ACPI_RES=$(acpi -b)

# Look for 100, if it's not found look for 2 digits
PERCENT_LEFT=$(echo $ACPI_RES | grep -E -o '100')
if [[ -z "$PERCENT_LEFT" ]]; then
   PERCENT_LEFT=$(echo $ACPI_RES | grep -E -o '[0-9]{2}?')
fi

PERCENT_LEFT+="%"

# Full and short texts
echo "$PERCENT_LEFT"
echo "$PERCENT_LEFT"

# Set urgent flag below 5% or use orange below 20%
[ ${PERCENT_LEFT} -le 5 ] && exit 33
[ ${PERCENT_LEFT} -le 20 ] && echo "#FF8000"
[ ${PERCENT_LEFT} -eq 100 ] && echo "#00FF00"

exit 0