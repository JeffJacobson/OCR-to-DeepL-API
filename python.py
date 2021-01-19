#!/usr/bin/python
"""Linux script created by Sonickyle27.
This takes text within quotes and sends it to DeepL to be translated.
You need an API key from DeepL that you can get from https://www.deepl.com/pro#developer"""
import argparse, requests, json
from notifypy import Notify
apikey='77b8102f-d342-f26f-2fac-6daadae08d25' # Put your API key here! This is an example!
# Look at https://www.deepl.com/docs-api/translating-text/request/ for supported languages
sourcelang='JA'
targetlang='EN'
notification = Notify()
notification.title = ("DeepL script - "+sourcelang+" - "+targetlang)
    
parser = argparse.ArgumentParser("command")
parser.add_argument("input_string", help="The string that you would like to be translated", type=str)
args = parser.parse_args()
if sourcelang == 'JA':
    preparedsource=args.input_string.replace(" ", "")
    print("Input string without spaces:", preparedsource)
else:
    preparedsource=args.input_string
    print("Input string:", preparedsource)
url = ('https://api.deepl.com/v2/translate?auth_key='+apikey+'&text='+preparedsource+'&target_lang='+targetlang+'&source_lang='+sourcelang)
rawresponse = requests.post(url)
print(rawresponse)
if rawresponse.status_code == 200:
    print("Translation: "+rawresponse.json()['translations'][0]['text'])
    notification.message = ("Sucessfully translated.\nSource: "+preparedsource+"\nTranslation: "+rawresponse.json()['translations'][0]['text'])
    notification.send()
    exit
else:
    notification.message = ("The translation failed!\nSource: "+preparedsource+"\nError code: "+str(rawresponse.status_code))
    notification.send()
    exit
