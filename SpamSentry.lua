-- SpamSentry by Anea
-- A mod that blocks incoming whispers from goldsellers
--
--------------------------------------------------------------

local SS_CurrentVersion = 20160908;

---------
-- Blacklist
-- Add keywords/patterns to this list to be used in the process of checking
local SS_BlackList = {
                "dollar",
                "euro",
                "pounds",
                "usd",
                "$%d+.+%d+g",
                "%d+g.+$%d+",
                "\226\130\172%d+.+%d+g",
                "%d+g.+\226\130\172%d+",
                "\194\163%d+.+%d+g",
                "%d+g.+\194\163%d+",

                "cheap",
                "visit",
                "buy",

                "http",
                "www",
                "[,.]com",

                "gmworker",
                "itembay",
                "player123",
                "wowforever",
                "gmworking",
                "wowcoming",
                "29games",
                "ogs365",
                "wowsupplier",
                "gamenoble",
                "wowfreebuy",
                "wowgoldsky"
               };

---------
-- Do not edit below this line

---------
-- Pattern for stripping spacers from messages.
local SS_Strip = "[^%w$\194\163\226\130\172=,.]+";

SS_Notify = 2;          -- 0=off, 1=hourly, 2=normal, 3=debug
local SS_VariablesLoaded = false;

local SS_OrigChatFrame_OnEvent;
local SS_OrigSetItemRef;
local SS_OrigUnitPopup_OnClick;
local SS_OrigFriendsFrame_OnEvent;

local SS_Message = {};							-- Messages under investigation
local SS_Character = {};						-- List with characters
local SS_CharacterBlackList = {};		-- Blacklisted characters for this session
SS_IgnoreList = {};									-- Characters who have temporarily been placed on the system ignorelist
SS_ReportList = {};									-- Characters and messages that have been caught

local SS_LastPlayer = "";
local SS_ChatHistory = {};					-- Chat cache

local SS_CheckReportLast = 0;   
local SS_SpammerAdded = false;  -- Update reportlist when a spammer has been added to the list

SS_Counter = 0;  -- Total number of blocked messages

local SS_GuildList={};
SS_Version = 0;
SS_ChannelList = {};
SS_EnableBotReport = false;
          
---------
-- Core functions and hooking

-- Register events
function SS_OnLoad()
  -- Register events event
  this:RegisterEvent("GUILD_ROSTER_UPDATE");
  this:RegisterEvent("PLAYER_GUILD_UPDATE");
  this:RegisterEvent("PARTY_MEMBERS_CHANGED");
  this:RegisterEvent("PLAYER_LOGIN");
  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  
  -- Add entry to the unit-pop-up menu's
  UnitPopupButtons["SPAMSENTRY"] = { text = SS_MSGREPMANUAL, dist = 0 }
  table.insert(UnitPopupMenus["PLAYER"], 8, "SPAMSENTRY");
  table.insert(UnitPopupMenus["FRIEND"], 4, "SPAMSENTRY");

  -- Initialise guild/party lists
  SS_UpdateGuildList();
  SS_UpdatePartyList();
end

-- Hook functions and load more variables
function SS_Loaded()
  if (not SS_VariablesLoaded) then
  	SS_Msg(3, "Loading settings");
		if (SS_Version == 0) then
			SS_ChannelList = { 
								 [1] = SS_WHISPER,
								 [2] = SS_SAY,
								 [3] = SS_YELL
								};
		end

    -- Hook the Chatframe OnEvent function.
    SS_OrigChatFrame_OnEvent = ChatFrame_OnEvent;
    ChatFrame_OnEvent = SS_ChatFrame_OnEvent;

    -- Hook the ItemLink OnEvent function
    SS_OrigSetItemRef = SetItemRef;
    SetItemRef = SS_SetItemRef;

    -- Hook the FriendsFrame OnEvent function
    SS_OrigFriendsFrame_OnEvent = FriendsFrame_OnEvent;
    FriendsFrame_OnEvent = SS_FriendsFrame_OnEvent;

    -- Hook the unit-pop-up menu's
    SS_OrigUnitPopup_OnClick = UnitPopup_OnClick;
    UnitPopup_OnClick = SS_UnitPopup_OnClick;
    
    -- Check version, update variables
    SS_CheckVersion();
    
    -- Clear the ignorelist from last session
    SS_IgnoreClear();
    
    -- Bot report hook
		SS_EnableBotRep();
		
    SS_VariablesLoaded = true;
    SS_Msg(1, format(SS_MSGWELCOME, SS_CurrentVersion));
  end
