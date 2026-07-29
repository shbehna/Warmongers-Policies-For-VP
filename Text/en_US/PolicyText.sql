-- Policy tooltips. Each string starts from the Vox Populi text for that policy
-- so unchanged effects keep their exact wording.

--------------------
-- Tradition
--------------------

-- Justice: lost the garrison ranged strike, gained Great Person Points on kill.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Justice[ENDCOLOR][NEWLINE][ICON_BULLET]Killing a Unit grants [ICON_GREAT_PEOPLE] Great Person Points of a random type in your [ICON_CAPITAL] Capital equal to 75% of the killed Unit''s [ICON_STRENGTH] Combat Strength.[NEWLINE][ICON_BULLET][COLOR_POSITIVE_TEXT]{TXT_KEY_BUILDING_ROYAL_GUARDHOUSE}[ENDCOLOR] built in [ICON_CAPITAL] Capital (+3 [ICON_PRODUCTION] Production, +2 [ICON_STRENGTH] Defense, +50 Hit Points, +10% [ICON_SILVER_FIST] Military Supply from [ICON_CITIZEN] Population in all Cities, +1 [ICON_PRODUCTION] Production to all Councils and Forges, 1 [ICON_ENGINEER] Engineer Slot).'
WHERE Tag = 'TXT_KEY_POLICY_ARISTOCRACY_HELP';

-- Majesty: lost the Palace Garden Great Person Rate, gained the raze payout.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Majesty[ENDCOLOR][NEWLINE][ICON_BULLET]Razing a City grants +25 [ICON_FOOD] Food and +25 [ICON_PRODUCTION] Production in your [ICON_CAPITAL] Capital for each [ICON_CITIZEN] Citizen the City had when you captured it.[NEWLINE][ICON_BULLET]Specialists in the [ICON_CAPITAL] Capital consume half the normal amount of [ICON_FOOD] Food.[NEWLINE][ICON_BULLET][COLOR_POSITIVE_TEXT]{TXT_KEY_BUILDING_PALACE_GARDEN}[ENDCOLOR] built in [ICON_CAPITAL] Capital (+5 [ICON_FOOD] Food, -2 [ICON_HAPPINESS_3] Unhappiness from [ICON_URBANIZATION] Urbanization, 1 [ICON_GREAT_WORK] Great Work of Writing slot, 1 [ICON_WRITER] Writer Slot).'
WHERE Tag = 'TXT_KEY_POLICY_MONARCHY_HELP';

--------------------
-- Progress
--------------------

-- Organization: lost the flat Production, gained Settler production and a free Settler.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Organization[ENDCOLOR][NEWLINE][ICON_BULLET]+25% [ICON_PRODUCTION] Production toward Settlers, Workers and Trade Units.[NEWLINE][ICON_BULLET]A [COLOR_POSITIVE_TEXT]Settler[ENDCOLOR] appears near the [ICON_CAPITAL] Capital.[NEWLINE][ICON_BULLET]+1 [ICON_MOVES] Movement for Workers.'
WHERE Tag = 'TXT_KEY_POLICY_COLLECTIVE_RULE_HELP';

-- Liberty: lost the flat Gold, gained bonus Experience on purchase.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Liberty[ENDCOLOR][NEWLINE][ICON_BULLET]Units purchased with [ICON_GOLD] Gold start with +5 Experience, scaling with Era.[NEWLINE][ICON_BULLET]+25% Tile Improvement Rate.[NEWLINE][ICON_BULLET]A [COLOR_POSITIVE_TEXT]Worker[ENDCOLOR] appears near the [ICON_CAPITAL] Capital.'
WHERE Tag = 'TXT_KEY_POLICY_CITIZENSHIP_HELP';

-- Expertise: gained the garrison ranged strike and Great General points on kill.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Expertise[ENDCOLOR][NEWLINE][ICON_BULLET]Cities with a garrison gain +25% [ICON_RANGE_STRENGTH] Ranged Combat Strength.[NEWLINE][ICON_BULLET]Killing a Unit grants [ICON_GREAT_GENERAL] Great General and [ICON_GREAT_ADMIRAL] Great Admiral Points equal to 25% of the killed Unit''s [ICON_STRENGTH] Combat Strength.[NEWLINE][ICON_BULLET]+15% [ICON_PRODUCTION] Production toward Buildings.[NEWLINE][ICON_BULLET]Cities earn +10 [ICON_CULTURE] Culture when they construct Buildings, scaling with Era.'
WHERE Tag = 'TXT_KEY_POLICY_REPUBLIC_HELP';

