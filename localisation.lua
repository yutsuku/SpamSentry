loc = GetLocale();
if (loc == "deDE") then
	-- Channel names
	SS_WHISPER = "whisper";
	SS_SAY = "say";
	SS_YELL = "yell";
	SS_TRADE = "trade";
	SS_GENERAL = "general";
	SS_LFG = "lookingforgroup";
	SS_WORLD = "world";
	
	-- Short messages
	SS_MSGWELCOME = "|cffff0000SpamSentry|r|cffff9977 von Anea. Gib |cffffffff/sentry|r |cffff9977ein f\195\188r Optionen. (%s)|r";
	SS_MSGFOUND = "|cffff9977* Warnung: |r%s|cffff9977 hat versucht dir diese Mitteilung zu schicken: %s.";
	SS_MSGTEXT = "Mitteilung";
	SS_MSGCLEARED = "|cffff9977Die Ticketliste wurde gel\195\182scht.|r";
	SS_MSGSHORTHELP = "|cffff0000SpamSentry|r|cffff9977 von Anea (%s)\nGib folgende Befehle ein:\n |r|cffffffff/sentry hilfe | auflisten | l\195\182schen | benachrichtigen\n|r|cffffffff%s|r|cffff9977 Spammer seit Installation. |r|cffffffff%s|r|cffff9977 Spammer auf Ticketliste. Benachrichtigung ist |cffffffff%s|r|cffff9977.|r";
	SS_MSGREMOVEHELP = "|cffff9977Bitte gib eine g\195\188ltige Indexnummer zum Entfernen an.|r";
  SS_MSGLINKHELP = "|cffff9977Please give a valid index number to associate with.|r";
  SS_MSGLINKOK = "|cffff9977Associated '%s' with index %s.|r";
	
	-- Channel messages
	SS_MSGCHANNELADDED = "|cffff9977Kanal |cffffffff%s|r||cffff9977 hinzugef\195\188gt.|r";
	SS_MSGCHANNELREMOVED = "|cffff9977Kanal |cffffffff%s|r|cffff9977 entfernt .|r";
	SS_MSGCHANNELADDHELP = "|cffff9977Kanal %s |cffff9977nicht g\195\188ltig oder schon auf der Liste.G\195\188ltige Kan\195\164le sind:Whisper, Say, Yell|r";
	SS_MSGCHANNELCLEARED = "|cffff9977Alle Kan\195\164le wurden gel\195\182scht.|r";
	
	-- Report messages
	SS_MSGREPLIST = "|cffff9977Blockierte Mitteilung(s) :|r";
	SS_MSGREPEMPTY = "|cffff9977Keine blockierte Mitteilung(s)|r";
	SS_MSGREPNONE = "Niemand zum Melden.";
	SS_MSGREPOPENTICKETS = "Noch offene Tickets...";
	SS_MSGREPORTNOW = "|cffff9977Einer oder mehrere Spammer wurden geblockt.Klick|r %s |cffff9977 an, um sie einem GM zu melden.|r";
	SS_MSGHERE = "hier";
	SS_MSGREPORTTEXT = "Sehr geehrter GM,\n\nDie folgenden Charaktere haben versucht mir Gold f\195\188r echtes Geld zu verkaufen.\n\nMit freundlichen Gr\195\188\195\159en,\n\n%s\n\n---\n%s";
	SS_MSGREPMANUAL = "|cffdd0000Spam melden|r";
	NEWBIE_TOOLTIP_UNIT_SPAMSENTRY = "F\195\188gt die letzte Mitteilung dieses Spielers zur SpamSentry Ticketliste hinzu.";
	SS_MSGREPMANUALBLOCK = "|cffff9977Mitteilung von |r|cffffffff%s|r|cffff9977 wurde zur Ticketliste hinzugef\195\188gt.|r";
	SS_MSGREPNOCACHE = "|cffff9977Keine Mitteilung von |r|cffffffff%s|r|cffff9977 gespeichert.|r";
	
	-- Bot report messages	
	NEWBIE_TOOLTIP_UNIT_SPAMSENTRYBOT = "Report this player as a bot.";
	SS_MSGREPMANUALBOT = "|cffdd0000Report Bot|r";
	SS_MSGREPORTTEXTBOT = "Dear GM,\n\nToday at %s I found %s farming at %s. The way this character acted and moved appeared to be automated/scripted. Therefor I would like to report this player as a bot. Please contact me for details.\n\nBest regards,\n\n%s";
	SS_MSGBOTENABLED = "|cffff9977Bot reporting enabled|r";
	SS_MSGBOTDISABLED = "|cffff9977Bot reporting disabled|r";

	-- Notification options
	SS_OFF = "aus";
	SS_HOURLY = "st\195\188ndlich";
	SS_NORMAL = "immer";
	SS_DEBUG = "debug";
	SS_MSGNOTIFYOFF = "|cffff9977Benachrichtigung wurde deaktiviert.|r";
	SS_MSGNOTIFYHOURLY = "|cffff9977Benachrichtigung wurde auf st\195\188ndlich gesetzt.|r";
	SS_MSGNOTIFYNORMAL = "|cffff9977Benachrichtigung wurde auf immer gesetzt.Du wirst jedes mal eine Warnung erhalten, wenn eine Mitteilun geblockt wurde.|r";
	SS_MSGNOTIFYDEBUG = "|cffff9977Benachrichtigung auf debug-Modus gesetzt.|r";

	-- GUI texts
	SS_GUIREPORTHELP = "|cffff0000Anmerkung: Pr\195\188fe genau nach bevor du jemanden meldest!|r";
	SS_GUITITLE = "SpamSentry";
	SS_GUISEND = "Senden";
	SS_GUIRESET = "Reset";
	SS_GUICLOSE = "Schlie\195\159en";

	-- Commands
    SS_CMDLINK = "link";
    SS_CMDDELETE = "delete";
	SS_CMDREPLIST = "auflisten";
	SS_CMDREPREPORT = "melden";
	SS_CMDREPCLEAR = "l\195\182schen";
	SS_CMDNOTIFY = "benachrichtigen";
	SS_CMDCHANNELLIST = "kanalliste";
	SS_CMDCHANNELADD = "kanalhinzuf\195\188gen";
	SS_CMDCHANNELREMOVE = "kanall\195\182schen";
	SS_CMDCHANNELCLEAR = "kanallistenreset";
	SS_CMDHELP = "hilfe";

	-- Help texts
	SS_MSGHELP1 = "|cffff0000SpamSentry |r|cffff9977von Anea|r";
	SS_MSGHELP2 = "|cffff9977Dieses addon blockiert Spam von Gold verk\195\164ufern im whisper, say oder yell automatisch.|r";
	SS_MSGHELP3 = "|cffff9977* Um eine Liste von k\195\188rzlich geblockten Charakteren zu sehen gib: |r|cffffffff/sentry auflisten|r |cffff9977 ein.|r";
	SS_MSGHELP4 = "|cffff9977* Um die k\195\188rzlich geblockten Charaktere einem GM zu melden, gib |r|cffffffff/sentry melden|r |cffff9977 ein.|r";
	SS_MSGHELP5 = "|cffff9977* Um die Ticketliste zu l\195\182schen, gib: |r|cffffffff/sentry l\195\182schen|r |cffff9977 ein.|r";
	SS_MSGHELP6 = "|cffff9977* Um zwischen den Benachrichtigungsmodi zu wechseln gib: |r|cffffffff/sentry benachrichtigen st\195\188ndlich|immer|aus|r |cffff9977 ein.|r";
	SS_MSGHELP7 = "|cffff9977* To toggle bot-reporting, type: |r|cffffffff/sentry bot|r";
	SS_MSGHELP8 = "|cffff9977* Benutze die Optionen |r|cffffffffkanalliste|kanalhinzuf\195\188gen|kanall\195\182schen|kanallistenreset|r|cffff9977 um die beobachten Kan\195\164le zu \195\164ndern. Erlaubte Kanalnamen sind: |r|cffffffffWhisper, Say, Yell, Trade, General, LookingForGroup|r|cffff9977. Standardm\195\164\195\159ig sind n\195\188r Whisper, Say, Yell aktiviert.|r";
	SS_MSGHELP9 = "|cffff9977* Einen Spielernamen oder Spielerframe rechtsklicken und \"Spam melden\" ausw\195\164hlen um den Spieler manuell zur Ticketliste hinzuzuf\195\188gen.|r";