end

-- Event hooking
function SS_OnEvent(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)
  if (event=="GUILD_ROSTER_UPDATE" or event=="PLAYER_GUILD_UPDATE") then
    SS_UpdateGuildList();
  elseif (event=="PARTY_MEMBERS_CHANGED") then
    SS_UpdatePartyList();
  elseif (event=="PLAYER_LOGIN") then
    SS_UpdateGuildList();
    SS_UpdatePartyList();
  elseif (event=="PLAYER_ENTERING_WORLD") then
    SS_Loaded();
  end
end

-- Chat message event
function SS_ChatFrame_OnEvent(event)
  local msg = arg1;
  local plr = arg2;
  local chn = arg4;
  local didcheck = false;

  if (SS_ChannelList and msg and plr) then
    for index,channel in ipairs(SS_ChannelList) do
      channel = strlower(channel);
      if (channel == SS_WHISPER and strfind(event, "CHAT_MSG_WHISPER")) then
         SS_IsSpam(msg, plr, event);
         didcheck = true;
      elseif (channel == SS_SAY and strfind(event, "CHAT_MSG_SAY")) then
         SS_IsSpam(msg, plr, event);
         didcheck = true;
      elseif (channel == SS_YELL and strfind(event, "CHAT_MSG_YELL")) then
        SS_IsSpam(msg, plr, event);
        didcheck = true;
      elseif (channel == SS_TRADE and chn ~= nil) then
        if (strfind(event, "CHAT_MSG_CHANNEL")  and strfind(chn, SS_TRADE)) then
          SS_IsSpam(msg, plr, event);
          didcheck = true;    
        end
      elseif (channel == SS_GENERAL and chn ~= nil) then
        if (strfind(event, "CHAT_MSG_CHANNEL")  and strfind(chn, SS_GENERAL)) then
          SS_IsSpam(msg, plr, event);
          didcheck = true;
        end
      elseif (channel == SS_LFG and chn ~= nil) then
				if (strfind(event, "CHAT_MSG_CHANNEL")  and strfind(chn, SS_LFG)) then
					SS_IsSpam(msg, plr, event);
					didcheck = true;
				end
      elseif (channel == SS_WORLD and chn ~= nil) then
        if (strfind(event, "CHAT_MSG_CHANNEL")  and strfind(chn, SS_WORLD)) then
          SS_IsSpam(msg, plr, event);
          didcheck = true;
        end
      elseif (strfind(event, "CHAT_MSG_SYSTEM")) then
      	if (SS_IgnoreMsgSupress(msg)) then
      		return;
      	end
      end
    end
  end
  
  if (not didcheck) then
    SS_CallChatEvent(event);
  end
end

-- Hook to unit-pop-up menu's
function SS_UnitPopup_OnClick ()
  local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
  local val = this.value;
  local unit = dropdownFrame.unit;
  local name = dropdownFrame.name;

  -- Report spammer
  if (val == "SPAMSENTRY") then
    if (unit and not name) then
      name = UnitName(unit);
    end
    if (name and SS_ChatHistory[name]) then
      SS_RepAdd(name, SS_ChatHistory[name].message);
      SS_Msg(1, format(SS_MSGREPMANUALBLOCK, name));
    else
      SS_Msg(1, format(SS_MSGREPNOCACHE, name));
    end
  elseif(val == "SPAMSENTRYBOT") then
    if (unit and not name) then
      name = UnitName(unit);
    end
    SS_ReportBot(name);
  else
    SS_OrigUnitPopup_OnClick();
  end
end

-- Hook to the who-function
function SS_FriendsFrame_OnEvent()
  if (event=="WHO_LIST_UPDATE") then
    SS_IsSpam2(event);
  else
    SS_OrigFriendsFrame_OnEvent(event);
  end
