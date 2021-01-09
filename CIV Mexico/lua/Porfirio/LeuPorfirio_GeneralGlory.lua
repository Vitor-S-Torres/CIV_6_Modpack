--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================

--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
print("Mexico Great Artist Burst from Great Generals Expending script loaded")
--==========================================================================================================================
-- Variables
--==========================================================================================================================

local iTrait = "TRAIT_LEADER_LEU_PORFIRIO"
-- Values
local requiredUnitType = "UNIT_GREAT_GENERAL"
local iEraScore = 1
local iTileRange = 2



--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
--<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
--==========================================================================================================================
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- UTILS
----------------------------------------------------------------------------------------------------------------------------
iMod = (GameInfo.GameSpeeds[GameConfiguration.GetGameSpeedType()].CostMultiplier)/100;

--Chrisy's Valid Trait getter
function C15_GetValidTraitPlayersNew(sTrait)
    local tValid = {}
    for k, v in ipairs(PlayerManager.GetWasEverAliveIDs()) do
        local leaderType = PlayerConfigurations[v]:GetLeaderTypeName()
        for trait in GameInfo.LeaderTraits() do
            if trait.LeaderType == leaderType and trait.TraitType == sTrait then 
                tValid[v] = true 
            end;
        end
        if not tValid[v] then
            local civType = PlayerConfigurations[v]:GetCivilizationTypeName()
            for trait in GameInfo.CivilizationTraits() do
                if trait.CivilizationType == civType and trait.TraitType == sTrait then 
                    tValid[v] = true 
                end;
            end
        end
    end
    return tValid
end

-- Valid Unit Check
function Leu_PlotUnitCheck(pPlayer, iUnitTypeName, dX, dY)
	local playerUnits = pPlayer:GetUnits()
	for i, pUnit in playerUnits:Members() do
		if pUnit:GetX() == dX and pUnit:GetY() == dY then
			local unitTypeName = UnitManager.GetTypeName(pUnit);
			if unitTypeName == ("LOC_" .. iUnitTypeName .. "_NAME") then
				return true
			end
		end
	end
	return false
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
local tValidTrait = C15_GetValidTraitPlayersNew(iTrait)


function OnUnitKilled_GGCheck(killedPlayerID, killedUnitID, playerID, unitID)
	local player = Players[playerID]
	if not tValidTrait[playerID] then return end
	local ripPlayer = Players[killedPlayerID]
	local kUnit = ripPlayer:GetUnits():FindID(killedUnitID);
	local vUnit = player:GetUnits():FindID(unitID)
	if Leu_PlotUnitCheck(player, requiredUnitType, vUnit:GetX(), vUnit:GetY()) then
		print("Found the required unit")
		Game.GetEras():ChangePlayerEraScore(playerID, iEraScore)
		Game.AddWorldViewText(playerID, Locale.Lookup("[COLOR_FLOAT_GOLD]+" .. iEraScore .. "[ICON_Glory_Golden_Age][ENDCOLOR]"), vUnit:GetX(), vUnit:GetY(), 1)
	end
end


--Events.UnitKilledInCombat.Add(OnUnitKilled_GGCheck);


--==========================================================================================================================
--==========================================================================================================================