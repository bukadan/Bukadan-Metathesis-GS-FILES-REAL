-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

--[[
	Custom commands:
	
	Terpander has a set of modes: None, Dummy, Terpander
	
	You can set these via the standard 'set' and 'cycle' self-commands.  EG:
	gs c cycle Terpander
	gs c set Terpander Dummy
	
	The Dummy state will equip the Terpander and ensure non-duration gear is equipped.
	The Terpander state will simply equip the Terpander on top of standard gear.
	
	Use the Dummy version to put up dummy songs that can be overwritten by full-potency songs.
	
	Use the Terpander version to simply put up additional songs without worrying about dummy songs.
	
	
	Simple macro to cast a dummy Terpander song:
	/console gs c set Terpander Dummy
	/ma "Shining Fantasia" <me>
	
	
	There is also an auto-handling of Terpander songs, via the state.AutoTerpander flag:
	
	If state.TerpanderMode is None, and if currently tracked songs (via timers) is less
	than the max we could sing while using the Terpander, and if the song is cast on
	self (rather than Pianissimo on another player), then it will equip the Terpander on
	top of standard duration gear.

--]]

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Pianissimo'] = buffactive['pianissimo'] or true

	options.TerpanderModes = {'None','Dummy','Terpander'}
	state.TerpanderMode = 'None'

	-- For tracking current recast timers via the Timers plugin.
	timer_reg = {}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.CastingModes = {'None', 'Normal'}
	options.DefenseModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT', 'MP'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

state.CastingMode = 'None'
	state.Defense.PhysicalMode = 'PDT'

	brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri'}
	pick_tp_weapon()
	
	-- Adjust this if using the Terpander (new +song instrument)
	info.TerpanderInstrument = 'Terpander'
	-- How many extra songs we can keep from Terpander/Terpander
	info.TerpanderSongs = 1
	-- Whether to try to automatically use Terpander when an appropriate gap in current vs potential
	-- songs appears, and you haven't specifically changed state.TerpanderMode.
	state.AutoTerpander = false
	
	-- Additional local binds
	send_command('bind ^` input /ma "Herculean Etude" <me>')

	-- Default macro set/book
	set_macro_page(2, 18)
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	sets.precast.FC = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Vivid Strap",
    range="Linos",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Chelona Boots",
    neck="Dualism Collar",
    waist="Witful Belt",
    ear1="Influx Earring",
    ear2="Loquacious Earring",