end


---------
-- Spam check

--Checks the message for spam. Scores are assigned for various characteristics
-- Returns true on spam, returns false otherwise
function SS_IsSpam(msg, plr, evt)
  -- Hook to messaging and garbage collection
  SS_CheckWhoCooldown();
  SS_CheckReport();
  
  -- You self are whitelisted!
  if (strsub(event, 10) == "WHISPER_INFORM") then
    SS_CallChatEvent(evt);
    return;
  end
  
  -- Player on Character blacklist has spammed before and is ignored now
  if (SS_InList(SS_CharacterBlackList, plr)) then
    return;
  end
  
  -- Player in your party/raid is white-listed
  if (SS_InList(SS_PartyList, plr)) then
    SS_CallChatEvent(evt);
    return;
  end
  
  -- Player on your friends-list is white-listed
  local numfriends = GetNumFriends();
  for i=1, numfriends, 1 do
    fn, fl, fcl, fa, fco, fs = GetFriendInfo(i);
    if (fn == plr) then
      SS_CallChatEvent(evt);
      return;
    end
  end
  
  -- Player in your guild is white-listed
  if (SS_InList(SS_GuildList, plr)) then
    SS_CallChatEvent(evt);
    return;
  end

  -- GM is whitelisted
  if(strlen(arg6) > 0) then
    local flag = TEXT(getglobal("CHAT_FLAG_"..arg6));
    if (flag == CHAT_FLAG_GM) then
      SS_CallChatEvent(evt);
      return;
    end
  end
  
  -- Suppress message if it is identical to the previous message send by this player within 5 seconds
  -- This is just a feature to prevent spam. We are not reporting players for just being anoying.
  if(SS_ChatHistory[plr] and SS_ChatHistory[plr].message==msg and (SS_ChatHistory[plr].time+5<time())) then
    return;
  end
  
  local tmsg = string.lower(string.gsub(msg, SS_Strip, ""));  -- Remove all spacers
  local sc = 0;
  
  -- Blacklist items score -0.1 point for the first one, -0.2 for the next, -0.4 for the one after, etc.
  for index,item in ipairs(SS_BlackList) do
    if (strfind(strlower(tmsg), strlower(item))) then 
      if(sc==0) then
        sc = -0.1;
      else
        sc = sc * 2;
      end
    end
  end

  SS_AddChatHistory(plr, msg);
  
  -- Check if the player has been queried before. If so, no need to do a who-query again.
  -- This lowers server-load and prevents messages passing through when spammed fast after each other
  -- See above for details on scores
  if (SS_Character[plr]) then
    local tsc = sc;
    if (SS_Character[plr].level and SS_Character[plr].level <10) then
      tsc = tsc * 2;
    else
      tsc = tsc + 0.1;
    end
    if (SS_Character[plr].guild and SS_Character[plr].guild~="") then
      tsc = tsc + 0.3;
    end
    if(tsc < 0) then
      SS_SpammerFound(plr, msg);
    else
      SS_CallChatEvent(evt);
    end
  -- If no negative score has been found, there's no reason to do a who-query.
  -- This should prevent Bank / Auction and other windows from closing most of the time.
  elseif (sc == 0) then
    SS_CallChatEvent(evt);
  -- Send who-query only if we aren't already waiting for results on this player
  elseif (not (SS_Message[plr] and SS_Message[plr].waiting)) then
    -- Cache current environment
    SS_Message[plr] = { name = plr,
                        waiting = true,
                        message = msg,
                        score = sc,
                        time = GetTime(),
                        args = {  [1] = this,
                                  [2] = evt,
                                  [3] = arg1,
                                  [4] = arg2,
                                  [5] = arg3,
                                  [6] = arg4,
                                  [7] = arg5,
                                  [8] = arg6,
                                  [9] = arg7,
                                  [10] = arg8,
                                  [11] = arg9
                                }
                        };
  
    SS_LastPlayer = plr;

    -- Send the who-stuff
    FriendsFrame:Hide();
    SetWhoToUI(1);
    SendWho("n-\""..plr.."\"");
  end
end

