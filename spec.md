# Warmongers policies for VP

This mod's goal is to provide more options for warmongers, vs forcing them into the authority / imperialism pipeline. This mod is for Vox Populi.

The changes are mostly to the ancien era policy trees (Tradition, Progress, Authority).

Below are the proposed changes. Note that these changes are relative to base VP (see how to handle current code below). Note that I am using the display names of the policies, not the database key.

## Changes

### Tradition

#### Justice

* Remove city strike bonus
* Add bonus food and production on city raze, 25 per population in the razed city, not scaling with era (see existing lua, need to be changed)

#### Majesty

* Remove flat % bonus to great people generation
* Add great people points per kill in capital equivalent to 75% of killed unit stregth (see existing lua, needs to be validated and updated)

### Progress

#### Organization

* Remove flat 2 production per city
* Add 25% bonus production to settlers (in addition to other units)
* Add a free settler

#### Liberty

* Bonus 5 XP (scaling with era) on purchase (currently implemented via lua)
* Remove 2 gold flat

#### Expertise

* Add 25% city strike modifier
* Add great general / great admiral points on kill (5 flat, scaling with era)

#### Equality

* Remove flat 1 happiness in each city.
* Add the bonus 1 happiness for cities with 10 strength

#### Fraternity

* Add free unit each 10 population (from honor policy)

### Authority

#### Imperium

* Add 20% production modifier to military units

#### Tribute

* Remove free settler
* Add MinorBullyScoreModifier to 15%
* Add science and culture when producing units (10% of strength)

#### Militarism

* Add 5XP bonus to pillage

### Fealty

#### Nobility

* Add 5HP healed in enemy territory
* Remove flat 2 gold to armories

#### Organized religion

* Remove flat culture from temple and grand temple
* Add faith and culture from unit death, equivalent to unit strength * experience level

### Statecraft

#### Foreign service

* Add 10 influence when gifting a unit

### Artistry

#### Humanism

* Units heal 5 HP when a great work is created

### Imperialism

#### Colonialism

* Remove monopoly bonuses
* Add 15 science and culture when building a building in a city, scaling with era

### Industry

#### Subsidies

* Remove science when building
* Add monopoly bonuses from colonialism

## Existing code

I kept the existing code in the mod as it may be used as an inpiration for implementing the changes. However, at the end, all the code in this mod should be replaced by the changes in this document.

Make sure to document the SQL files for all policy trees with placeholders for each policy (currently done in the ancien policy trees). 

## Compatibility

Make sure everything is compatible with the current version of vp (installed in the mod folder, parent to this project).