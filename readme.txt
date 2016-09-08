SpamSentry by Anea 

This addon filters messages from goldspammers from the whisper, say and yell channels. If a spammer has been detected, the message will be blocked and you will optionally be notified. All blocked messages will be added to a reportlist. You will be periodically reminded to submit the spammers on your reportlist to a GM. Messages can be blocked manually as well. 

Installation: 
* Unzip the file into your 'Interface/Addons' folder. 

Use: 
* To view the list of recently blocked characters, type: /sentry list 
* To report the recently blocked characters, type: /sentry report 
* To clear the reportlist, type: /sentry clear 
* To toggle notification, type: /sentry notify hourly|off|always
* To toggle bot-reporting, type: /sentry bot";
* Use the options channellist|channeladd|channelremove|channelclear to edit the monitored channels. Allowed channelnames are: Whisper, Say, Yell. By default they are all activated. 
* Right-click a name or playerframe and select 'Report Spam' to manually add this player to the reportlist. 

Features: 
* Blocks spam from goldsellers.
* Use build-in function and GUI to report spammers to a GM. 
* Customizable notification.
* Manual reporting of players you suspect to be a goldseller / bot.
* Seperate reportlists are maintained for each realm you play on.

Third-party addons supported:
* WIM is currently unsupported, a beta is to be expected soon though.

How to help: 
* If a spam-message isn't recognised, please send me a pm containing the spam-message. Your feedback helps me to keep the filters up-to-date.
* Same applies for messages that were blocked while not being spam. 

Performance notes: 
* All code has been designed to minimize parsing-time, and maximize performance for raiding. 
* The mod currently uses approximately 30kB memory.
* Enabeling filtering of the channels Trade, LFG and General may affact performance.

Known issues:
* Blizzard made an a-typical implementation for who-queries. You may notice slow response on the /who command while using this mod when the chat is crowded. 
* Textballoons from says and yells are still shown. Blizzard currently provides no way to block textballoons.
* On very rare occasions an incoming message may cause an open window to move or even close.

Localisation: 
German - Credits to Scath for his translation
French - Credits to: Foxbad, Onissifor, Citanul, Beldarane
Other  - Please contact me if you're able / willing to provide localisation for your language.

Special thanks:
To Aery for unlimited testing-support


Versionhistory:
20061122 - Added support for manual bot-reporting. Added automatic ignore-list adding/removing to suppress subsequent textballoons. Fixed a minor bug.
20061118 - Updated version-check
20061117 - Several updates:
- Full rework of WIM-hook.
- Fixed a few minor bugs
- Updated filters
- Reworked heuristics for better prevention of false positives
- Updated French translation
20061112 - Several updates:
- Now supresses fast spammed messages
- Added general channel support
- Added French localisation, thanks to Foxbad
- Added support for WIM
- Optimized some code (thanks Noos)
20061109 - Changed who-hook to fix issues with other mods
20061108 - Major update:
- Added German localisation, thanks to Scath
- Added cross-realm support
- Fixed a bug where the mod caused open windows to close/move on each received message
- Updated the report-GUI to support messages of up to 5000 characters now. (previously only 500)
- Added a who-cache to prevent quickly-spammed messages from appearing due to who-lag.
20061107 - Minor bug-fix, typo's.
20061106 - Fixed a bug semi-randomly causing messages from people not in guild/party/friends to not appear in chatlog
20061105 - Removed left-behind debugcode causing an error now when a message was blocked. Updated some message-texts.
20061104 - Removed the clickable link in player messages, added a right-click option to player-frames and player-names. Cleaned-up some code, removed a bug causing a script error.
20061103 - Fixed a bug that caused the mod to generate a script error when receiving a whisper from a low-level character
20061102 - Removed left-behind debugcode
20061031 - Beta 2
20061029 - Beta
20061024 - Alfa