-- Gets called after the who-info is returned from the server
-- Continues the checking for spam.
function SS_IsSpam2(event)
  -- Get some info about guild, party and level
  local plrname = "";
  local plrlevel = 1;
  local plrguild = "";
  local plrrace, plrclass, plrzone, unknown;
  local score = 0;

  local count = GetNumWhoResults();
  for i=1, count, 1 do
    plrname, plrguild, plrlevel, plrrace, plrclass, plrzone, unknown = GetWhoInfo(i);
    
    if(plrname and plrname ~= "" and SS_Message[plrname] and SS_Message[plrname].waiting) then
      score = SS_Message[plrname].score;
            
      -- Cache the results
      SS_Character[plrname] = { guild = plrguild,
                                level = plrlevel
                              };

      -- Double the current (negative) score if the player-level is below 10.
      if (not plrlevel or plrlevel<10) then
        score = score * 2;
      else
        score = score + 0.1;  -- Refund if player is above level 10
      end
      -- Player in any other guild scores +0.3 points
      if (plrguild ~= nil and plrguild~= "") then
        score = score + 0.3;
      end
      
      break;
    end
  end
  
  SetWhoToUI(0);

  -- If the player has gone offline, then plrname will be nil.
  if (plrname == nil or plrname == "") then
    -- If we're still waiting for results from the last query, then assume that the player offline
    if (SS_Message[SS_LastPlayer] and SS_Message[SS_LastPlayer].waiting) then
      plrname = SS_LastPlayer;
      score = SS_Message[plrname].score;
    end
  end

  -- Suppress message if score is below 0
  if (score < 0) then
    SS_SpammerFound(plrname, SS_Message[plrname].message);
    SS_Message[plrname].waiting=false;
  -- Show message if score is above 0, and we were waiting for a who-query
  elseif (SS_Message and SS_Message[plrname] and SS_Message[plrname].waiting) then
    SS_CallOldChatEvent(plrname);
    SS_Message[plrname].waiting=false;
  -- Otherwise: this was a user-initiated who-request, pass the who-info to system.
  else
    SS_OrigFriendsFrame_OnEvent(event);
  end
end

-- Called when a spammer is found
function SS_SpammerFound(plrname, msg)
  local realm = tostring(GetRealmName());
  SS_RepAdd(plrname, msg);
  if (SS_Notify >= 1) then
    local entry = getn(SS_ReportList[realm]);
    local text = format(SS_MSGFOUND, SS_PlayerLink(plrname), SS_MessageLink(SS_MSGTEXT,entry));
    SS_Msg(2, text);
    SS_CheckReportLast = 0;
    SS_CheckReport();
    PlaySound("QUESTLOGOPEN");
  end
end

-- Removes players from waitlist if they've been on it for more then 0.5 seconds
function SS_CheckWhoCooldown()
  if (SS_Message) then
    for i=1, getn(SS_Message), 1 do
      name = SS_Message[i].name;
      if (SS_Message[i].waiting and (SS_Message[i].time < GetTime() - 0.5) ) then 
        if (SS_Message[i].score < 0) then
          SS_SpammerFound(name, SS_Message[i].message);
        else
          SS_CallOldChatEvent(plrname);
        end
        tremove(SS_Message, i);
      elseif (not SS_Message[i].waiting) then
        tremove(SS_Message, i);
      end
    end
  end
end

--------
-- Chatevents

-- Outgoing chatevents
function SS_CallChatEvent(event)
  SS_OrigChatFrame_OnEvent(event);
end

-- Called when a chat-event needs to be thrown while being in a who-event.
function SS_CallOldChatEvent(plrname)
  sthis, sevent, sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8, sarg9 = this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9;

  this = SS_Message[plrname].args[1];
  event = SS_Message[plrname].args[2];
  arg1 = SS_Message[plrname].args[3];
  arg2 = SS_Message[plrname].args[4];
  arg3 = SS_Message[plrname].args[5];
  arg4 = SS_Message[plrname].args[6];
  arg5 = SS_Message[plrname].args[7];
  arg6 = SS_Message[plrname].args[8];
  arg7 = SS_Message[plrname].args[9];
  arg8 = SS_Message[plrname].args[10];
  arg9 = SS_Message[plrname].args[11];

  SS_CallChatEvent(event);

  this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = sthis, sevent, sarg1, sarg2, sarg3, sarg4, sarg5, sarg6, sarg7, sarg8, sarg9;