elseif (loc == "frFR") then
	-- Channel names
	SS_WHISPER = "chuchoter";
	SS_SAY = "dire";
	SS_YELL = "crier";
	SS_TRADE = "commerce";
	SS_GENERAL = "g\195\169n\195\169ral";
	SS_LFG = "recherchegroupe";
	SS_WORLD = "world";

	-- Short messages
	SS_MSGWELCOME = "|cffff0000SpamSentry|r|cffff9977 par Anea. Tapez |cffffffff\sentry|r |cffff9977pour les options. (v. %s)|r";
	SS_MSGFOUND = "|cffff9977* Alerte: |r%s|cffff9977 essaye de vous envoyer %s.";
	SS_MSGTEXT = "ce message";
	SS_MSGCLEARED = "|cffff9977La liste est maintenant vid\195\169e.|r";
	SS_MSGSHORTHELP = "|cffff0000SpamSentry|r|cffff9977 par Anea (v. %s)\nTapez: |r|cffffffff\/sentry aide | liste | vider | notifier\n|r|cffffffff%s|r|cffff9977 spammer(s) rapport\195\169(s) aux MJ. |r|cffffffff%s|r|cffff9977 spammer(s) en liste. La notification est |cffffffff%s|r|cffff9977.|r";
	SS_MSGREMOVEHELP = "|cffff9977Sp\195\169cifiez un index valide \249 effacer.|r";
  SS_MSGLINKHELP = "|cffff9977Please give a valid index number to associate with.|r";
  SS_MSGLINKOK = "|cffff9977Associated '%s' with index %s.|r";

	-- Channel messages
	SS_MSGCHANNELADDED = "|cffff9977Canal |cffffffff%s|r||cffff9977 ajout\195\169.|r";
	SS_MSGCHANNELREMOVED = "|cffff9977Canal |cffffffff%s|r||cffff9977 effac\195\169.|r";
	SS_MSGCHANNELADDHELP = "|cffff9977Canal %s |cffff9977n'est pas valide ou d\195\169j\195\160 en liste. Les canaux valides sont: Chuchoter, Dire, Crier, Commerce, G\195\169n\195\169ral, RechercheGroupe|r";
	SS_MSGCHANNELCLEARED = "|cffff9977Tous les canaux sont vid\195\169s.|r";
	
	-- Report messages	
	SS_MSGREPLIST = "|cffff9977Message(s) bloqu\195\169(s):|r";
	SS_MSGREPEMPTY = "|cffff9977Il n'y a pas messages bloqu\195\169s|r";
	SS_MSGREPNONE = "Rien \249 rapporter";
	SS_MSGREPOPENTICKETS = "Il y a d\195\169j\195\160 une fen\195\170tre ouverte...";
	SS_MSGREPORTNOW = "|cffff9977Un ou plusieurs spammers ont \195\169t\195\169 bloqu\195\169s. Cliquez|r %s |cffff9977pour envoyer un rapport \249 un MJ.|r";
	SS_MSGHERE = "ici";
	SS_MSGREPORTTEXT = "Cher MJ,\n\nLes personnages suivants ont essay\195\169s de me vendre des Pieces d'or contre de l'argent r\195\169el.\n\Salutation,\n\n%s\n\n---\n%s";
	SS_MSGREPMANUAL = "|cffdd0000Rapporter un Spam|r";
	NEWBIE_TOOLTIP_UNIT_SPAMSENTRY = "Ajoute le dernier message de ce joueur au rapport de SpamSentry.";
	SS_MSGREPMANUALBLOCK = "|cffff9977Le message de |r|cffffffff%s|r|cffff9977 a \195\169t\195\169 ajout\195\169 au rapport.|r";
	SS_MSGREPNOCACHE = "|cffff9977Le message de |r|cffffffff%s|r|cffff9977 ne peux pas \195\170tre ajout\195\169 au rapport (erreur de cache).|r";

	-- Bot report messages	
	NEWBIE_TOOLTIP_UNIT_SPAMSENTRYBOT = "Report this player as a bot.";
	SS_MSGREPMANUALBOT = "|cffdd0000Report Bot|r";
	SS_MSGREPORTTEXTBOT = "Dear GM,\n\nToday at %s I found %s farming at %s. The way this character acted and moved appeared to be automated/scripted. Therefor I would like to report this player as a bot. Please contact me for details.\n\nBest regards,\n\n%s";
	SS_MSGBOTENABLED = "|cffff9977Bot reporting enabled|r";
	SS_MSGBOTDISABLED = "|cffff9977Bot reporting disabled|r";

	-- Notification options
	SS_OFF = "d195\169activ195\169";
	SS_HOURLY = "heure";
	SS_NORMAL = "toujours";
	SS_DEBUG = "debug";
	SS_MSGNOTIFYOFF = "|cffff9977La notification a \195\169t\195\169 arr\195\170t\195\169.|r";
	SS_MSGNOTIFYHOURLY = "|cffff9977La notification a \195\169t\195\169 plac\195\169e pour un rappel horaire.|r";
	SS_MSGNOTIFYNORMAL = "|cffff9977La notification a \195\169t\195\169 activ\195\169e. Vous recevrez un avertissement chaque fois que un message sera bloqu\195\169.|r";
	SS_MSGNOTIFYDEBUG = "|cffff9977La notification a \195\169t\195\169 plac\195\169e en mode debug.|r";

	-- GUI texts
	SS_GUIREPORTHELP = "|cffff0000Attention: V\195\169rifiez le rapport avant de l'envoyer!|r";
	SS_GUITITLE = "SpamSentry";
	SS_GUISEND = "Envoyer";
	SS_GUIRESET = "Reset";
	SS_GUICLOSE = "Fermer";

	-- Commands
	SS_CMDLINK = "link";
    SS_CMDDELETE = "delete";
	SS_CMDREPLIST = "liste";
	SS_CMDREPREPORT = "rapport";
	SS_CMDREPCLEAR = "vider";
	SS_CMDNOTIFY = "notifier";
	SS_CMDCHANNELLIST = "canalliste";
	SS_CMDCHANNELADD = "canalajouter";
	SS_CMDCHANNELREMOVE = "canaleffacer";
	SS_CMDCHANNELCLEAR = "canalvider";
	SS_CMDHELP = "aide";

	-- Help texts
	SS_MSGHELP1 = "|cffff0000SpamSentry |r|cffff9977par Anea|r";
	SS_MSGHELP2 = "|cffff9977Cet addon bloque automatiquement le Spam des goldsellers sur les canaux Chuchoter, Dire et Crier.|r";
	SS_MSGHELP3 = "|cffff9977* Pour regarder la liste des personnes r\195\169cemment bloqu\195\169es, tapez: |r|cffffffff\sentry liste|r";
	SS_MSGHELP4 = "|cffff9977* Pour rapporter les personnes r\195\169cemment bloqu\195\169es, tapez: |r|cffffffff\sentry rapport|r";
	SS_MSGHELP5 = "|cffff9977* Pour purger le rapport, tapez: |r|cffffffff\sentry vider|r";
	SS_MSGHELP6 = "|cffff9977* Pour changer la notification, tapez: |r|cffffffff\sentry notifier heure | toujours | d\195\169activ\195\169|r";
	SS_MSGHELP7 = "|cffff9977* To toggle bot-reporting, type: |r|cffffffff/sentry bot|r";
	SS_MSGHELP8 = "|cffff9977* Utilisez l'option |r|cffffffffCanalListe | CanalAjouter | CanalEffacer | CanalVider|r|cffff9977 pour \195\169diter les canaux \249 surveiller. Les canaux permis sont: |r|cffffffffChuchoter, Dire, Crier, Commerce, G\195\169n\195\169ral, RechercheGroupe|r|cffff9977. Par d\195\169faut Chuchoter, Dire et Crier sont activ\195\169s.|r";
	SS_MSGHELP9 = "|cffff9977* Clic droit sur le nom d'un joueur et choisir 'Rapporter un Spam' pour ajouter manuellement ce joueur au rapport.|r";