ring2="Prolix Ring",
       ring1="Sangoma Ring",
    back="Swith Cape",
}


	sets.precast.FC['Healing Magic'] = {
    main="Apaisante",
	sub="Genbu's Shield",
    head="Nahtirah Hat",
	    range="Linos",
    body="Heka's Kalasiris",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Artsieq Hose",
    feet="Chelona Boots",
    neck="Dualism Collar",
    waist="Witful Belt",
    ear1="Influx Earring",
    ear2="Loquac. Earring",
ring2="Prolix Ring",
       ring1="Sangoma Ring",
    back="Pahtli Cape",
}

	sets.precast.FC.Cure = {
    main="Apaisante",
	sub="Genbu's Shield",
    head="Nahtirah Hat",
    range="Linos",
    body="Heka's Kalasiris",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','"Cure" spellcasting time -4%',}},
    legs="Artsieq Hose",
    feet="Chelona Boots",
    neck="Dualism Collar",
    waist="Acerbic Sash +1",
    ear1="Influx Earring",
    ear2="Loquac. Earring",
ring2="Prolix Ring",
       ring1="Sangoma Ring",
    back="Pahtli Cape",
}

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {head="Umuthi Hat"})

		sets.precast.FC.BardSong = {
    main="Felibre's Dague",
    sub="Genbu's Shield",
    head="Aoidos' Calot +2",
    body="Sha'ir Manteel",
    hands="Gendewitha Gages",
    legs="Gendewitha Spats +1",
    feet="Bokwus boots",
    neck="Aoidos' Matinee",
    waist="Witful Belt",
    ear1="Aoidos' Earring",
    ear2="Loquac. Earring",
ring2="Prolix Ring",
    ring1="Minstrel's Ring",
    back="Swith Cape",
}
	sets.precast.FC.BardSong2 = {
    main="Felibre's Dague",
    sub="Genbu's Shield",
		    range="Linos",
    head="Aoidos' Calot +2",
    body="Sha'ir Manteel",
    hands="Gendewitha Gages",
    legs="Gendewitha Spats +1",
    feet="Bokwus boots",
    neck="Aoidos' Matinee",
    waist="Witful Belt",
    ear1="Aoidos' Earring",
    ear2="Loquac. Earring",
ring2="Prolix Ring",
    ring1="Minstrel's Ring",
    back="Swith Cape",
}

	sets.precast.FC.Terpander = set_combine(sets.precast.FC.BardSong, {range=info.TerpanderInstrument})
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {range="Gjallarhorn",
		head="Nahtirah Hat",
		body="Gendewitha Bilaut",hands="Buremte Gloves",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range="Gjallarhorn",
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bard's Justaucorps +2",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	
	
	-- Midcast Sets

	
		sets.midcast['Haste'] = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
    body="Anhur Robe",
	    range="Linos",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Gendewitha Galoshes +1",
    neck="Dualism Collar",
    waist="Goading Belt",
    ear1="Gwati Earring",
    ear2="Loquacious Earring",
    ring1="Prolix Ring",
    ring2="Sangoma Ring",
    back="Swith Cape",
}

	sets.midcast.Haste =  {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
	    range="Linos",
    body="Hedera Cotehardie",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Umbani Boots",
    neck="Dualism Collar",
    waist="Goading Belt",
    ear1="Influx Earring",
    ear2="Gifted Earring",
    ring1="Prolix Ring",
    ring2="Sangoma Ring",
    back="Swith Cape",
}
	-- General set for recast times.
	sets.midcast.FastRecast = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Arbuda Grip",
    head="Nahtirah Hat",
	    range="Linos",
    body="Hedera Cotehardie",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Umbani Boots",
    neck="Dualism Collar",
    waist="Goading Belt",
    ear1="Influx Earring",
    ear2="Gifted Earring",
    ring1="Prolix Ring",
    ring2="Sangoma Ring",
    back="Swith Cape",
}
		
	sets.midcast['Enhancing Magic'] = {
    main="Arendsi Fleuret",   	
    sub="Genbu's Shield",
	    range="Linos",
    head="Umuthi Hat",
    body="Hedera Cotehardie",
    hands="Gendewitha Gages +1",
    legs="Artsieq Hose",
    feet="Umbani Boots",	
    neck="Enhancing Torque",
    waist="Olympus Sash",
    ear1="Andooa Earring",
    ear2="Gifted Earring",
    ring1="Prolix Ring",
    ring2="Sangoma Ring",
    back="Merciful Cape",
}

		-- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
	sets.midcast.Ballad = {}
	sets.midcast.Lullaby = {hands="Brioso Cuffs"}
	sets.midcast.Madrigal = {head="Aoidos' Calot +2"}
	sets.midcast.March = {hands="Aoidos' Manchettes +2"}
	sets.midcast.Minuet = {body="Aoidos' Hongreline +2"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {feet="Aoidos' Cothrn. +1"}


	sets.midcast.Etude = {range=info.TerpanderInstrument}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main="Legato Dagger",sub="Genbu's Shield",range="Gjallarhorn",
		head="Bihu Roundlet +1",neck="Aoidos' Matinee",ear1="Musical Earring", ear2="Loquacious Earring",
		body="Aoidos' Hongreline +2",hands="Aoidos' Manchettes +2",ring2="Prolix Ring",ring1="Sangoma Ring",
		back="Kumbira Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2",feet="Brioso Slippers +1"}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Gjallarhorn",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Barcarolle Medal",
    waist="Ovate Rope",
    left_ear="Musical Earring",
    right_ear="Gwati Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Kumbira Cape",
}
	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = {
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Gjallarhorn",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Barcarolle Medal",
    waist="Ovate Rope",
    left_ear="Musical Earring",
    right_ear="Gwati Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Kumbira Cape",
}

	sets.midcast.Stun = {
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Linos",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Dark Torque",
    waist="Ovate Rope",
    left_ear="Lifestorm Earring",
    right_ear="Psystorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}	

	sets.midcast['Divine Magic'] = {
    main={ name="Lehbrailg +2", augments={'DMG:+17','"Conserve MP"+1','"Mag.Atk.Bns."+20',}},
    sub="Mephitis Grip",
    range="Linos",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body="Haruspex Coat",
    hands="Otomi Gloves",
    legs={ name="Artsieq Hose", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Dualism Collar",
    waist="Sekhmet Corset",
    left_ear="Novio Earring",
    right_ear="Sortiarius Earring",
    left_ring="Strendu Ring",
    right_ring="Acumen Ring",
    back="Toro Cape",
}

sets.midcast.Repose ={
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Linos",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Weike Torque",
    waist="Ovate Rope",
    left_ear="Lifestorm Earring",
    right_ear="Psystorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}

	sets.midcast['Enfeebling Magic'] ={
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Linos",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Weike Torque",
    waist="Ovate Rope",
    left_ear="Lifestorm Earring",
    right_ear="Psystorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}

	sets.midcast['Sleep II'] = {
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Linos",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Weike Torque",
    waist="Ovate Rope",
    left_ear="Lifestorm Earring",
    right_ear="Psystorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}
		
		sets.midcast.Sleepga = {
    main={ name="Lehbrailg +2", augments={'DMG:+16','Magic crit. hit rate +3','Mag. Acc.+30',}},
    sub="Mephitis Grip",
    range="Linos",
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Artsieq Cuffs", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Artsieq Boots", augments={'MP+30','Mag. Acc.+20','MND+7',}},
    neck="Weike Torque",
    waist="Ovate Rope",
    left_ear="Lifestorm Earring",
    right_ear="Psystorm Earring",
    left_ring="Sangoma Ring",
    right_ring="Perception Ring",
    back="Refraction Cape",
}
		
	sets.midcast.Cursna =  {main="Lebrailg +2",sub='Mephitis Grip',ammo="Incantor Stone",head="Orison Cap +1",neck="Malison Medallion",ear1="Gwati Earring",ear2="Gifted Earring",
		body="Orison Bliaud +2",hands="Dynasty Mitts",ring1="Ephedra Ring",ring2="Ephedra Ring",
		back="Mending Cape",waist="Bishop's Sash",legs="Artsieq Hose",feet="Gendewitha Galoshes +1"}
		
  
		
	sets.midcast.SongRecast = {
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Vivid Strap",
    range="Gjallarhorn",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Gendewitha Gages +1",
    feet="Chelona Boots",
    neck="Dualism Collar",
    waist="Witful Belt",
    ear1="Influx Earring",
    ear2="Loquacious Earring",
ring2="Prolix Ring",
       ring1="Sangoma Ring",
    back="Swith Cape",legs="Aoidos' Rhing. +2"}

	--sets.midcast.Terpander = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.TerpanderInstrument})

	-- Cast spell with normal gear, except using Terpander instead
	sets.midcast.Terpander = {range=info.TerpanderInstrument}

	-- Dummy song with Terpander; minimize duration to make it easy to overwrite.
	sets.midcast.TerpanderDummy ={
    main={ name="Lehbrailg +1", augments={'DMG:+18','CHR+1','"Fast Cast"+4',}},
    sub="Vivid Strap",
    range="Gjallarhorn",
    head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Gendewitha Gages +1",
    feet="Chelona Boots",
    neck="Dualism Collar",
    waist="Witful Belt",
    ear1="Influx Earring",
    ear2="Loquacious Earring",
ring2="Prolix Ring",
       ring1="Sangoma Ring",
    back="Swith Cape",legs="Aoidos' Rhing. +2"}

		sets.midcast.CureWithLightWeather = {main="Chatoyant Staff",sub="Dominie's",
		head="Gendewitha Caubeen +1",neck="Phrenic Torque",Ear1="Novia Earring",Ear2="Gifted Earring",
		body="Gendewitha Bilaut +1",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		legs="Nares Trews",feet="Gendewitha Galoshes +1",back="Twilight Cape",waist="Penitent's Rope"}
		
	-- Other general spells and classes.
	sets.midcast.Cure = {
    main="Galenus",
    sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','"Cure" spellcasting time -5%',}},
    range="Gjallarhorn",
    head={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -3%','"Cure" potency +4%',}},
    body={ name="Gende. Bilaut +1", augments={'Phys. dmg. taken -2%','"Cure" potency +7%',}},
    hands="Bokwus Gloves",
    legs="Nares Trews",
    feet="Brioso Slippers +1",
    neck="Dualism Collar",
    waist="Fucho-no-Obi",
    left_ear="Influx Earring",
    right_ear="Gifted Earring",
    left_ring="Sangoma Ring",
    right_ring="Bifrost Ring",
    back="Pahtli Cape",
}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.midcast.Cursna = {
		neck="Malison Medallion",
		hands="Hieros Mittens",ring1="Ephedra Ring",ring2="Ephedra Ring"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP, 
		body="Gendewitha Bilaut",
		legs="Nares Trews",feet="Chelona Boots"}
	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Terra's Staff",sub="Volos Strap",range="Gjallarhorn",
		head="Nefer Khat",neck="Twilight Torque",ear1="Flashward Earring",ear2="Spellbreaker Earring",
		body="Heka's Kalasiris",hands="Umuthi Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Nares Trews",feet="Aoidos' Cothurnes +1"}

	sets.idle.Town = {
    main={ name="Ipetam", augments={'DEF+6','Phys. dmg. taken -4%',}},
    sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','"Cure" spellcasting time -5%',}},
    range={ name="Linos", augments={'Mag. Evasion+8','Magic dmg. taken -3%',}},
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands="Umuthi Gloves",
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Gende. Galosh. +1", augments={'Phys. dmg. taken -3%','"Cure" spellcasting time -3%',}},
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Flashward Earring",
    right_ear="Impreg. Earring",
    left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -4%',}},
    right_ring={ name="Dark Ring", augments={'Magic dmg. taken -4%','Phys. dmg. taken -3%',}},
    back={ name="Umbra Cape", augments={'STR+2 DEX-1 VIT-1',}},
}
	
	sets.idle.Weak = {
    main={ name="Ipetam", augments={'DEF+6','Phys. dmg. taken -4%',}},
    sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','"Cure" spellcasting time -5%',}},
    range={ name="Linos", augments={'Mag. Evasion+8','Magic dmg. taken -3%',}},
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands="Umuthi Gloves",
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Gende. Galosh. +1", augments={'Phys. dmg. taken -3%','"Cure" spellcasting time -3%',}},
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Spellbr. Earring",
    right_ear="Impreg. Earring",
    left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -4%',}},
    right_ring={ name="Dark Ring", augments={'Magic dmg. taken -4%','Phys. dmg. taken -3%',}},
    back={ name="Umbra Cape", augments={'STR+2 DEX-1 VIT-1',}},
}
	
	
	-- Defense sets

	sets.defense.PDT = {
    main={ name="Ipetam", augments={'DEF+6','Phys. dmg. taken -4%',}},
    sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','"Cure" spellcasting time -5%',}},
    range={ name="Linos", augments={'Mag. Evasion+8','Magic dmg. taken -3%',}},
    head={ name="Bihu Roundlet +1", augments={'Enhances "Foe Sirvente" effect',}},
    body={ name="Bihu Jstcorps +1", augments={'Enhances "Troubadour" effect',}},
    hands="Umuthi Gloves",
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Gende. Galosh. +1", augments={'Phys. dmg. taken -3%','"Cure" spellcasting time -3%',}},
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Flashward Earring",
    right_ear="Impreg. Earring",
    left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -4%',}},
    right_ring={ name="Dark Ring", augments={'Magic dmg. taken -4%','Phys. dmg. taken -3%',}},
    back={ name="Umbra Cape", augments={'STR+2 DEX-1 VIT-1',}},
}

			sets.idle.MP = {main="Galenus",sub="Genbu's shield6",range="Gjallarhorn",
		head="Nahtirah Hat",neck="Phrenic Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Gendewitha Bilaut +1",hands="Otomi Gloves",ring1="Dark Ring",ring2="Sangoma Ring",
		back="Errant Cape",waist="Fucho-No-Obi",legs="Nares Trews",feet="Brioso Slippers +1"}
	sets.defense.MDT = {main="Terra's Staff",sub="Volos Strap",range="Gjallarhorn",
		head="Bihu Roundlet +1",neck="Twilight Torque",ear1="Spellbreaker Earring",ear2="Impregnable Earring",
		body="Bihu Justaucorps +1",hands="Umuthi Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-Obi",legs="Bihu Cannions +1",feet="Gendewitha Galoshes +1"}

	sets.Kiting = {Back="Mecisto. Mantle"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	

end


-------------------------------------------------------------------------------------------------------------------
-- Job- versions of event handlers, allowing overriding default handling.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		-- Auto-Pianissimo
		if spell.target.type == 'PLAYER' and not spell.target.charmed and not state.Buff['Pianissimo'] then
			cancel_spell()
			send_command('@input /ja "Pianissimo" <me>; wait 1.25; input /ma "'..spell.name..'" '..spell.target.name)
			eventArgs.cancel = true
			return
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)

		if spell.type == 'BardSong' then
			-- layer general gear on first, then let default handler add song-specific gear.
			local generalClass = get_song_class(spell)
			if generalClass and sets.midcast[generalClass] then
				equip(sets.midcast[generalClass])
			end
		end
	end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		if state.TerpanderMode == 'Terpander' then
			equip(sets.midcast.Terpander)
		elseif state.TerpanderMode == 'None' and spell.target.type == 'SELF' and state.AutoTerpander and daur_song_gap() then
			equip(sets.midcast.Terpander)
		end

		state.TerpanderMode = 'None'
	end
end


-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		end

		if spell.type == 'BardSong' then
			if spell.target then
				if spell.target.type and spell.target.type:upper() == 'SELF' then
					adjust_Timers(spell, action, spellMap)
				end
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for other events that aren't handled by the include file.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Terpander mode handling.
-------------------------------------------------------------------------------------------------------------------

-- Request job-specific mode tables.
-- Return true on the third returned value to indicate an error: that we didn't recognize the requested field.
function job_get_mode_list(field)
	if field == 'Terpander' then
		if player.inventory[info.TerpanderInstrument] then
			return options.TerpanderModes, state.TerpanderMode
		else
			add_to_chat(123, info.TerpanderInstrument..' is not in player inventory.')
		end
	end
end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
	if field == 'Terpander' then
		state.TerpanderMode = val
		return true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	pick_tp_weapon()
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
	if state.OffenseMode == 'Normal' then
		if state.CombatForm then
			meleeString = 'Melee: Dual-wield, '
		else
			meleeString = 'Melee: Single-wield, '
		end
	end

	add_to_chat(122,'Casting ['..state.CastingMode..'], '..meleeString..'Idle ['..state.IdleMode..'], '..defenseString..
		'Kiting: '..on_off_names[state.Kiting])

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
	-- Can't use spell.targets:contains() because this is being pulled from resources
	if set.contains(spell.targets, 'Enemy') then
		if state.CastingMode == 'Resistant' then
			return 'ResistantSongDebuff'
		else
			return 'SongDebuff'
		end
	elseif state.TerpanderMode == 'Dummy' then
		return 'TerpanderDummy'
	else
		return 'SongEffect'
	end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_Timers(spell, action, spellMap)
	local t = os.time()
	
	-- Eliminate songs that have already expired from our local list.
	local tempreg = {}
	for i,v in pairs(timer_reg) do
		if v < t then tempreg[i] = true end
	end
	for i,v in pairs(tempreg) do
		timer_reg[i] = nil
	end
	
	local dur = calculate_duration(spell.name, spellMap)
	if timer_reg[spell.name] then
		-- Can delete timers that have less than 120 seconds remaining, since
		-- the new version of the song will overwrite the old one.
		-- Otherwise create a new timer counting down til we can overwrite.
		--if (timer_reg[spell.name] - t) <= 120 then
			send_command('timers delete "'..spell.name..'"')
			timer_reg[spell.name] = t + dur
			send_command('timers create "'..spell.name..'" '..dur..' down')
		--end
	else
		-- Figure out how many songs we can maintain.
		local maxsongs = 2
		if player.equipment.range == info.TerpanderInstrument then
			maxsongs = maxsongs + info.TerpanderSongs
		end
		if buffactive['Clarion Call'] then
			maxsongs = maxsongs+1
		end
		-- If we have more songs active than is currently apparent, we can still overwrite
		-- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
		if maxsongs < table.length(timer_reg) then
			maxsongs = table.length(timer_reg)
		end
		
		-- Create or update new song timers.
		if table.length(timer_reg) < maxsongs then
			timer_reg[spell.name] = t+dur
			send_command('timers create "'..spell.name..'" '..dur..' down')
		else
			local rep,repsong
			for i,v in pairs(timer_reg) do
				if t+dur > v then
					if not rep or rep > v then
						rep = v
						repsong = i
					end
				end
			end
			if repsong then
				timer_reg[repsong] = nil
				send_command('timers delete "'..repsong..'"')
				timer_reg[spell.name] = t+dur
				send_command('timers create "'..spell.name..'" '..dur..' down')
			end
		end
	end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_Timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
	local mult = 1
	if player.equipment.range == 'Terpander' then mult = mult + 0 end -- change to 0.25 with 90 Daur
	if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
	
	if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
	if player.equipment.main == "Legato Dagger" then mult = mult + 0.1 end
	if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
	if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
	if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.1 end
	if player.equipment.feet == "Brioso Slippers +1 +1" then mult = mult + 0.11 end
	
	if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
	if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
	if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
	if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
	if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
	if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
	if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
	
	if buffactive.Troubadour then
		mult = mult*2
	end
	if spellName == "Sentinel's Scherzo" then
		if buffactive['Soul Voice'] then
			mult = mult*2
		elseif buffactive['Marcato'] then
			mult = mult*1.5
		end
	end
	
	-- Tweak for inaccuracies in cast vs aftercast timing
	mult = mult - 0.05
	
	local totalDuration = mult*120

	return totalDuration
end


function daur_song_gap()
	if player.inventory.Terpander then
		-- Figure out how many songs we can maintain.
		local maxsongs = 1 + info.TerpanderSongs
		
		local activesongs = table.length(timer_reg)
		
		-- If we already have at least 2 songs on, but not enough to max out
		-- on possible Daur songs, flag us as Daur-ready.
		if activesongs >= 2 and activesongs < maxsongs then
			return true
		end
	end
	
	return false
end



-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
	if brd_daggers:contains(player.equipment.main) then
		state.CombatWeapon = 'Dagger'
		
		if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
			state.CombatForm = "DualWield"
		else
			state.CombatForm = nil
		end
	else
		state.CombatWeapon = nil
		state.CombatForm = nil
	end
end


