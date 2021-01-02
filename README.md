# OCR to DeepL API scripts
This is a Work In Progress collection of scripts used to link [dpScreenOCR](https://danpla.github.io/dpscreenocr/) and [DeepL](https://www.deepl.com/home) together.

I chucked this together to help me with translating Japanese text with dpScreenOCR's selection functionality, but by changing the variables contained within the script, you can change what languages are used.

dpScreenOCR allows you to automatically run a script with the OCR'd text, so with this script set up, you can have dpScreenOCR send the OCR'd text to DeepL, and get back the translation, all in a few seconds. Of course, this requires an internet connection. If there does exist a way to translate text offline, perhaps you can extend this script to support that?

Alternatively, you can pass a string straight to the script without going through dpScreenOCR!

## Linux
### Usage
Save then open up the `linux.sh` file in your file editor of choice, and go to the `apikey=77b8102f-d342-f26f-2fac-6daadae08d25` line. Replace the key to the right of `=` with your own obtained from the [DeepL Account Info page](https://www.deepl.com/pro-account.html).

On the next two lines you'll find `targetlang=EN` and `sourcelang=JA`. Change the languages here to any of [DeepL's supported lanaguages](https://www.deepl.com/docs-api/translating-text/request/) if needed.

Save and close the file, then in a terminal while in the same folder as the file, run `chmod +x ./linux.sh` to ensure the script can be executed.

If you would like to use this script with dpScreenOCR, open dpScreenOCR, then go to the Actions tab and set "Run executable:" to true. Then click the `...` button to open a file picker. Navigate to where you saved the `linux.sh` file, then double click to open it. Now whenever you use dpScreenOCR to OCR text, the text will be sent to DeepL and you'll get a notification with the translation!

Alternatively, if you want to use the script from the terminal, you can instead give the script strings of text directly rather than going through dpScreenOCR. Follow all the instructions above except for setting up dpScreenOCR, and in a terminal while in the same folder as the file, run the following:    
`./DeepL_JPtoEN.sh "テレポート"`    
This will give you the following output:
```
Recieved from input: テレポート
Without spaces: テレポート
Response from DeepL: {"translations":[{"detected_source_language":"JA","text":"Teleport"}]}
"Teleport"
```


### Dependencies
This script relies on a few programs to work, which are the following:
*   `Bash`
*   GNU Coreutils for `tr`
*   `curl`
*   `dunst` and `dunstify` for notification support. I'm looking into `notify-send`

All of these should be in your package manager.

## Windows
Coming soon!

## TODO
- [ ] Find a way to remove the quotes around the translated text.
- [ ] Do more testing around multi-line text input.
- [ ] Get rid of the reliance on Dunst.
- [ ] Better error handling.
- [ ] Allow the languages to be (optionally) selected using arguments.
