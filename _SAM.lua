-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	function is_sc_element_today()
	skillchain_elements = {}
skillchain_elements.Light = S{'Light','Fire','Wind','Lightning'}
skillchain_elements.Darkness = S{'Dark','Ice','Earth','Water'}
skillchain_elements.Fusion = S{'Light','Fire'}
skillchain_elements.Fragmentation = S{'Wind','Lightning'}
skillchain_elements.Distortion = S{'Ice','Water'}
skillchain_elements.Gravitation = S{'Dark','Earth'}
skillchain_elements.Transfixion = S{'Light'}
skillchain_elements.Compression = S{'Dark'}
skillchain_elements.Liquification = S{'Fire'}
skillchain_elements.Induration = S{'Ice'}
skillchain_elements.Detonation = S{'Wind'}
skillchain_elements.Scission = S{'Earth'}
skillchain_elements.Impaction = S{'Lightning'}
skillchain_elements.Reverberation = S{'Water'}
end
end
-- Elements for skillchain names
skillchain_elements = {}
skillchain_elements.Light = S{'Light','Fire','Wind','Lightning'}
skillchain_elements.Darkness = S{'Dark','Ice','Earth','Water'}
skillchain_elements.Fusion = S{'Light','Fire'}
skillchain_elements.Fragmentation = S{'Wind','Lightning'}
skillchain_elements.Distortion = S{'Ice','Water'}
skillchain_elements.Gravitation = S{'Dark','Earth'}
skillchain_elements.Transfixion = S{'Light'}
skillchain_elements.Compression = S{'Dark'}
skillchain_elements.Liquification = S{'Fire'}
skillchain_elements.Induration = S{'Ice'}
skillchain_elements.Detonation = S{'Wind'}
skillchain_elements.Scission = S{'Earth'}
skillchain_elements.Impaction = S{'Lightning'}
skillchain_elements.Reverberation = S{'Water'}
-- Setup vars that are user-independent.
function job_setup()
	state.CombatForm = get_combat_form()
	
	state.Buff.Sekkanoki = buffactive.sekkanoki or false
	state.Buff.Sengikori = buffactive.sengikori or false
	state.Buff['Meikyou Shisui'] = buffactive['Meikyou Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Acc2', 'Acc3'}
	options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
	options.WeaponskillModes = {'Normal', 'day', 'Acc', 'Acc2', 'Mod'}
	options.CastingModes = {'Normal', 'Fury', 'Smite'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Reraise'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	send_command('unbind ^`')
	send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {head="Myochin Kabuto",hands="Saotome Kote +2"}
	sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
	sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Yaoyotl Helm",
		body="Otronif Harness +1",hands="Buremte Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Phorcys Korazin",hands="Mikinaak Gauntlets",ring1="Ifrit Ring",ring2="Rajas Ring",
		back="Letalis Mantle",waist="Light Belt",legs="Mikinaak Cuisses",feet="Whirlpool Greaves"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] = {
    main="Tsurumaru",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head={ name="Otomi Helm", augments={'Haste+2','"Snapshot"+2','STR+8',}},
    body="Phorcys Korazin",
    hands="Mikinaak Gauntlets",
    legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+2',}},
    feet="Gor. Sollerets +1",
    neck="Snow Gorget",
    waist="Light Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Pyrosoul Ring",
    back="Buquwik Cape",
}
	sets.precast.WS['Tachi: Fudo'].day = {
    main="Tsurumaru",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head="Gavialis Helm",
    body="Phorcys Korazin",
    hands="Boor Bracelets",
    legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+2',}},
    feet="Gor. Sollerets +1",
    neck="Snow Gorget",
    waist="Light Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Pyrosoul Ring",
    back="Buquwik Cape",
}
	sets.precast.WS['Tachi: Fudo'].Acc ={
    main="Tsurumaru",
    sub="Bloodrain Strap",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head="Yaoyotl Helm",
    body="Phorcys Korazin",
    hands={ name="Buremte Gloves", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%','STR+8',}},
    legs={ name="Miki. Cuisses", augments={'Attack+15','Accuracy+10','STR+10',}},
    feet={ name="Xaddi Boots", augments={'Attack+15','STR+7','"Dbl.Atk."+2',}},
    neck="Snow Gorget",
    waist="Light Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Pyrosoul Ring",
    back="Buquwik Cape",
}
	sets.precast.WS['Tachi: Fudo'].Mod = {
    main="Tsurumaru",
    sub="Bloodrain Strap",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head="Yaoyotl Helm",
    body="Phorcys Korazin",
    hands={ name="Miki. Gauntlets", augments={'Attack+15','Accuracy+10','STR+10',}},
    legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+2',}},
    feet={ name="Xaddi Boots", augments={'Attack+15','STR+7','"Dbl.Atk."+2',}},
    neck="Snow Gorget",
    waist="Light Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Pyrosoul Ring",
    back="Buquwik Cape",
}
	sets.precast.WS['Tachi: Fudo'].Acc2 ={
    main="Tsurumaru",
    sub="Bloodrain Strap",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head="Yaoyotl Helm",
    body={ name="Miki. Breastplate", augments={'Attack+15','Accuracy+10','STR+10',}},
    hands={ name="Miki. Gauntlets", augments={'Attack+15','Accuracy+10','STR+10',}},
    legs={ name="Miki. Cuisses", augments={'Attack+15','Accuracy+10','STR+10',}},
    feet={ name="Xaddi Boots", augments={'Attack+15','STR+7','"Dbl.Atk."+2',}},	
    neck="Snow Gorget",
    waist="Light Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Rajas Ring",
    back="Letalis Mantle",
}
	sets.precast.WS['Tachi: Shoha'] = {
		head="Yaoyotl Helm",neck="Breeze Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Phorcys Korazin",hands="Boor Bracelets",ring1="Pyrosoul Ring",ring2="Rajas Ring",
		back="Buquwik Cape",waist="Thunder Belt",legs="Mikinaak Cuisses",feet="Xaddi Boots"}
	sets.precast.WS['Tachi: Shoha'].Acc =  {
		head="Yaoyotl Helm",neck="Breeze Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Phorcys Korazin",hands="Mikinaak Gauntlets",ring1="Pyrosoul Ring",ring2="Rajas Ring",
		back="Buquwik Cape",waist="Thunder Belt",legs="Mikinaak Cuisses",feet="Whirlpool Greaves"}
	sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Thunder Belt"})

	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
	sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
	sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Snow Belt"})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})

	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})

	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})


	-- Midcast Sets	
	sets.midcast.FastRecast = {
		head="Yaoyotl Helm",
		body="Otronif Harness +1",hands="Otronif Gloves",
		legs="Phorcys Dirs",feet="Otronif Boots +1"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
	    main="Tsurumaru", sub="Bloodrain Strap",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Flashward Earring",
		body="Otronif Harness +1",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Flume Belt",legs="Xaddi Cuisses",feet="Danzo Sune-ate"}
	
	sets.idle.Field = {
	    main="Tsurumaru", sub="Bloodrain Strap",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Flashward Earring",
		body="Otronif Harness +1",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Flume Belt",legs="Xaddi Cuisses",feet="Danzo Sune-ate"}
	sets.idle.Weak = {
    head="Lithelimb Cap",
    body={ name="Otro. Harness +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Crit.hit rate+2',}},
    hands="Umuthi Gloves",
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet={ name="Otronif Boots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Dbl.Atk."+2',}},
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Upsurge Earring",
    right_ear="Cassie Earring",
    left_ring="K'ayres Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}
	
	-- Defense sets
	sets.defense.PDT = {
	    main="Tsurumaru", sub="Bloodrain Strap",
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Flashward Earring",
		body="Otronif Harness +1",hands="Umuthi Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Xaddi Cuisses",feet="Otronif Boots +1"}

	sets.defense.Reraise = {
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

	sets.defense.MDT = {
		head="Lithelimb Cap",neck="Agitator's Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Umuthi Gloves",ring1="Patricius Ring",ring2="Defending Ring",
		back="Takaha Mantle",waist="Dynamic Belt +1",legs="Xaddi Cuisses",feet="Gorney Sollerets +1"}

	sets.Kiting = {
back="Mecisto. Mantle"
}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
	sets.engaged = {   	    main="Tsurumaru", sub="Bloodrain Strap",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Xaddi Gauntlets",ring1="K'ayres Ring",ring2="Rajas Ring",
		back="Takaha Mantle",waist="Windbuffet Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc = {	    main="Tsurumaru", sub="Bloodrain Strap",head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Xaddi Gauntlets",ring1="K'ayres Ring",ring2="Rajas Ring",
		back="Takaha Mantle",waist="Dynamic Belt +1",legs="Xaddi Cuisses",feet="Mikinaak Greaves"}
	sets.engaged.PDT = {	    main="Tsurumaru", sub="Bloodrain Strap",head="Lithelimb Cap",neck="Ziel Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Umuthi Gloves",ring1="Rajas Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Flume Belt",legs="Xaddi Cuisses",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT = {	    main="Tsurumaru", sub="Bloodrain Strap",ammo="Honed Tathlum",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
	sets.engaged.Reraise = {
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
		back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
	sets.engaged.Acc.Reraise = {
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
		
	-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
	-- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
	sets.engaged.Adoulin = {	    main="Tsurumaru", sub="Bloodrain Strap",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Xaddi Gauntlets",ring1="K'ayres Ring",ring2="Rajas Ring",
		back="Takaha Mantle",waist="Windbuffet Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Adoulin.Acc ={
    main="Tsurumaru",
    sub="Bloodrain Strap",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
		head="Yaoyotl Helm",
    body={ name="Xaddi Mail", augments={'Attack+15','Accuracy+10','"Store TP"+3',}},
    hands={ name="Xaddi Gauntlets", augments={'Accuracy+15','"Store TP"+3','"Dbl.Atk."+2',}},
    legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+2',}},
    feet={ name="Otronif Boots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Dbl.Atk."+2',}},
    neck="Ganesha's Mala",
    waist="Windbuffet Belt",
ear1="Bladeborn Earring",ear2="Steelflash Earring",
    left_ring="Oneiros Ring",
    right_ring="Rajas Ring",
    back="Letalis Mantle",
}
	sets.engaged.Adoulin.Acc2 ={

    main="Tsurumaru",
    sub="Bloodrain Strap",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head="Yaoyotl Helm",
    body={ name="Xaddi Mail", augments={'Attack+15','Accuracy+10','"Store TP"+3',}},
    hands={ name="Xaddi Gauntlets", augments={'Accuracy+15','"Store TP"+3','"Dbl.Atk."+2',}},
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet={ name="Xaddi Boots", augments={'Attack+15','STR+7','"Dbl.Atk."+2',}},
    neck="Ganesha's Mala",
    waist="Windbuffet Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="K'ayres Ring",
    right_ring="Rajas Ring",
    back="Letalis Mantle",
}
	sets.engaged.Adoulin.Acc3	 ={
    main="Tsurumaru",
    sub="Bloodrain Strap",
    range={ name="Cibitshavore", augments={'STR+12','Rng.Acc.+10','"Store TP"+7',}},
    head="Yaoyotl Helm",
    body={ name="Xaddi Mail", augments={'Attack+15','Accuracy+10','"Store TP"+3',}},
    hands={ name="Xaddi Gauntlets", augments={'Accuracy+15','"Store TP"+3','"Dbl.Atk."+2',}},
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet={ name="Xaddi Boots", augments={'Attack+15','STR+7','"Dbl.Atk."+2',}},
    neck="Iqabi Necklace",
    waist="Dynamic Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Patricius Ring",
    right_ring="Rajas Ring",
    back="Takaha Mantle",
}
	sets.engaged.Adoulin.PDT = {	    main="Tsurumaru", sub="Bloodrain Strap",head="Lithelimb Cap",neck="Ziel Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Umuthi Gloves",ring1="Rajas Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Flume Belt",legs="Xaddi Cuisses",feet="Otronif Boots +1"}
	sets.engaged.Adoulin.Acc.PDT = {	    main="Tsurumaru", sub="Bloodrain Strap",ammo="Honed Tathlum",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
	sets.engaged.Adoulin.Reraise = {
    head="Lithelimb Cap",
    body={ name="Otro. Harness +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Crit.hit rate+2',}},
    hands="Umuthi Gloves",
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet="Gorney Sollerets +1",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Upsurge Earring",
    right_ear="Cassie Earring",
    left_ring="K'ayres Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}
	sets.engaged.Adoulin.Acc.Reraise = {
    head="Lithelimb Cap",
    body={ name="Otro. Harness +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Crit.hit rate+2',}},
    hands="Umuthi Gloves",
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet="Gorney Sollerets +1",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Upsurge Earring",
    right_ear="Cassie Earring",
    left_ring="K'ayres Ring",
    right_ring="Defending Ring",
    back="Repulse Mantle",
}

	sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
	sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
	sets.buff['Meikyou Shisui'] = {feet="Sakonji Sune-ate"}
	            sets.WSDayBonus = {head="Gavialis Helm"}
end


			

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('@input /ws "Penta Thrust" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
				if spell.type == 'WeaponSkill' then
    if is_sc_element_today(spell) then
        equip(sets.WSDayBonus)
    end
end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
		if state.Buff.Sengikori then
			equip(sets.buff.Sengikori)
		end
		if state.Buff['Meikyou Shisui'] then
			equip(sets.buff['Meikyou Shisui'])
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.DefenseMode == 'Reraise' or
		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.english] ~= nil then
			state.Buff[spell.english] = true
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

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

-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
end

-- Set eventArgs.handled to true if we don't 	t the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		return 'Adoulin'
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 11)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 11)
	elseif player.sub_job == 'THF' then
		set_macro_page(3, 11)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 11)
	else
		set_macro_page(1, 11)
	end

end


