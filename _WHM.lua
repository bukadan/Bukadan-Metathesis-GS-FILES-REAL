-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Afflatus Solace'] = buffactive['afflatus solace'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'None', 'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.CastingModes = {'Normal', 'Resistant', 'Dire'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}
	
	state.Defense.PhysicalMode = 'PDT'
	state.OffenseMode = 'None'


	-- Default macro set/book
	set_macro_page(20, 1)
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main="Lehbrailg +2",sub="Arbuda Grip",ammo="Incantor Stone",head="Nahtirah Hat",neck="Orison Locket",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Anhur Robe",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Artsieq Hose",feet="Chelona Boots"}
		
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC['Healing Magic'] =  {main="Vejovis Wand +1",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Cure Clogs"}



	sets.precast.FC.Cure = {main="Vejovis Wand +1",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Cure Clogs"}

	sets.precast.FC.Curaga = {main="Vejovis Wand +1",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Cure Clogs"}
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Cleric's Briault +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Vanir Cotehardie",hands="Yaoyotl Gloves",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = ""
	sets.precast.WS = {
		head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	sets.precast.WS['Flash Nova'] = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	

	-- Midcast Sets
	
	sets.midcast.FastRecast = {main="Capricorn Staff",sub="Arbuda Grip",ammo="Incantor Stone",head="Nahtirah Hat",neck="Orison Locket",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hedera Cotehardie",hands="Dynasty Mitts",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Artsieq Hose",feet="Umbani Boots"}
	sets.midcast['Haste'] = {main="Lehbrailg +2",sub="Arbuda Grip",ammo="Incantor Stone",head="Nahtirah Hat",neck="Orison Locket",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Anhur Robe",hands="Dynasty Mitts",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Artsieq Hose",feet="Umbani Boots"}
		
	-- Cure sets

	sets.midcast.CureSolace = {main="Tamaxchi",sub="Sors Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",ear1="Novia Earring",ear2="Orison Earring",
		body="Orison Bliaud +2",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Pythia Sash +1",legs="Orison Pantaloons +2",feet="Litany Clogs"}

	sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",ear1="Novia Earring",ear2="Orison Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Cleric's Belt",legs="Orison Pantaloons +2",feet="Litany Clogs"}

		sets.midcast.CureWithLightWeather = {main="Chatoyant Staff",sub="",ammo="Incantor Stone",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",ear1="Novia Earring",ear2="Orison Earring",
		body="Orison Bliaud +2",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Pythia Sash +1",legs="Orison Pantaloons +2",feet="Litany Clogs"}
		
	sets.midcast.Curaga = {main="Tamaxchi",sub="Sors Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",ear1="Novia Earring",ear2="Orison Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Pythia Sash +1",legs="Orison Pantaloons +2",feet="Litany Clogs"}

	sets.midcast.CureMelee = {main="Tamaxchi",sub="Sors Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",ear1="Novia Earring",ear2="Orison Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Cleric's Belt",legs="Orison Pantaloons +2",feet="Litany Clogs"}

	sets.midcast.Cursna = {main="Lehbrailg +2",sub="Arbuda Grip",ammo="Incantor Stone",head="Orison Cap +2",neck="Malison Medallion",ear1="Gwati Earring",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Hieros Mittens",ring1="Ephedra Ring",ring2="Ephedra Ring",
		back="Mending Cape",waist="Goading Belt",legs="Piety Pantaloons",feet="Gendewitha Galoshes +1"}

	sets.midcast.StatusRemoval = {
		head="Orison Cap +2",legs="Orison Pantaloons +2"}


	sets.midcast['Enhancing Magic'] = {main="Lehbrailg +2",sub="Fulcio Grip",ammo="Incantor Stone",
		head="Umuthi Hat",neck="Enhancing Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Anhur Robe",hands="Dynasty Mitts",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +1"}
	

	sets.midcast.Stoneskin = {main="Lehbrailg +2",sub="Arbuda Grip",ammo="Incantor Stone",head="Umuthi Hat",neck="Orison Locket",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hedera Cotehardie",hands="Dynasty Mitts",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Siegel Sash",legs="Artsieq Hose",feet="Umbani Boots"}

	sets.midcast.Auspice = {feet="Orison Duckbills +1"}

	sets.midcast.BarElement = {main="Lehbrailg +2",sub="Fulcio Grip",
		head="Umuthi Hat",neck="Enhancing Torque",
		body="Anhur Robe",hands="Dynasty Mitts",
		waist="Olympus Sash",legs="Piety Pantaloons",feet="Orison Duckbills +1"}

	sets.midcast.Regen = {
		body="Cleric's Briault"}

	sets.midcast.Protectra = {ring1="Sheltered Ring",hands="Dynasty Mitts"}

	sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons",hands="Dynasty Mitts"}


	sets.midcast['Divine Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hedera Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Strendu Ring",
		back="Ogapepo Cape",waist="Cleric's Belt",legs="Bokwus Slops",feet="Umbani Boots"}

	sets.midcast['Dark Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hedera Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Strendu Ring",
		back="Ogapepo Cape",waist="Cleric's Belt",legs="Bokwus Slops",feet="Umbani Boots"}

	sets.midcast['Elemental Magic'] = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Witchstone",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Strophadic Earring",ear2="Friomisi Earing",
		body="Bokwus Robe",hands="Otomi Gloves",ring1="Sangoma Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Sekhmet Corset",legs="Wayfarer Slops",feet="Umbani Boots"}
	--sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {main=gear.RecastStaff})

	-- Custom spell classes
	sets.midcast['Enfeebling Magic'] = {
    main={ name="Lehbrailg +2", augments={'DMG:+15','Weapon Skill Acc.+3','"Fast Cast"+5',}},
    sub="Mephitis Grip",
    ammo="Kalboron Stone",
    head="Buremte Hat",
    body="Haruspex Coat",
    hands="Lurid Mitts",
    legs={ name="Bokwus Slops", augments={'Mag. Acc.+12','MND+10','INT+9',}},
    feet="Umbani Boots",
    neck="Weike Torque",
    waist={ name="Pythia Sash +1", augments={'CHR+1',}},
    left_ear="Lifestorm Earring",
    right_ear="Psystorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Strendu Ring",
    back="Refraction Cape",
}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Serpentes Sabots"}

	sets.idle.PDT ={main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Serpentes Sabots"}

	sets.idle.Town ={main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Serpentes Sabots"}
	
	sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Serpentes Sabots"}
	
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff",sub="Arbuda Grip",ammo="Brigantia Pebble",ear1="Flashward Earring",ear2="Impregnable Earring",
		head="Gendewitha Caubeen +1",neck="Twilight Torque",
		body="Gendewitha Bilaut +1",hands="Gendewitha Gages +1",ring2="Defending Ring",ring1="Shadow Ring",
		back="Shadow Mantle",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}

	sets.defense.MDT = {main="Terra's Staff",sub="Vivid Strap",ammo="Brigantia Pebble",
		head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Sanare Earring",ear2="Impregnable Earring",
		body="Gendewitha Bilaut +1",hands="Gendewitha Gages +1",ring2="Defending Ring",ring1="Shadow Ring",
		back="Shadow Mantle",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}


	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Theophany Cap +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	classes.CustomClass = get_spell_class(spell, action, spellMap)

	if spell.english == "Paralyna" and buffactive.Paralyzed then
		-- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
		eventArgs.handled = true
	end
	
	if spell.skill == 'HealingMagic' then
		gear.default.obi_back = "Refraction Cape"
	else
		gear.default.obi_back = "Toro Cape"
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.buff['Divine Caress'])
	end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		elseif spell.name == "Afflatus Misery" then
			state.Buff['Afflatus Solace'] = false
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.mpp < 90 and state.IdleMode == "Normal" and state.Defense.Active == false then
		idleSet = set_combine(idleSet, sets.Owleyes)
	end
	
	return idleSet
end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
		local needsArts = 
			player.sub_job:lower() == 'sch' and
			not buffactive['Light Arts'] and
			not buffactive['Addendum: White'] and
			not buffactive['Dark Arts'] and
			not buffactive['Addendum: Black']
			
		if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
			if needsArts then
				send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
			else
				send_command('@input /ja "Afflatus Solace" <me>')
			end
		end
	end
end


-- Handle notifications of general user state change.
function job_state_change(stateField, newValue)
	if stateField == 'OffenseMode' then
		if newValue == '' then
			disable('main','sub')
		else
			enable('main','sub')
		end
	elseif stateField == 'Reset' then
		if state.OffenseMode == 'None' then
			enable('main','sub')
		end
	end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_spell_class(spell, action, spellMap)
	local spellclass
	
	if spell.action_type == 'Magic' then
		if spell.skill == "EnfeeblingMagic" then
			if spell.type == "WhiteMagic" then
				spellclass = "MndEnfeebles"
			else
				spellclass = "IntEnfeebles"
			end
		else
			if spellMap == 'Cure' and state.Buff['Afflatus Solace'] then
				spellclass = "CureSolace"
			elseif (spellMap == 'Cure' or spellMap == "Curaga") and player.status == 'Engaged' and player.equipment.main ~= 'Tamaxchi' then
				spellclass = "CureMelee"
			end
		end
	end
	
	return spellclass
end
