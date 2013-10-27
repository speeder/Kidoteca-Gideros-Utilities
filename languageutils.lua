--- kidutils.languageutils.lua: This is a collection of localization utilities.
--- Author: Maurício Gomes 
---

local Json = require "json"

local system = {};



local systemLanguage;
local choosenLanguage;
local currentStringFile;

local allowedLanguages = {"en", "pt", "fr"};

function system.loadLanguageConfig()
	local lfile = io.open("|D|language", "rb");
	if not lfile then return nil end
	local result = lfile:read("*a");
	lfile:close();
	return result;
end

function system.saveLanguageConfig( value )
	local lfile = io.open("|D|language", "w");
	if not lfile then print("error opening file |D|language"); return false; end
	lfile:write( tostring(value) );
	lfile:close();
	return true;
end

function system.getSystemLanguage()
	systemLanguage = application:getLocale();
	for ix, el in ipairs(allowedLanguages) do
		if string.match(systemLanguage, el) then
			systemLanguage = string.match(systemLanguage, el);
			break;
		end
		
		if ix == #allowedLanguages and el ~= systemLanguage then
			systemLanguage = "en";
		end
	end
	return systemLanguage;
end

function system.getChoosenLanguage()
	choosenLanguage = system.loadLanguageConfig();
	return choosenLanguage;
end

function system.getLanguage()
	return system.getChoosenLanguage() or system.getSystemLanguage();
end

function system.addAllowedLanguages( input )
	if type(input) == "string" then
		allowedLanguages[#allowedLanguages + 1] = input;
		return;
	else --input is a table
		for ix, el in ipairs(input) do
			allowedLanguages[#allowedLanguages + 1] = el;	
		end
		return;
	end
end

function system.getStringFile( fileName )
	local lfile = io.open(fileName, "rb");
	if not lfile then
		print("file not found", fileName);
		return false;
	end
	
	local fileContents = lfile:read("*a");
	lfile:close();
	return json.Decode(fileContents);
end

function system.getString( stringName, stringFile )
	--[[if not stringFile then
		stringFile = currentStringFile;
	end]]
	
	return stringFile[choosenLanguage][stringName];
end

return system;