-- Equality: the flat Happiness now requires a defended City.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Equality[ENDCOLOR][NEWLINE][ICON_BULLET]+1 [ICON_HAPPINESS_1] Happiness in Cities with at least 10 [ICON_STRENGTH] Strength, and +1 [ICON_HAPPINESS_1] Happiness for every 15 [ICON_CITIZEN] Citizens in a City.[NEWLINE][ICON_BULLET]-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_FOOD] and [ICON_PRODUCTION] Distress, [ICON_GOLD] Poverty, [ICON_RESEARCH] Illiteracy, and [ICON_CULTURE] Boredom in all Cities.'
WHERE Tag = 'TXT_KEY_POLICY_REPRESENTATION_HELP';

-- Fraternity: gained the free units per 10 Citizens.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Fraternity[ENDCOLOR][NEWLINE][ICON_BULLET]Supply-free military Units spawn near Cities that reach (or have already reached) a multiple of 10 [ICON_CITIZEN] Citizens for the first time.[NEWLINE][ICON_BULLET]+3 [ICON_FOOD] Food in every City.[NEWLINE][ICON_BULLET]+3 [ICON_RESEARCH] Science from [ICON_CONNECTED] City Connections.'
WHERE Tag = 'TXT_KEY_POLICY_MERITOCRACY_HELP';

--------------------
-- Authority
--------------------

-- Imperium: gained the military unit production modifier.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Imperium[ENDCOLOR][NEWLINE][ICON_BULLET]+20% [ICON_PRODUCTION] Production toward Military Units.[NEWLINE][ICON_BULLET]Cities gain 20 [ICON_PRODUCTION] Production and [ICON_GOLD] Gold when their borders expand, scaling with Era ([COLOR_YELLOW]40 if all {TXT_KEY_POLICY_BRANCH_HONOR} policies are adopted[ENDCOLOR]).[NEWLINE][ICON_BULLET]Receive 40 [ICON_RESEARCH] Science and [ICON_CULTURE] Culture when you found or conquer Cities, scaling with Era. Conquest bonus also scales based on City [ICON_CITIZEN] population.'
WHERE Tag = 'TXT_KEY_POLICY_DISCIPLINE_HELP';

-- Tribute: lost the free Settler, gained bullying strength and yields from unit production.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Tribute[ENDCOLOR][NEWLINE][ICON_BULLET]+15% Bullying strength against [ICON_CITY_STATE] City-States.[NEWLINE][ICON_BULLET]Cities earn [ICON_RESEARCH] Science and [ICON_CULTURE] Culture equal to 10% of the [ICON_PRODUCTION] Production cost of every Unit they train.[NEWLINE][ICON_BULLET]Gain [ICON_CULTURE] Culture in [ICON_CAPITAL] Capital equal to 25% of the Gold Tribute demanded from City-States ([COLOR_YELLOW]50% if all {TXT_KEY_POLICY_BRANCH_HONOR} policies are adopted[ENDCOLOR]).'
WHERE Tag = 'TXT_KEY_POLICY_WARRIOR_CODE_HELP';

-- Militarism: gained Experience from pillaging.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Militarism[ENDCOLOR][NEWLINE][ICON_BULLET]All Military Units gain the [COLOR_POSITIVE_TEXT]{TXT_KEY_PROMOTION_WMP_PLUNDERER}[ENDCOLOR] Promotion (+5 Experience from pillaging).[NEWLINE][ICON_BULLET]+1 [ICON_HAPPINESS_1] Happiness, +2 [ICON_PRODUCTION] Production and +2 [ICON_CULTURE] Culture in Cities with at least 10 [ICON_STRENGTH] Strength.[NEWLINE][ICON_BULLET]-15% [ICON_GOLD] Unit Maintenance.[NEWLINE][ICON_BULLET]-50% [ICON_GOLD] Route Maintenance.'
WHERE Tag = 'TXT_KEY_POLICY_MILITARY_TRADITION_HELP';

-- Honor: lost the free units per 10 Citizens (moved to Fraternity).
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Honor[ENDCOLOR][NEWLINE][ICON_BULLET]All Military Units gain the [COLOR_POSITIVE_TEXT]{TXT_KEY_PROMOTION_CONSCRIPTION}[ENDCOLOR] Promotion (+10% [ICON_STRENGTH] Combat Strength).[NEWLINE][ICON_BULLET]-25% [ICON_WAR] War Weariness.'
WHERE Tag = 'TXT_KEY_POLICY_PROFESSIONAL_ARMY_HELP';