end

---------
-- Guild/Party cache functions
-- Guildmembers and party are cached for performance reasons

function SS_UpdateGuildList()
  SS_GuildList = {};
  for i=1,GetNumGuildMembers(true),1 do
    name = GetGuildRosterInfo(i);
    tinsert(SS_GuildList, name);
  end
end

function SS_UpdatePartyList()
  SS_PartyList = {};
  if (UnitInRaid("player")) then
    for i=1,GetNumRaidMembers(),1 do
      name = GetRaidRosterInfo(i);
      tinsert(SS_PartyList, name);
    end
  else
    for i=1,GetNumPartyMembers(),1 do
      name = UnitName("party"..tostring(i));
      tinsert(SS_PartyList, name);
    end
  end
end

---------
-- Chat history cache function
function SS_AddChatHistory(plr, msg)
  -- Remove messages older then 30 minutes
  for i=1, getn(SS_ChatHistory), 1 do
    local t = time();
    if(SS_ChatHistory[i].time < t - 1800) then
      tremove(SS_ChatHistory,i);
    end
  end

  SS_ChatHistory[plr] =  {  message = msg,
                            time = time()
                          }; 
end


---------
-- Report functions
-- Covers both output to chatwindow and output to GUI
function SS_RepList()
  local realm = tostring(GetRealmName());
  local character, message;
  if (SS_ReportList and SS_ReportList[realm] and getn(SS_ReportList[realm])>0) then
    SS_Msg(0, SS_MSGREPLIST);
    for i=1, getn(SS_ReportList[realm]), 1 do
      character = SS_ReportList[realm][i].player;
      message = SS_ReportList[realm][i].message;
      if (strlen(message)>50) then
        message = strsub(message, 1, 50);
      end
      SS_Msg(0, format("* %s: |cffffffff%s ...|r" , SS_PlayerLink(character),message));
    end
  else
    SS_Msg(0, SS_MSGREPEMPTY);
  end
end

function SS_RepAdd(plr, msg)
  SS_IgnoreAdd(plr);
  local realm = tostring(GetRealmName());
  SS_Counter = SS_Counter + 1;
  if (not SS_InList(SS_CharacterBlackList, plr)) then
    tinsert(SS_CharacterBlackList, plr);
  end
  if(not SS_ReportList[realm]) then
  	SS_ReportList[realm] = {};
  end
  if (not SS_InList(SS_ReportList[realm], plr)) then
    local datetime = tostring(date());
    tinsert(SS_ReportList[realm], { player = plr,
                                    message = msg,
                                    time = datetime
                                  });
    SS_SpammerAdded = true;
  end
end

function SS_RepClear()
  local realm = tostring(GetRealmName());
  if(SS_ReportList and SS_ReportList[realm]) then
    SS_ReportList[realm] = {};
  end
  if(SS_CharacterBlackList) then
    SS_CharacterBlackList = {};
  end
  SS_IgnoreClear();
  SS_SpammerAdded = true;	-- Reset the report message
  SS_Msg(0, SS_MSGCLEARED);
end

function SS_CheckReport()
  local realm = tostring(GetRealmName());
  -- Show a warning once every hour.
  if(SS_ReportList and SS_ReportList[realm] and getn(SS_ReportList[realm])>0) then
    if (GetTime() - SS_CheckReportLast > 3600) then
      -- Create a clickable link. This is handled by the SS_SetItemRef function.
      local link = "|HSpamSentryTicket|h|cff8888ff["..SS_MSGHERE.."]|r|h";
      SS_Msg(1, format(SS_MSGREPORTNOW, link));
      PlaySound("QUESTLOGOPEN");
      SS_CheckReportLast = GetTime();
    end
  end
end

-- Show the SpamSentry ticketframe GUI
function SS_OpenTicket()
  local text = SS_MakeReport();
  if not ( HelpFrameOpenTicket.hasTicket ) then
    NewGMTicket(2, text);
    SS_RepClear();
  else
    -- A ticket is already pending, show message, do nothing.
    SS_Msg(0, SS_MSGREPOPENTICKETS);
  end
