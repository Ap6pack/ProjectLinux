#!/bin/bash
# weatherTracker --Uses the Wunderground API and a giving ZIP code 
# to pull weather data for that area.

if [ $# -ne 1 ]; then
  echo "Uses: $0 <zipcode>"
  exit 1
fi

apikey="request your own from wunderground its free"

weather=`curl -s \
        "https://api.wunderground.com/api/$apikey/conditions/q/$1.xml"`
state=`xmllint --xpath \
        //response/current_observation/display_location/full/text\(\) \
        <(echo $weather)`
zip=`xmllint --xpath \
        //response/current_observation/display_location/zip/text\(\) \
        <(echo $weather)`
current=`xmllint --xpath \
        //response/current_observation/temp_f/text\(\) \
        <(echo $weather)`
condition=`xmllint --xpath \
        //response/current_observation/weather/text\(\) \
        <(echo $weather)`

echo $state" ("$zip") : Current temp "$current"F and "$condition" outside."

exit 0


