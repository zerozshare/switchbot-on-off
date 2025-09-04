#!/bin/bash

# SwitchBot API config
API_TOKEN="ここにトークン"
DEVICE_ID="ここにデバイスID"

# Receive POST data
read POSTDATA
ACTION=$(echo "$POSTDATA" | sed -n 's/^.*action=\([^&]*\).*$/\1/p')

# ON/OFF command
if [ "$ACTION" = "on" ]; then
  CMD="turnOn"
elif [ "$ACTION" = "off" ]; then
  CMD="turnOff"
else
  CMD=""
fi

echo "Content-Type: text/html"
echo ""

if [ -n "$CMD" ]; then
  # Send request to SwitchBot API
  curl -s -X POST "https://api.switch-bot.com/v1.1/devices/$DEVICE_ID/commands" \
    -H "Authorization: $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"command\":\"$CMD\",\"parameter\":\"default\",\"commandType\":\"command\"}"
  echo "<p>Air Purifier turned $ACTION.</p>"
else
  echo "<p>Invalid operation.</p>"
fi

echo "<a href='/'>Back</a>"