end

-- Create the report-text
function SS_MakeReport()
  local realm = tostring(GetRealmName());
  local text = SS_MSGREPNONE;
  local report = "";
  if (SS_ReportList and SS_ReportList[realm] and getn(SS_ReportList[realm])>0 ) then
    for i=1, getn(SS_ReportList[realm]), 1 do
      report = report .. format("%s\n[%s]: '%s'\n\n---\n",SS_ReportList[realm][i].time, SS_ReportList[realm][i].player, SS_ReportList[realm][i].message);
    end
    text = format(SS_MSGREPORTTEXT, UnitName("player"), report);
  end
  return text;
end

function SS_ResetReport()
  getglobal("SpamSentry_Text"):SetText(SS_MakeReport());
end

function SS_ShowGUI()
	SpamSentry_ButtonReset:Show();
  SpamSentryGUI:Show();
  local t = getglobal("SpamSentry_Text"):GetText();
  if(t==nil or t =="" or SS_SpammerAdded) then
    SS_SpammerAdded = false;
    SS_ResetReport();
  end
end

function SS_ReportBot(plr)
	local name = UnitName("player");
	local loc = GetZoneText()..", "..GetSubZoneText();
	local datetime = tostring(date());
	getglobal("SpamSentry_ButtonReset"):Hide();
	getglobal("SpamSentry_Text"):SetText(format(SS_MSGREPORTTEXTBOT, datetime, plr, loc, name));
	SS_SpammerAdded = true;  -- Makes sure the spam report text is regenerated.
	SpamSentryGUI:Show();
end

function SS_EnableBotRep()
	if (SS_EnableBotReport) then
		UnitPopupButtons["SPAMSENTRYBOT"] = { text = SS_MSGREPMANUALBOT, dist = 0 }
		table.insert(UnitPopupMenus["PLAYER"], 8, "SPAMSENTRYBOT");
		table.insert(UnitPopupMenus["FRIEND"], 4, "SPAMSENTRYBOT");
	else
		for i=1, getn(UnitPopupMenus["PLAYER"]),1 do
			if(UnitPopupMenus["PLAYER"][i] == "SPAMSENTRYBOT") then
				tremove(UnitPopupMenus["PLAYER"],i);
			end
		end
		for i=1, getn(UnitPopupMenus["FRIEND"]),1 do
			if(UnitPopupMenus["FRIEND"][i] == "SPAMSENTRYBOT") then
				tremove(UnitPopupMenus["FRIEND"],i);
			end
		end
	end
end

---------
-- Ignore functions
function SS_IgnoreAdd(plr)
	if (SS_Message[plr].args[2] == "CHAT_MSG_SAY" or SS_Message[plr].args[2] == "CHAT_MSG_YELL") then
		local realm = GetRealmName();
		local myname = UnitName("player");
		if(not SS_IgnoreList[realm]) then
			SS_IgnoreList[realm] = {};
		end
		if(not SS_IgnoreList[realm][myname]) then
			SS_IgnoreList[realm][myname] = {};
		end
		if(not SS_InList(SS_IgnoreList[realm][myname], plr)) then
			tinsert(SS_IgnoreList[realm][myname], plr);
			AddIgnore(plr);
		end
	end
end

function SS_IgnoreClear()
	local realm = GetRealmName();
	local myname = UnitName("player");
	if(SS_IgnoreList[realm] and SS_IgnoreList[realm][myname]) then
		local num = getn(SS_IgnoreList[realm][myname]);
		for i=1,num,1 do
			local plr = SS_IgnoreList[realm][myname][i];
			DelIgnore(plr);
		end
		SS_IgnoreList[realm][myname] = {};
	end
end

function SS_IgnoreMsgSupress(msg)
	local realm = GetRealmName();
	local myname = UnitName("player");
	if(SS_IgnoreList[realm] and SS_IgnoreList[realm][myname]) then
		for i=1, getn(SS_IgnoreList[realm][myname]), 1 do
			if (strfind(msg, SS_IgnoreList[realm][myname][i])) then
				return true;
			end
		end
	end
	return false;
