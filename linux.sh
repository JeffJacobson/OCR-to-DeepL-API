#!/bin/bash
# Linux script created by Sonickyle27.
# This takes text within quotes and sends it to DeepL to be translated.
# You need an API key from DeepL that you can get from https://www.deepl.com/pro#developer

apikey=77b8102f-d342-f26f-2fac-6daadae08d25 # Put your API key here!
# Look at https://www.deepl.com/docs-api/translating-text/request/ for supported languages
targetlang=EN
sourcelang=JA

echo "Recieved from input: $1" # Show input text in console. Quotes work here.
if [ $sourcelang == "JA" ]; then # If the source language is Japanese...
    preparedsource=$(echo $1 | tr -d ' ') # ...remove spaces so DeepL doesn't die.
    echo "Without spaces: $spaceless" # Show the input text without spaces.
else
    preparedsource=$1 # Keep the input text as-is
fi

# Outputs the input text in a nice OSD with Dunst.
dunstify "Text recieved from input. Without spaces, it is the following:" \
$'\n'"$spaceless" -a "DeepL script - JP to EN" -u 0

# Here is where the magic with DeepL happens. We get the JSON response from
# this and put it into translatedraw.
translatedraw=$(curl -G "https://api.deepl.com/v2/translate?auth_key=$apikey" \
--data-urlencode "text=$preparedsource" \
-d "target_lang=$targetlang&source_lang=$sourcelang")

if [ $? -eq 0 ]; then # If the curl above was sucessful
    echo "Response from DeepL: $translatedraw"
    # Get the translated text from the JSON response.
    translated=$(echo $translatedraw | jq -c '.translations[0].text')
    echo "$translated"
    dunstify "Sucessfully translated:"$'\n'"$translated" -a "DeepL script - $sourcelang to $targetlang"
    exit 0
else # If the curl above was NOT sucessful
    echo "The request failed!"
    dunstify "The translation failed!"$'\n'"Is there an internet connection?" -a "DeepL script - $sourcelang to $targetlang"
    exit 1
fi
