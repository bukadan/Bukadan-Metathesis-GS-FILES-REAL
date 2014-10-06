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
	state.CombatForm = get_combat_form()
	update_melee_groups()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Mod', 'iLvl'}
	options.DefenseModes = {'Normal', 'PDT', 'HP', 'Counter'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Off','Smite'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'HP'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	select_default_macro_book()
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
	send_command('bind ^` gs c cycle casting')
	send_command('bind !` gs c set CastingMode Off')
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}

	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}

	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}

	sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}

	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chi Blast'] = {
		head="Melee Crown +2",
		body="Otronif Harness",hands="Otronif Gloves",
		back="Tuilha Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}

	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}

	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}

	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chakra'] = {ammo="Brigantia Pebble",
		head="Felistris Mask",ear1="Cassie Earring",ear2="Impregnable Earring",
		body="Anchorite's Cyclas",hands="Mel. Gloves +1",ring1="Spiral Ring",
		back="Anchoret's Mantle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Daihanshi Habaki"}

	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}


	sets.precast.Effusion = {ammo="Dosis Tathlum",
		head="Thaumas Hat",ear1="Friomisi Earring",ear2="Novio Earring",Neck="Stoicheion Medal",	
		body="Wayfarer Robe",hands="Wayfarer Cuffs",ring1="Acumen Ring",ring2="Fenrir Ring",
		back="Toro Cape",waist="Windbuffet Belt",legs="Shneddick Tights +1",feet="Qaaxo leggings"}		
	-- Don't need any special gear for Healing Waltz.


	sets.precast.FC = {head="Haruspex hat",ear2="Loquacious Earring",hands="Thaumas Gloves",neck="Magoraga Beads",ring1="Prolix Ring",ring1="Veneficium Ring",Legs="Nebula Slops +1",Waist="Black Belt",Hands="Thaumas Gloves"}



       
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS =  {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Ifrit Ring",ring2="Epona's Ring",
		back="Buquwik Cape",waist="Thunder Belt",legs="Otronif Brais +1",feet="Qaaxo Leggings"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Victory Smite"]     = {	
    ammo="Thew Bomblet",
    head="Uk'Uxkaj Cap",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands="Anch. Gloves +1",
    legs="Quiahuiz Trousers",
    feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}},
    neck="Breeze Gorget",
    waist="Caudata Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Epona's Ring",
    back="Rancorous Mantle",
}
	sets.precast.WS["Victory Smite"].Acc =  {
    ammo="Ginsen",
    head={ name="Uk'uxkaj Cap", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%','STR+8',}},
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs="Ighwa Trousers",
    feet={ name="Qaaxo Leggings", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    neck="Breeze Gorget",
    waist="Caudata Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Ifrit Ring",
    right_ring="Epona's Ring",
    back="Rancorous Mantle",
}
	sets.precast.WS["Victory Smite"].Att =  {ammo="Ginsen",
		head="Whirlpool Mask",neck="Breeze Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Shneddick Tabard +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Rancorous Mantle",waist="Caudata Belt",legs="Ighwa Trousers",feet={ name="Qaaxo Leggings", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}}}
		sets.precast.WS["Victory Smite"].Mod =  {ammo="Thew Bomblet",
		head="Uk'Uxkaj Cap",neck="Breeze Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Ifrit Ring",ring2="Epona's Ring",
		back="Rancorous Mantle",waist="Caudata Belt",legs="Otronif Brais",feet="Qaaxo Leggings"}

	sets.precast.WS['Shijin Spiral']     = set_combine(sets.precast.WS, {ammo="Jukukki Feather",
		head="Whirlpool Mask",neck="Moepapa Medal",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves +1",ring1="Thundersoul Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Wanion Belt",legs="Manibozho Brais",feet="Daihanshi Habaki"})
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {ammo="Jukukki Feather",
		head="Whirlpool Mask",neck="Moepapa Medal",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves +1",ring1="Thundersoul Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Daihanshi Habaki"})
	sets.precast.WS['Shijin Spiral'].Mod = set_combine(sets.precast.WS['Shijin Spiral'])

	sets.precast.WS['Asuran Fists']     = set_combine(sets.precast.WS, {ring1="Mars's Ring"})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {ring="Mars's Ring"})
	sets.precast.WS['Asuran Fists'].Mod = set_combine(sets.precast.WS['Asuran Fists'], {ring1="Mars's Ring" })



	sets.precast.WS['Cataclysm'] = {
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt"}
	
	


	

	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		body="Melee Cyclas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {

    ammo="Inlamvuyeso",
    head="Lithelimb Cap",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Qaaxo Tights", augments={'HP+75','Mag. Evasion+15','Phys. dmg. taken -5',}},
    feet="Hermes' Sandals",
    neck="Twilight Torque",
    waist="Black Belt",
    left_ear="Sanare Earring",
    right_ear="Flashward Earring",
    left_ring="Sheltered Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}
	sets.idle.Town = {

    ammo="Inlamvuyeso",
    head="Lithelimb Cap",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Qaaxo Tights", augments={'HP+75','Mag. Evasion+15','Phys. dmg. taken -5',}},
    feet="Hermes' Sandals",
    neck="Twilight Torque",
    waist="Black Belt",
    left_ear="Sanare Earring",
    right_ear="Flashward Earring",
    left_ring="Sheltered Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}
	sets.idle.Weak = {

    ammo="Inlamvuyeso",
    head="Lithelimb Cap",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Qaaxo Tights", augments={'HP+75','Mag. Evasion+15','Phys. dmg. taken -5',}},
    feet={ name="Otronif Boots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Dbl.Atk."+2',}},
    neck="Twilight Torque",
    waist="Black Belt",
    left_ear="Cassie Earring",
    right_ear="Upsurge Earring",
    left_ring="K'ayres Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}
	
	-- Defense sets
	sets.defense.PDT ={
   ammo="Inlamvuyeso",
    head="Lithelimb Cap",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Qaaxo Tights", augments={'HP+75','Mag. Evasion+15','Phys. dmg. taken -5',}},
    feet={ name="Qaaxo Leggings", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    neck="Twilight Torque",
    waist="Black Belt",
    left_ear="Sanare Earring",
    right_ear="Flashward Earring",
    left_ring="Patricius Ring",
    right_ring="Defending Ring",
    back="Mollusca Mantle",
}

	sets.defense.HP = {

    ammo="Inlamvuyeso",
    head="Lithelimb Cap",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Qaaxo Tights", augments={'HP+75','Mag. Evasion+15','Phys. dmg. taken -5',}},
    feet={ name="Otronif Boots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Dbl.Atk."+2',}},
    neck="Twilight Torque",
    waist="Black Belt",
    left_ear="Cassie Earring",
    right_ear="Upsurge Earring",
    left_ring="Beeline Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}

	sets.defense.MDT ={main="Tinhaspa",ammo="Inlamvuyeso",
		head="Lithelimb Cap",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},ring1="Epona's Ring",ring2="Defending Ring",
		back="Letalis Mantle",waist="Winfbuffet Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.Kiting = {feet="Hermes' Sandals"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee sets
	sets.engaged = {

    ammo="Ginsen",
    head="Felistris Mask",
    body={ name="Qaaxo Harness", augments={'Attack+15','Evasion+15','"Dbl.Atk."+2',}},
    hands={ name="Qaaxo Mitaines", augments={'Attack+15','Evasion+15','"Dbl.Atk."+2',}},
    legs="Hesychast's Hose +1",
    feet="Anch. Gaiters +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",
}
	sets.engaged.HF = set_combine(sets.engaged, {

    ammo="Ginsen",
    head="Felistris Mask",
    body="Thaumas Coat",
    hands={ name="Qaaxo Mitaines", augments={'Attack+15','Evasion+15','"Dbl.Atk."+2',}},
    legs="Hesychast's Hose +1",
    feet="Anch. Gaiters +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back="Atheling Mantle",
})
	sets.engaged.Impetus = set_combine(sets.engaged, {

    ammo="Ginsen",
    head="Felistris Mask",
    body="Thaumas Coat",
    hands={ name="Qaaxo Mitaines", augments={'Attack+15','Evasion+15','"Dbl.Atk."+2',}},
    legs="Hesychast's Hose +1",
    feet="Anch. Gaiters +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",
})


	sets.engaged.HF.Impetus = set_combine(sets.engaged.HF, {

    ammo="Ginsen",
    head="Felistris Mask",
    body="Tantra Cyclas +2",
    hands={ name="Qaaxo Mitaines", augments={'Attack+15','Evasion+15','"Dbl.Atk."+2',}},
    legs="Hesychast's Hose +1",
    feet="Anch. Gaiters +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back="Atheling Mantle",
})
	sets.engaged.Acc = {
    ammo="Honed Tathlum",
    head="Felistris Mask",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Hes. Hose +1", augments={'Enhances "Hundred Fists" effect',}},
    feet="Anch. Gaiters +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Rajas Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",
}
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Qaaxo Mitaines",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Anchorite's Gaiters +1"})	
	sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc.HF, {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Qaaxo Mitaines",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"})
	sets.engaged.Mod = {

    ammo="Honed Tathlum",
    head="Whirlpool Mask",
    body="Thaumas Coat",
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs={ name="Manibozho Brais", augments={'Attack+15','Accuracy+10','STR+10',}},
    feet="Manibozho Boots",
    neck="Rancor Collar",
    waist="Windbuffet Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Rajas Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",
}
	sets.engaged.iLvl ={

    ammo="Honed Tathlum",
    head="Whirlpool Mask",
    body={ name="Qaaxo Harness", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    hands={ name="Qaaxo Mitaines", augments={'Accuracy+15','STR+7','Phys. dmg. taken -3',}},
    legs="Ighwa Trousers",
    feet={ name="Qaaxo Leggings", augments={'Attack+15','"Mag.Atk.Bns."+15','STR+12',}},
    neck="Ziel Charm",
    waist="Hurch'lan Sash",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Mars's Ring",
    right_ring="Epona's Ring",
    back="Letalis Mantle",
}
	sets.engaged.PDT = {main="Tinhaspa",ammo="Brigantia Pebble",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Merman's Earring",ear2="Merman's Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Patricius Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.PDT.HF = sets.engaged.PDT
	sets.engaged.PDT.HF.Impetus = set_combine(sets.engaged.PDT, {body="Otronif Harness +1"})
	sets.engaged.Acc.PDT = {main="Tinhaspa",ammo="Honed Tathlum",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Patricius Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT.HF = sets.engaged.Acc.PDT
	sets.engaged.Acc.PDT.HF.Impetus = set_combine(sets.engaged.Acc.PDT, {body="Otronif Harness +1"})
	sets.engaged.Acc.Impetus =  {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ziel Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Qaaxo Mitaines",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Ighwa Trousers",feet="Anchorite's Gaiters +1"}
	
	sets.engaged.Acc.HP =  {ammo="Ginsen",
		head="Felistris Mask",neck="Rancor Collar",ear1="Trux Earring",ear2="Brutal Earring",
		body="Thaumas Coat",hands="Qaaxo Mitaines",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.HP.HF = sets.engaged.Acc.HP
	sets.engaged.Acc.HP.HF.Impetus = set_combine(sets.engaged.Acc.HP, {body="Otronif Harness +1"})
	sets.engaged.Counter =  {ammo="Ginsen",
		head="Felistris Mask",neck="Rancor Collar",ear1="Trux Earring",ear2="Brutal Earring",
		body="Thaumas Coat",hands="Qaaxo Mitaines",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Counter.HF = sets.engaged.Counter
	sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Otronif Harness +1"})
	sets.engaged.Acc.Counter = {ammo="Ginsen",
		head="Felistris Mask",neck="Rancor Collar",ear1="Trux Earring",ear2="Brutal Earring",
		body="Thaumas Coat",hands="Qaaxo Mitaines",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.Counter.HF = sets.engaged.Acc.Counter
	sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Otronif Harness +1"})

	-- Footwork combat form
	sets.engaged.Footwork = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose",feet="Anchorite's Gaiters"}
	sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Hesychast's Hose",feet="Anchorite's Gaiters"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Don't gearswap for weaponskills when Defense is on.
	if spell.type:lower() == 'weaponskill' and state.Defense.Active then
		eventArgs.handled = true
	elseif spell.type == 'Waltz' then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' and not state.Defense.Active then
		if buffactive.impetus and (spell.english == "Victory Smite" or spell.english == "Victory Smite") then
			equip({body="Tantra Cyclas +2"})
		elseif buffactive.footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
			equip({feet="Anchorite's Gaiters"})
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other game events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- Set Footwork as combat form any time it's active and Hundred Fists is not.
	if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
		state.CombatForm = 'Footwork'
	elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
		state.CombatForm = 'Footwork'
	else
		state.CombatForm = nil
	end
	
	-- Hundred Fists and Impetus modify the custom melee groups
	if buff == "Hundred Fists" or buff == "Impetus" then
		classes.CustomMeleeGroups:clear()
		
		if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
			classes.CustomMeleeGroups:append('HF')
		end
		
		if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
		end
	end

	-- Update gear if any of the above changed
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
		handle_equipping_gear(player.status)
	end
end


-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
	update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
	if buffactive.footwork and not buffactive['hundred fists'] then
		return 'Footwork'
	end
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	
	if buffactive['hundred fists'] then
		classes.CustomMeleeGroups:append('HF')
	end
	
	if buffactive.impetus then
		classes.CustomMeleeGroups:append('Impetus')
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 9)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 9)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 9)
	else
		set_macro_page(1, 9)
	end
end	