end

---------
-- Channel functions


function SS_ChanList()
  foreachi(SS_ChannelList, function(i,v) SS_Msg(0, format("%s: |cffffffff%s|r" ,i,v)); end);
end

function SS_ChannelAdd(channel)
  local SS_AllowedChannel = {SS_WHISPER, SS_SAY, SS_YELL, SS_TRADE, SS_GENERAL, SS_LFG, SS_WORLD};
  channel = strlower(channel);
  if (SS_InList(SS_AllowedChannel, channel) and not SS_InList(SS_ChannelList, channel)) then
    SS_Msg(0, format(SS_MSGCHANNELADDED, channel));
    tinsert(SS_ChannelList, channel);
  else
    SS_Msg(0, format(SS_MSGCHANNELADDHELP, channel));
  end
end

function SS_ChannelRemove(index)
  local name;
  if (SS_ChannelList[index]~= nil) then
    name = SS_ChannelList[index];
    SS_Msg(0, format(SS_MSGCHANNELREMOVED, name)); 
    tremove(SS_ChannelList, index);
  end
end

function SS_ChannelClear()
  SS_ChannelList={};
  SS_Msg(0, SS_MSGCHANNELCLEARED);
end

---------
-- Generic functions

function SS_Msg(level, text)
  if (level <= SS_Notify) then
    local chatframe = DEFAULT_CHAT_FRAME;
    if text ~= nil then
      chatframe:AddMessage(text);
    end
  end
end

function SS_InList(list, item)
  if (list ~= nil and item~=nil) then
    for i,v in ipairs(list) do
      if (type(v)=="table") then
        if (SS_InList(v, item)) then
          return true;
        end
      elseif (strlower(v)==strlower(item)) then 
        return true;
      end
    end
  end
  return false;
end

-- Remove all links from text
function SS_ClearLink(text)
  local link = text;
  local l_start = strfind(text, "[", 1, true);
  local l_end = strfind(text, "]", 1, true);
  if (l_start and l_end) then
    link = strsub(text, l_start+1, l_end-1);
  end
  return link;
end

-- Create a link to a playername
function SS_PlayerLink(link)
  local type = "player:"..link;
  return "|H"..type.."|h|cffffff00["..link.."]|r|h";
end

-- Create a link to a SpamSentry message
function SS_MessageLink(link, entry)
  local type= "SpamSentryMsg:"
  return "|H"..type.."_"..entry.."|h|cff8888ff["..link.."]|r|h";
end

-- This function hooks into clickable chatlinks. It does some action if special SpamSentry links are found.
function SS_SetItemRef(link, text, button)
  local realm = tostring(GetRealmName());
  if ( strsub(link, 1, 16) == "SpamSentryTicket" ) then
    SS_ShowGUI();
  elseif ( strsub(link, 1, 13) == "SpamSentryMsg") then
    local s,e,entry = string.find(link, "(%d+)");
    entry = tonumber(entry);
    if(SS_ReportList[realm][entry]) then
      SS_Msg(0, "* "..SS_PlayerLink(SS_ReportList[realm][entry].player)..": |cffff55ff"..SS_ReportList[realm][entry].message.."|r");
    end
  else
    SS_OrigSetItemRef(link, text, button);
  end
end

-- Toggle notification level
function SS_ToggleNotification(level)
  if (level == SS_OFF) then
     SS_Notify = 0;
     SS_Msg(0, SS_MSGNOTIFYOFF);
  elseif (level == SS_HOURLY) then
    SS_Notify = 1;
    SS_Msg(0, SS_MSGNOTIFYHOURLY);
  elseif (level == SS_NORMAL) then
    SS_Notify = 2;
    SS_Msg(0, SS_MSGNOTIFYNORMAL);
  elseif (level == SS_DEBUG) then
    SS_Notify = 3;
    SS_Msg(0, SS_MSGNOTIFYDEBUG);
  end
end