--------------------
-- Fealty
--------------------

-- Nobility: lost the Armory Gold, gained healing in enemy territory.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Nobility[ENDCOLOR][NEWLINE][ICON_BULLET]All Military Units gain the [COLOR_POSITIVE_TEXT]{TXT_KEY_PROMOTION_WMP_CRUSADER}[ENDCOLOR] Promotion (heals 5 additional HP per turn in enemy territory).[NEWLINE][ICON_BULLET]+1 [ICON_HAPPINESS_1] Happiness and +2 [ICON_GOLD] Gold from Castles.[NEWLINE][ICON_BULLET]+100% [ICON_PRODUCTION] Production towards Castles and Armories.'
WHERE Tag = 'TXT_KEY_POLICY_MANDATE_OF_HEAVEN_HELP';

-- Organized Religion: lost the Temple Culture, gained yields from fallen units.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Organized Religion[ENDCOLOR][NEWLINE][ICON_BULLET]When one of your Units is killed, gain [ICON_PEACE] Faith and [ICON_CULTURE] Culture equal to its [ICON_STRENGTH] Combat Strength multiplied by its Level.[NEWLINE][ICON_BULLET]+25% Pressure from owned Cities following your [ICON_RELIGION] Primary Religion.[NEWLINE][ICON_BULLET]+1 [ICON_DIPLOMAT] Delegate in the World Congress for every 10 Cities following your [ICON_RELIGION] Primary Religion.'
WHERE Tag = 'TXT_KEY_POLICY_ORGANIZED_RELIGION_HELP';

--------------------
-- Statecraft
--------------------

-- Foreign Service: gained Influence when gifting Units.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Foreign Service[ENDCOLOR][NEWLINE][ICON_BULLET]+10 [ICON_INFLUENCE] Influence when you gift Units to [ICON_CITY_STATE] City-States.[NEWLINE][ICON_BULLET]Receive 100 [ICON_SPY_POINT] Spy Points.[NEWLINE][ICON_BULLET]Earn [ICON_DIPLOMAT] Great Diplomats 50% faster.[NEWLINE][ICON_BULLET]+50% Rewards from [ICON_CITY_STATE] City-State Quests.'
WHERE Tag = 'TXT_KEY_POLICY_PHILANTHROPY_HELP';

--------------------
-- Artistry
--------------------

-- Humanism: gained healing when a Great Work is created.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Humanism[ENDCOLOR][NEWLINE][ICON_BULLET]All your Units heal 5 HP when a Great Work is created.[NEWLINE][ICON_BULLET]+3 [ICON_PEACE] Faith from [ICON_GW_WRITING] Great Works of Writing.[NEWLINE][ICON_BULLET]-25% [ICON_GOLDEN_AGE] Golden Age Points needed to trigger a [ICON_GOLDEN_AGE] Golden Age.[NEWLINE][ICON_BULLET]+1 [ICON_HAPPINESS_1] Happiness from all Guilds.'
WHERE Tag = 'TXT_KEY_POLICY_CULTURAL_CENTERS_HELP';

--------------------
-- Imperialism
--------------------

-- Colonialism: lost the monopoly bonuses (moved to Subsidies), gained yields from construction.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Colonialism[ENDCOLOR][NEWLINE][ICON_BULLET]Cities earn +15 [ICON_RESEARCH] Science and +15 [ICON_CULTURE] Culture when they construct Buildings, scaling with Era.[NEWLINE][ICON_BULLET]+2 [ICON_RESEARCH] Science and +1 [ICON_CULTURE] Culture from Forts, and from Armories, Bastion Forts, and Military Academies.[NEWLINE][ICON_BULLET] +4 [ICON_RESEARCH] Science and [ICON_CULTURE] Culture from Citadels.'
WHERE Tag = 'TXT_KEY_POLICY_NAVAL_TRADITION_HELP';

--------------------
-- Industry
--------------------

-- Subsidies: lost the Science from construction (moved to Colonialism), gained the monopoly bonuses.
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Subsidies[ENDCOLOR][NEWLINE][ICON_BULLET]Each [ICON_MONOPOLY] Global Monopoly Bonus is increased by an additional 5% if it''s percentage-based, or by +5 otherwise.[NEWLINE][ICON_BULLET]Gain 4 Free [ICON_RES_COAL] Coal.[NEWLINE][ICON_BULLET]+1 [ICON_HAPPINESS_1] Happiness from {TXT_KEY_BUILDING_WINDMILL}.'
WHERE Tag = 'TXT_KEY_POLICY_CARAVANS_HELP';