else
	-- Channel names
	SS_WHISPER = "whisper";
	SS_SAY = "say";
	SS_YELL = "yell";
	SS_TRADE = "trade";
	SS_GENERAL = "general";
	SS_LFG = "lookingforgroup";
	SS_WORLD = "world";
	
	-- Short messages	
	SS_MSGWELCOME = "|cffff0000SpamSentry|r|cffff9977 by Anea. Type |cffffffff/sentry|r |cffff9977for options. (%s)|r";
	SS_MSGFOUND = "|cffff9977* Alert: |r%s|cffff9977 tried to send you %s.";
	SS_MSGTEXT = "this message";
	SS_MSGCLEARED = "|cffff9977Reportlist has been cleared.|r";
	SS_MSGSHORTHELP = "|cffff0000SpamSentry|r|cffff9977 by Anea (%s)\nType: |r|cffffffff/sentry help | list | clear | notify | delete\n|r|cffffffff%s|r|cffff9977 spammer(s) lifetime. |r|cffffffff%s|r|cffff9977 spammer(s) on reportlist. Notification is |cffffffff%s|r|cffff9977.|r";
	SS_MSGREMOVEHELP = "|cffff9977Please give a valid index number to remove.|r";
	SS_MSGLINKHELP = "|cffff9977Please give a valid index number to associate with.|r";
	SS_MSGLINKOK = "|cffff9977Associated '%s' with index %s.|r";

	-- Channel messages
	SS_MSGCHANNELADDED = "|cffff9977Channel |cffffffff%s|r|cffff9977 added.|r";
	SS_MSGCHANNELREMOVED = "|cffff9977Channel |cffffffff%s|r|cffff9977 removed .|r";
	SS_MSGCHANNELADDHELP = "|cffff9977Channel %s |cffff9977not valid or already on list. Valid channels are: Whisper, Say, Yell|r";
	SS_MSGCHANNELCLEARED = "|cffff9977All channels have been cleared.|r";

	-- Report messages	
	SS_MSGREPLIST = "|cffff9977Blocked message(s):|r";
	SS_MSGREPEMPTY = "|cffff9977No blocked message(s)|r";
	SS_MSGREPNONE = "Nothing to report";
	SS_MSGREPOPENTICKETS = "Still open tickets...";
	SS_MSGREPORTNOW = "|cffff9977One or more spammers have been blocked. Click|r %s |cffff9977to report them to a GM.|r";
	SS_MSGHERE = "here";
	SS_MSGREPORTTEXT = "Dear GM,\n\nThe following characters have been trying to sell me gold for real money.\n\nBest regards,\n\n%s\n\n---\n%s";
	SS_MSGREPMANUAL = "|cffdd0000Report Spam|r";
	NEWBIE_TOOLTIP_UNIT_SPAMSENTRY = "Adds the last message from this player to the SpamSentry reportlist.";
	SS_MSGREPMANUALBLOCK = "|cffff9977Message from |r|cffffffff%s|r|cffff9977 has been added to the reportlist.|r";
	SS_MSGREPNOCACHE = "|cffff9977No messages from |r|cffffffff%s|r|cffff9977 cached.|r";

	-- Bot report messages	
	NEWBIE_TOOLTIP_UNIT_SPAMSENTRYBOT = "Report this player as a bot.";
	SS_MSGREPMANUALBOT = "|cffdd0000Report Bot|r";
	SS_MSGREPORTTEXTBOT = "Dear GM,\n\nToday at %s I found %s farming at %s. The way this character acted and moved appeared to be automated/scripted. Therefor I would like to report this player as a bot. Please contact me for details.\n\nBest regards,\n\n%s";
	SS_MSGBOTENABLED = "|cffff9977Bot reporting enabled|r";
	SS_MSGBOTDISABLED = "|cffff9977Bot reporting disabled|r";

	-- Notification options	
	SS_OFF = "off";
	SS_HOURLY = "hourly";
	SS_NORMAL = "always";
	SS_DEBUG = "debug";
	SS_MSGNOTIFYOFF = "|cffff9977Notification has been turned off.|r";
	SS_MSGNOTIFYHOURLY = "|cffff9977Notification has been set to an hourly reminder.|r";
	SS_MSGNOTIFYNORMAL = "|cffff9977Notification has been set to always. You will receive a warning each time a message has been blocked.|r";
	SS_MSGNOTIFYDEBUG = "|cffff9977Notification has been set to debugging.|r";

	-- GUI texts
	SS_GUIREPORTHELP = "|cffff0000Note: Double check characters before reporting them!|r";
	SS_GUITITLE = "SpamSentry";
	SS_GUISEND = "Send";
	SS_GUIRESET = "Reset";
	SS_GUICLOSE = "Close";

	-- Commands
	SS_CMDLINK = "link";
	SS_CMDDELETE = "delete";
	SS_CMDREPLIST = "list";
	SS_CMDREPREPORT = "report";
	SS_CMDREPCLEAR = "clear";
	SS_CMDNOTIFY = "notify";
	SS_CMDCHANNELLIST = "channellist";
	SS_CMDCHANNELADD = "channeladd";
	SS_CMDCHANNELREMOVE = "channelremove";
	SS_CMDCHANNELCLEAR = "channelclear";
	SS_CMDHELP = "help";
	SS_CMDBOT = "bot";

	-- Help texts
	SS_MSGHELP1 = "|cffff0000SpamSentry |r|cffff9977by Anea|r";
	SS_MSGHELP2 = "|cffff9977This addon automatically blocks incoming spam from goldsellers on whisper, say and yell.|r";
	SS_MSGHELP3 = "|cffff9977* To view the list of recently blocked characters, type: |r|cffffffff/sentry list|r";
	SS_MSGHELP4 = "|cffff9977* To report the recently blocked characters, type: |r|cffffffff/sentry report|r";
	SS_MSGHELP5 = "|cffff9977* To clear the reportlist, type: |r|cffffffff/sentry clear|r";
	SS_MSGHELP6 = "|cffff9977* To toggle notification, type: |r|cffffffff/sentry notify hourly|always|off|r";
	SS_MSGHELP7 = "|cffff9977* To toggle bot-reporting, type: |r|cffffffff/sentry bot|r";
	SS_MSGHELP8 = "|cffff9977* Use the options |r|cffffffffchannellist|channeladd|channelremove|channelclear|r|cffff9977 to edit the monitored channels. Allowed channelnames are: |r|cffffffffWhisper, Say, Yell, Trade, General, LookingForGroup, World|r|cffff9977. By default only Whisper, Say, Yell are activated.|r";
	SS_MSGHELP9 = "|cffff9977* Right-click a name or playerframe and select 'Report Spam' to manually add this player to the reportlist.|r";
end