-------
-- Update variables and stuff for new versions.
function SS_CheckVersion()
  if (SS_Version and SS_Version < 20061108) then
    if(SS_Notify == 3) then
      SS_Notify = 2;
    end
    if (SS_ReportList and getn(SS_ReportList)>0) then
      local realm = tostring(GetRealmName());
      local t = SS_ReportList;
      SS_ReportList = {};
      SS_ReportList[realm] = t;
    end
  elseif(SS_Version and SS_Version < 20061118) then
  	if (GetLocale()=="frFR") then
  		for i=1, getn(SS_ChannelList), 1 do
  			if (SS_ChannelList[i] =="whisper") then SS_ChannelList[i] = SS_WHISPER;
  			elseif (SS_ChannelList[i] =="say") then SS_ChannelList[i] = SS_SAY;
  			elseif (SS_ChannelList[i] =="yell") then SS_ChannelList[i] = SS_YELL;
  			elseif (SS_ChannelList[i] =="trade") then SS_ChannelList[i] = SS_TRADE;
  			elseif (SS_ChannelList[i] =="general") then SS_ChannelList[i] = SS_GENERAL;
  			elseif (SS_ChannelList[i] =="lookingforgroup") then SS_ChannelList[i] = SS_LFG;
  			end
  		end
  	end
  end
  SS_Version = SS_CurrentVersion;
end

-------
-- Slash command stuff

SlashCmdList["SpamSentryCOMMAND"] = function(msg)
  local realm = tostring(GetRealmName());
  local text;
  if(msg == "") then
    repcount = 0;
    if (SS_ReportList and SS_ReportList[realm]) then
      repcount = getn(SS_ReportList[realm]);
    end
    local noti = {SS_OFF, SS_HOURLY, SS_NORMAL, SS_DEBUG}
    text = string.format(SS_MSGSHORTHELP, tostring(SS_CurrentVersion), tostring(SS_Counter), tostring(repcount), tostring(noti[SS_Notify+1]));
    SS_Msg(0, text);
  else
    local args = {};
    local word;
    for word in string.gfind(msg, "[^%s]+") do
      tinsert(args, word);
    end
    
    local cmd = string.lower(args[1]);
    if cmd == SS_CMDREPLIST then
      SS_RepList();
    elseif cmd == SS_CMDREPREPORT then
      SS_ShowGUI();
    elseif cmd == SS_CMDREPCLEAR then
      SS_RepClear();
    elseif cmd == SS_CMDNOTIFY then
      SS_ToggleNotification(args[2]);
    elseif cmd == SS_CMDCHANNELLIST then
      SS_Msg(0, "Channels:");
      SS_ChanList();
    elseif cmd == SS_CMDCHANNELADD then
      if args[2]~= nil then
        local channel = table.concat(args, " ", 2);
        SS_ChannelAdd(channel);
      else
        SS_Msg(0, SS_MSGCHANNELADDHELP ,"''");
      end
    elseif cmd == SS_CMDCHANNELREMOVE then
      if args[2]~= nil and tonumber(args[2]) ~= nil then
        SS_ChannelRemove(tonumber(args[2]));
      else
        SS_Msg(0, SS_MSGREMOVEHELP);
      end
    elseif cmd == SS_CMDCHANNELCLEAR then
      SS_ChannelClear();
    elseif cmd == SS_CMDBOT then
    	SS_EnableBotReport = not SS_EnableBotReport;
    	if (SS_EnableBotReport) then
    		SS_Msg(0, SS_MSGBOTENABLED);
    	else
    		SS_Msg(0, SS_MSGBOTDISABLED);
    	end
    	SS_EnableBotRep();
    elseif cmd == SS_CMDHELP then
      SS_Msg(0, SS_MSGHELP1);
      SS_Msg(0, SS_MSGHELP2);
      SS_Msg(0, SS_MSGHELP3);
      SS_Msg(0, SS_MSGHELP4);
      SS_Msg(0, SS_MSGHELP5);
      SS_Msg(0, SS_MSGHELP6);
      SS_Msg(0, SS_MSGHELP7);
      SS_Msg(0, SS_MSGHELP8);
      SS_Msg(0, SS_MSGHELP9);
    end
  end
end

SLASH_SpamSentryCOMMAND1 = "/sentry";
SLASH_SpamSentryCOMMAND2 = "/spamsentry";