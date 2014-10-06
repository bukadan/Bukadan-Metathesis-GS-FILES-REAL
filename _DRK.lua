	

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
    
     
     
    -- Setup vars that are user-dependent.  Can override this function in a sidecar file.
    function user_setup()
            -- Options: Override default values
            options.OffenseModes = {'Normal', 'Acc', 'Multi'}
            options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
            options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Off','Smite','Hell'}
            options.IdleModes = {'Normal'}
            options.RestingModes = {'Normal'}
            options.PhysicalDefenseModes = {'PDT', 'Reraise'}
            options.MagicalDefenseModes = {'MDT'}
     
            state.Defense.PhysicalMode = 'PDT'
			
			adjust_engaged_sets()
	 
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
            sets.precast.JA['Diabolic Eye'] = {hands="Abyss Gauntlets +2"}
            sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets"}
            sets.precast.JA['Nether Void'] = {legs="Bale Flanchard +2"}
     
                   
            -- Waltz set (chr and vit)
            sets.precast.Waltz = {ammo="Sonia's Plectrum",
                    head="Yaoyotl Helm",
                    body="Mikinaak Breastplate",hands="Buremte Gloves",
                    legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
                   
            -- Don't need any special gear for Healing Waltz.
            sets.precast.Waltz['Healing Waltz'] = {}
           
            -- Fast cast sets for spells
                     
            -- Midcast Sets
            sets.midcast.FastRecast = {ammo="Impatiens",
                    head="Khthoinios Helm",neck="Dark Torque",ear1="Loquacious Earring",ear2="Dark Earring",
                    body="Demon's Harness",hands="Abyss Gauntlets +2",ring1="Prolix Ring",ring2="K'ayres Ring",
                    back="Chuparrosa Mantle",waist="Casso Sash",legs="Bale Flanchard +2",feet="Whirlpool Greaves"}

	
					
            -- Specific spells
            sets.midcast.Utsusemi = {ammo="Impatiens",
                    head="Cizin Helm +1",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Moonshade Earring",
                    body="Nuevo Coselete",hands="Cizin Mufflers",ring1="Prolix Ring",ring2="K'ayres Ring",
                    waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
     
            sets.midcast['Dark Magic'] = {ammo="Impatiens",
                    head="Khthonios Helm",neck="Dark Torque",ear1="Loquacious Earring",ear2="Dark Earring",
                    body="Demon's Harness",hands="Abyss Gauntlets +2",ring1="Prolix Ring",ring2="K'ayres Ring",
                    back="Chuparrosa Mantle",waist="Casso Sash",legs="Bale Flanchard +2",feet="Whirlpool Greaves"}
           
		    sets.midcast['Enfeebling Magic'] = sets.midcast.DarkMagic
		   
            sets.midcast['Dread Spikes'] = {body="Bale Cuirass +2"}
           
            sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {
                    head="Cizin Helm +1",ear1="Lifestorm Earring",ear2="Psystorm Earring",
                    ring2="Balrahn's Ring"})
                   
            sets.midcast.Drain = {ammo="Impatiens",
                    head="Khthoinios Helm",neck="Dark Torque",ear1="Loquacious Earring",ear2="Dark Earring",
                    body="Demon's Harness",hands="Abyss Gauntlets +2",ring1="Prolix Ring",ring2="K'ayres Ring",
                    back="Chuparrosa Mantle",waist="Dynamic Belt +1",legs="Bale Flanchard +2",feet="Whirlpool Greaves"}
                   
            sets.midcast.Aspir = sets.midcast.Drain
						                   
            -- Weaponskill sets
            -- Default set for any weaponskill that isn't any more specifically defined
            sets.precast.WS = {ammo="Ginsen",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Brutal Earring",ear2="Moonshade Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Spiral Ring",
                    back="Atheling Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})
     
            -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
            sets.precast.WS['Requiescat'] =  {ammo="Ginsen",
                    head="Yaoyotl Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Xaddi Gauntlets",ring2="Rajas Ring",ring1="Aquasoul Ring",
                    back="Letalis Mantle",waist="Soil Belt",legs="Mikinaak Greaves",feet="Whirlpool Greaves"}
            sets.precast.WS['Requiescat'].Acc = {ammo="Aqreqaq Bomblet",
                    head="Yaoyotl Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring2="Rajas Ring",ring1="Aquasoul Ring",
                    back="Atheling Mantle",waist="Soil Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}
            sets.precast.WS['Requiescat'].Mod = {ammo="Aqreqaq Bomblet",
                    head="Yaoyotl Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Mikinaak Breastplate",hands="Cizin Mufflers",ring2="Rajas Ring",ring1="Aquasoul Ring",
                    back="Atheling Mantle",waist="Soil Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}
     
            sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {neck="Soil Gorget",legs="Cizin Breeches"})
            sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {neck="Soil Gorget",legs="Cizin Breeches"})
            sets.precast.WS['Entropy'].Mod = set_combine(sets.precast.WS['Entropy'], {waist="Soil Belt",legs="Cizin Breeches"})

            sets.precast.WS['Requiescat'] = {ammo="Ginsen",
                    head="Lithelimb Cap",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail +1",hands="Buremte Gloves",ring2="Rajas Ring",ring1="Aquasoul Ring",
                    back="Atheling Mantle",waist="Soil Belt",legs="Osmium Cuisses",feet="Whirlpool Greaves"}
            sets.precast.WS['Requiescat'].acc = {ammo="Ginsen",
                    head="Yaoyotl Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail +1",hands="Buremte Gloves",ring2="Rajas Ring",ring1="Aquasoul Ring",
                    back="Letalis Mantle",waist="Soil Belt",legs="Mikinaak Cuisses",feet="Whirlpool Greaves"}
					
            sets.precast.WS['Resolution'] = {ammo="Aqreqaq Bomblet",
                    head="Otomi Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Xaddi Mail",hands="Mikinaak Gauntlets",ring2="Rajas Ring",ring1="Pyrosoul Ring",
                    back="Letalis Mantle",waist="Soil Belt",legs="Mikinaak Cuisses",feet="Whirlpool Greaves"}
            sets.precast.WS['Resolution'].Acc = {ammo="Ginsen",
                    head="Yaoyotl Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Xaddi Mail",hands="Xaddi Gauntlets",ring2="Rajas Ring",ring1="Pyrosoul Ring",
                    back="Letalis Mantle",waist="Soil Belt",legs="Mikinaak Cuisses",feet="Whirlpool Greaves"}
            sets.precast.WS['Resolution'].Mod = {ammo="Aqreqaq Bomblet",
                    head="Yaoyotl Helm",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Xaddi Mail",hands="Mikinaak Gauntlets",ring2="Rajas Ring",ring1="Pyrosoul Ring",
                    back="Atheling Mantle",waist="Soil Belt",legs="Mikinaak Cuisses",feet="Whirlpool Greaves"}
     
     
           
            -- Sets to return to when not performing an action.
           
            -- Resting sets
            sets.resting = {head="Yaoyotl Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Ares' cuirass +1",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
                    back="Letalis Mantle",waist="Goading Belt",legs="Blood Cuisses",feet="Ejekamal Boots"}
           
     
            -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
            sets.idle.Town = {ammo="Brigantia Pebble",
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Impregnable Earring",ear2="Flashward Earring",
                    body="Cizin Mail +1",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
                    back="Repulse Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Gorney Sollerets +1"}
           
            sets.idle.Field =  {ammo="Brigantia Pebble",
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Impregnable Earring",ear2="Flashward Earring",
                    body="Cizin Mail +1",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
                    back="Repulse Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Gorney Sollerets +1"}
     
            sets.idle.Weak ={ammo="Brigantia Pebble",
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Impregnable Earring",ear2="Flashward Earring",
                    body="Cizin Mail +1",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Defending Ring",
                    back="Repulse Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Gorney Sollerets +1"}
           
            -- Defense sets
            sets.defense.PDT = {ammo="Brigantia Pebble",
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Impregnable Earring",ear2="Sanare Earring",
                    body="Cizin Mail +1",hands="Umuthi Gloves",ring1="Patricius Ring",ring2="Defending Ring",
                    back="Mollusca Mantle",waist="Flume Belt",legs="Xaddi Cuisses",feet="Cizin Greaves +1"}
     
            sets.defense.Reraise = {ammo="Brigantia Pebble",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Sanare Earring",ear2="Merman's Earring",
                    body="Twilight Mail",hands="Cizin Mufflers +1",ring1="Sheltered Ring",ring2="Defending Ring",
                    back="Repulse Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Cizin Greaves +1"}
     
            sets.defense.MDT = {
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Merman's Earring",
                    body="Cizin Mail +1",hands="Cizin Mufflers +1",ring1="Patricius Ring",ring2="Defending Ring",
                    back="Mollusca Mantle",waist="Flume Belt",legs="Cizin Breeches +1",feet="Cizin Greaves +1"}
     
            sets.Kiting = {legs="Blood Cuisses"}
     
            sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
     
            -- Engaged sets
     sets.engaged = {ammo="Ginsen",
		head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Xaddi Gauntlets",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Mikinaak Greaves"}
	sets.engaged.Acc = {ammo="Ginsen",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Xaddi Gauntlets",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Xaddi Cuisses",feet="Mikinaak Greaves"}
	sets.engaged = {ammo="Ginsen",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Pak Corselet",hands="Cizin Mufflers",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
	sets.engaged.Multi = {ammo="Ginsen",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Buremte Gloves",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Letalis Mantle",waist="Dynamic Belt +1",legs="Cizin Breeches",feet="Whirlpool Greaves"}	
	sets.engaged.Reraise = {ammo="Fire Bomblet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Cizin Muffler",ring1="Dark Ring",ring2="Dark Ring",
		back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Greaves"}
	
	 
            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion
           
            -- Normal melee group
					
            sets.engaged['Eminent Scimitar'] = {ammo="Ginsen",
		head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Cizin Mufflers",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Mikinaak Greaves"}
	
            sets.engaged['Eminent Scimitar'].Acc = {ammo="Ginsen",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Cizin Mufflers",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}		
            sets.engaged['Eminent Scimitar'].Multi = {ammo="Ginsen",
	head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Buremte Gloves",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Letalis Mantle",waist="Dynamic Belt +1",legs="Cizin Breeches",feet="Whirlpool Greaves"}	
		-- C
	
            sets.engaged['Crobaci +2'] = {
    main={ name="Crobaci +2", augments={'DMG:+25','"Store TP"+3','Crit.hit rate+1',}},
    sub="Bloodrain Strap",
    ammo="Ginsen",
    head="Yaoyotl Helm",
    body={ name="Xaddi Mail", augments={'Attack+15','Accuracy+10','"Store TP"+3',}},
    hands={ name="Xaddi Gauntlets", augments={'Accuracy+15','"Store TP"+3','"Dbl.Atk."+2',}},
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet={ name="Mikinaak Greaves", augments={'Accuracy+15','Attack+10','DEX+10',}},
    neck="Ganesha's Mala",
    waist="Windbuffet Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="K'ayres Ring",
    right_ring="Rajas Ring",
    back="Letalis Mantle",
}
            sets.engaged['Crobaci +2'].Acc = {
    main={ name="Crobaci +2", augments={'DMG:+25','"Store TP"+3','Crit.hit rate+1',}},
    sub="Bloodrain Strap",
    ammo="Ginsen",
    head="Yaoyotl Helm",
    body={ name="Miki. Breastplate", augments={'Attack+15','Accuracy+10','STR+10',}},
    hands={ name="Xaddi Gauntlets", augments={'Accuracy+15','"Store TP"+3','"Dbl.Atk."+2',}},
    legs={ name="Xaddi Cuisses", augments={'HP+45','Accuracy+15','Phys. dmg. taken -3',}},
    feet={ name="Mikinaak Greaves", augments={'Accuracy+15','Attack+10','DEX+10',}},
    neck="Ziel Charm",
    waist="Dynamic Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Mars's Ring",
    right_ring="Rajas Ring",
    back="Letalis Mantle",
}
            sets.engaged['Crobaci +2'].Multi ={ammo="Ginsen",
		head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Xaddi Mail",hands="Buremte Gloves",ring2="Rajas Ring",ring1="K'ayres Ring",
		back="Letalis Mantle",waist="Dynamic Belt +1",legs="Cizin Breeches",feet="Whirlpool Greaves"}	
            sets.engaged['Crobaci +2'].Multi.PDT = {ammo="Ginsen",
                    head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Cizin Mail",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
            sets.engaged['Crobaci +2'].Multi.Reraise = {ammo="Ginsen",
                    head="Twilight Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Pak Corselet",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
            sets.engaged['Crobaci +2'].PDT =  {
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Merman's Earring",
                    body="Cizin Mail +1",hands="Cizin Mufflers +1",ring1="Patricius Ring",ring2="Defending Ring",
                    back="Mollusca Mantle",waist="Flume Belt",legs="Cizin Breeches +1",feet="Cizin Greaves +1"}
            sets.engaged['Crobaci +2'].Acc.PDT =  {
                    head="Lithelimb Cap",neck="Twilight Torque",ear1="Sanare Earring",ear2="Merman's Earring",
                    body="Cizin Mail +1",hands="Cizin Mufflers +1",ring1="Patricius Ring",ring2="Defending Ring",
                    back="Mollusca Mantle",waist="Flume Belt",legs="Cizin Breeches +1",feet="Cizin Greaves +1"}
            sets.engaged['Crobaci +2'].Reraise = {ammo="Ginsen",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
            sets.engaged['Crobaci +2'].Acc.Reraise = {ammo="Ginsen",
                    head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
                    body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
                    back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
     
    end
     
    -------------------------------------------------------------------------------------------------------------------
    -- Job-specific hooks that are called to process player actions at specific points in time.
    -------------------------------------------------------------------------------------------------------------------
     
  
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    -- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
    function job_precast(spell, action, spellMap, eventArgs)
            if spell.action_type == 'Magic' then
            equip(sets.precast.FC)
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
            if state.DefenseMode == 'Reraise' or
                    (state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
                    equip(sets.Reraise)
            end
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
  --  function job_aftercast(spell, action, spellMap, eventArgs)
  --      if not spell.interrupted then
  --              if state.Buff[spell.english] ~= nil then
  --                      state.Buff[spell.english] = true
  --              end
  --       end
  --  end
     
    -------------------------------------------------------------------------------------------------------------------
    -- Customization hooks for idle and melee sets, after they've been automatically constructed.
    -------------------------------------------------------------------------------------------------------------------
    -- Modify the default idle set after it was constructed.
    function customize_idle_set(idleSet)
            return idleSet
    end
     
    -- Modify the default melee set after it was constructed.
    function customize_melee_set(meleeSet)
            return meleeSet
    end
     
    -------------------------------------------------------------------------------------------------------------------
    -- General hooks for other events.
    -------------------------------------------------------------------------------------------------------------------
     
    -- Called when the player's status changes.
    function job_status_change(newStatus, oldStatus, eventArgs)
     
    end
     
    -- Called when a player gains or loses a buff.
    -- buff == buff gained or lost
    -- gain == true if the buff was gained, false if it was lost.
    function job_buff_change(buff, gain)
            if buff:startswith('Aftermath') then
                state.Buff.Aftermath = gain
                adjust_melee_groups()
                handle_equipping_gear(player.status)
        end
    end
     
     
    -------------------------------------------------------------------------------------------------------------------
    -- User code that supplements self-commands.
    -------------------------------------------------------------------------------------------------------------------
     
    -- Called by the 'update' self-command, for common needs.
    -- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	adjust_engaged_sets()
end

function adjust_engaged_sets()
	state.CombatWeapon = player.equipment.main
	adjust_melee_groups()
end

function adjust_melee_groups()
	classes.CustomMeleeGroups:clear()
	if state.Buff.Aftermath then
		classes.CustomMeleeGroups:append('AM')
	end
end
     
    function select_default_macro_book()
            -- Default macro set/book
                    set_macro_page(1, 1)
                    -- I realize this will be better used with different /subs per book,
                    -- but I won't worry about that till I get this working properly.
    end
    
    
