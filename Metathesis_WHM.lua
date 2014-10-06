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
	set_macro_page(3, 2)
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
	sets.precast.FC = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Vivid Strap",
    ammo="Incantor Stone",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Cure" potency +4%',}},
    legs="Artsieq Hose",
    feet="Chelona Boots",
    neck="Orison Locket",
    waist="Witful Belt",
    left_ear="Gifted Earring",
    right_ear="Loquacious Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}
		

	sets.precast.FC['HealingMagic'] = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Vivid Strap",
    ammo="Incantor Stone",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Orsn. Pantaln. +2",
    feet="Chelona Boots",
    neck="Orison Locket",
    waist="Witful Belt",
    left_ear="Gifted Earring",
    right_ear="Loquac. Earring",
    left_ring="Ephedra Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}

	sets.precast.FC.StatusRemoval = sets.precast.FC.HealingMagic

	sets.precast.FC['Cure'] = {
    main="Nathushne",
    sub="Dominie's Grip",
    ammo="Incantor Stone",
    head="Nahtirah Hat",
    body="Heka's Kalasiris",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Orsn. Pantaln. +2",
    feet="Cure Clogs",
    neck="Orison Locket",
    waist="Witful Belt",
    left_ear="Gifted Earring",
    right_ear="Loquac. Earring",
    left_ring="Ephedra Ring",
    right_ring="Prolix Ring",
    back="Pahtli Cape",
}

	sets.precast.FC.Curaga = {
    main="Nathushne",
    sub="Dominie's Grip",
    ammo="Incantor Stone",
    head="Nahtirah Hat",
    body="Heka's Kalasiris",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Orsn. Pantaln. +2",
    feet="Cure Clogs",
    neck="Orison Locket",
    waist="Witful Belt",
    left_ear="Gifted Earring",
    right_ear="Loquac. Earring",
    left_ring="Ephedra Ring",
    right_ring="Prolix Ring",
    back="Pahtli Cape",
}
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Cleric's Briault +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Vanir Cotehardie",hands="Gendewitha Gages +1",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
	
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = ""
	sets.precast.WS = {
		head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Gendewitha Gages +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
	
	sets.precast.WS['Flash Nova'] = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Vanir Cotehardie",hands="Gendewitha Gages +1",ring1="Rajas Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}
	

	-- Midcast Sets
	
	sets.midcast.FastRecast = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Dynasty Mitts",
    legs="Artsieq Hose",
    feet="Umbani Boots",
    neck="Orison Locket",
    waist="Goading Belt",
    left_ear="Gwati Earring",
    right_ear="Gifted Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}

	sets.midcast['Sacrifice'] = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Umbani Boots",
    neck="Orison Locket",
    waist="Witful Belt",
    left_ear="Gwati Earring",
    right_ear="Gifted Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}

	sets.midcast.Sacrifice = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Umbani Boots",
    neck="Orison Locket",
    waist="Witful Belt",
    left_ear="Gwati Earring",
    right_ear="Gifted Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}
	
		sets.midcast.Haste = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
    body="Hedera Cotehardie",
    hands="Dynasty Mitts",
    legs="Artsieq Hose",
    feet="Umbani Boots",
    neck="Orison Locket",
    waist="Goading Belt",
    left_ear="Gwati Earring",
    right_ear="Gifted Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}
	sets.midcast.CureSolace = {
    main="Tamaxchi",
    sub="Sors Shield",
    ammo="Kalboron Stone",
    head={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -3%','"Cure" potency +4%',}},
    body="Orison Bliaud +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Cure" potency +4%',}},
    legs="Orsn. Pantaln. +2",
    feet="Artsieq Boots",
    neck="Phrenic Torque",
    waist="Witful Belt",
    left_ear="Roundel Earring",
    right_ear="Novia Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Orison Cape"
}

	sets.midcast.Cure = {
    main="Tamaxchi",
    sub="Sors Shield",
    ammo="Kalboron Stone",
    head={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -3%','"Cure" potency +4%',}},
    body="Heka's Kalasiris",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Orsn. Pantaln. +2",
    feet="Artsieq Boots",
    neck="Phrenic Torque",
    waist="Bishop's Sash",
    left_ear="Roundel Earring",
    right_ear="Novia Earring",
    left_ring="Ephedra Ring",
    right_ring="Ephedra Ring",
    back="Mending Cape"
}

	sets.midcast.Curaga =  {
    main={ name="Tamaxchi", augments={'System: 1 ID: 912 Val: 8','Enmity-10',}},
    sub="Sors Shield",
    ammo="Kalboron Stone",
    head={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -3%','"Cure" potency +4%',}},
    body="Heka's Kalasiris",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Orsn. Pantaln. +2",
    feet="Litany Clogs",
    neck="Phrenic Torque",
    waist="Bishop's Sash",
    left_ear="Roundel Earring",
    right_ear="Novia Earring",
    left_ring="Ephedra Ring",
    right_ring="Ephedra Ring",
    back="Mending Cape"
}


	sets.midcast.CureMelee = {main="Tamaxchi",sub="Sors Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",ear1="Novia Earring",ear2="Orison Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Aswang Sash",legs="Orison Pantaloons +2",feet="Litany Clogs"}

	sets.midcast.Cursna =  {ammo="Incantor Stone",head="Orison Cap +1",neck="Malison Medallion",ear1="Gwati Earring",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Dynasty Mitts",ring1="Ephedra Ring",ring2="Ephedra Ring",
		back="Mending Cape",waist="Bishop's Sash",legs="Artsieq Hose",feet="Gendewitha Galoshes +1"}

	sets.midcast.StatusRemoval = {
		head="Orison Cap +1",legs="Orison Pantaloons +2"}


	sets.midcast['Enhancing Magic'] = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Fulcio Grip",
    ammo="Hasty Pinion",
    head="Umuthi Hat",
    body="Anhur Robe",
    hands="Dynasty Mitts",
    legs="Piety Pantaloons",
    feet="Orsn. Duckbills +2",
    neck="Enhancing Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Loquac. Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Merciful Cape",
}
	

	sets.midcast.Stoneskin = {
    main={ name="Lehbrailg +2", augments={"damage15","mind5","fastcast4",}},
    sub="Arbuda Grip",
    ammo="Hasty Pinion",
    head="Umuthi HAt",
    body="Anhur Robe",
    hands="Dynasty Mitts",
    legs="Piety Pantaloons",
    feet="Orsn. Duckbills +2",
    neck="Enhancing Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Loquac. Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Swith Cape",
}

	sets.midcast.Auspice = {feet="Orsn. Duckbills +2"}

	sets.midcast.BarElement = {
    main={ name="Lehbrailg +2", augments={"damage15","mind5","fastcast4",}},
    sub="Fulcio Grip",
    ammo="Hasty Pinion",
    head="Umuthi Hat",
    body="Anhur Robe",
    hands="Dynasty Mitts",
    legs="Piety Pantaloons",
    feet="Orsn. Duckbills +2",
    neck="Enhancing Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Loquac. Earring",
    left_ring="Sangoma Ring",
    right_ring="Prolix Ring",
    back="Merciful Cape",
}

	sets.midcast.Regen = {
		body="Cleric's Briault"}

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons"}


	sets.midcast['Divine Magic'] = {
     main={ name="Lehbrailg +2", augments={'DMG:+15','INT+3','"Mag.Atk.Bns."+20',}},
    sub="Mephitis Grip",
    ammo="Dosis Tathlum",
    head="Kaabnax Hat",
    body="Weatherspoon Robe +1",
    hands="Otomi Gloves",
    legs="Theurgist's Slacks",
    feet="Weatherspoon Souliers",
    neck="Eddy Necklace",
    waist="Sekhmet Corset",
    left_ear="Novio Earring",
    right_ear="Strophadic Earring",
    left_ring="Strendu Ring",
    right_ring="Acumen Ring",
    back="Toro Cape",
}

	sets.midcast['Elemental Magic'] = {
     main={ name="Lehbrailg +2", augments={'DMG:+15','INT+3','"Mag.Atk.Bns."+20',}},
    sub="Mephitis Grip",
    ammo="Dosis Tathlum",
    head="Kaabnax Hat",
    body="Artsieq Jubbah",
    hands="Otomi Gloves",
    legs="Theurgist's Slacks",
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Eddy Necklace",
    waist="Sekhmet Corset",
    left_ear="Novio Earring",
    right_ear="Strophadic Earring",
    left_ring="Strendu Ring",
    right_ring="Acumen Ring",
    back="Toro Cape",
}	
		
		
	sets.midcast[ 'Dark Magic' ] = {main="Lehbrailg +2",sub="Mephitis Grip",
		head="Kaabnax Hat",neck="Eddy Necklace",ear1="Sortiarius Earring",ear2="Gwati Earring",
		body="Haruspex Coat",hands="Otomi Gloves",ring1="Sangoma Ring",ring2="Acumen Ring",
		back="Refraction Cape",waist="Sekhmet Corset",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}	

				sets.midcast.Distract8 =
{
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    ammo="Kalboron Stone",
    head="Kaabnax Hat",
    body={ name="Artsieq Jubbah", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Artsieq Hose", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Weike Torque",
    waist="Ovate Rope",
    left_ear="Psystorm Earring",
    right_ear="Lifestorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}
		
		sets.midcast['Enfeebling Magic'] =
{
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    ammo="Kalboron Stone",
    head="Kaabnax Hat",
    body={ name="Artsieq Jubbah", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Artsieq Hose", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Weike Torque",
    waist="Ovate Rope",
    left_ear="Psystorm Earring",
    right_ear="Lifestorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}
	--sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {main=gear.RecastStaff})

	-- Custom spell classes


	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP, 
		head="Nefer Khat",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",
		feet="Serpentes Sabots"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Spellbreaker Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Gendewitha Galoshes +1"}

	sets.idle.PDT = {main="Terra's Staff",sub="Volos Strap",ammo="Brigantia Pebble",
		head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Gendewitha Bilaut +1",hands="Gendewitha Gages +1",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}

	sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Spellbreaker Earring",
		body="Heka's Kalasiris",hands="Gendewitha Gages +1",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Gendewitha Galoshes +1"}
	sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Brigantia Pebble",
		head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Merman's Earring",ear2="Dawn Earring",
		body="Gendewitha Bilaut +1",hands="Gendewitha Gages +1",ring1="Sangoma Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}
	

	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff",sub="Volos Strap",ammo="Brigantia Pebble",
		head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Gendewitha Bilaut +1",hands="Gendewitha Gages +1",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}

	sets.defense.MDT = {main="Terra's Staff",sub="Volos Strap",ammo="Brigantia Pebble",
		head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Flashward Earring",ear2="Impregnable Earring",
		body="Gendewitha Bilaut +1",hands="Gendewitha Gages +1",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Gendewitha Spats +1",feet="Gendewitha Galoshes +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Theophany Cap +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes +1"}


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
		if newValue == 'Normal' then
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
function display_current_job_state(eventArgs)
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end
	
	local meleeString = ''
	if state.OffenseMode == '' then
		meleeString = 'Melee: Weapons locked, '
	end

	add_to_chat(122,'Casting ['..state.CastingMode..'], '..meleeString..'Idle ['..state.IdleMode..'], '..defenseString..
		'Kiting: '..on_off_names[state.Kiting])

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_spell_class(spell, action, spellMap)
	local spellclass
	
	if spell.action_type == 'Magic' then
		if spell.skill == "Enfeebling Magic" then
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
