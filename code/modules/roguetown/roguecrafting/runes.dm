/obj/item/rune
	var/list/remarks = list() //things to read about while learning.
	var/pages_to_mastery = 5 //Essentially controls how long a mob must keep the rune in his hand to actually successfully learn
	var/reading = FALSE //sanity
	var/oneuse = TRUE //default this is true, but admins can var this to 0 if we wanna all have a pass around of the rod form rune
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/roguetown/items/books.dmi'

/obj/item/rune/proc/turn_page(mob/user)
	//playsound(user, pick('sound/blank.ogg'), 30, TRUE)
	if(do_after(user,50, user))
		return TRUE
	return FALSE

/obj/item/rune/proc/already_known(mob/user)
	return FALSE

/obj/item/rune/proc/on_start(mob/user)
	to_chat(user, "<span class='notice'>I start reading [name]...</span>")

/obj/item/rune/proc/on_stopped(mob/user)
	to_chat(user, "<span class='notice'>I stop reading...</span>")

/obj/item/rune/proc/on_finished(mob/user)
	to_chat(user, "<span class='notice'>I finish reading [name]!</span>")

/obj/item/rune/proc/onlearned(mob/user)
	qdel(src)

/obj/item/rune/attack_self(mob/user)
	if(reading)
		//to_chat(user, "<span class='warning'>You're already reading this!</span>")
		return FALSE
	if(already_known(user))
		to_chat(user, "<span class='notice'>I already know this spell.</span>")
		return FALSE
	if(!user.mind?.get_skill_level(/datum/skill/magic/arcane))
		to_chat(user, "<span class='warning'>I don't have the knowledge to learn this spell.</span>")
		return FALSE
	on_start(user)
	reading = TRUE
	if(remarks.len)
		to_chat(user, "<span class='notice'>[pick(remarks)]</span>")
	for(var/i=1, i<=pages_to_mastery, i++)
		if(!turn_page(user))
			on_stopped()
			reading = FALSE
			return
	if(do_after(user,50, user))
		on_finished(user)
		reading = FALSE
	return TRUE

//Spells
/obj/item/rune/spell
	name = "rune"
	pages_to_mastery = 3
	var/spell
	var/spellname = "no spell"
	icon_state = "spellbookpower1_0" //temporary sprite

/obj/item/rune/spell/on_start(mob/user)
	user.visible_message("<span class='warning'>[user] begins siphoning the rune.</span>")

/obj/item/rune/spell/on_finished(mob/user)
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == spell)
			spell = null
	if(spell)
		to_chat(user, "<span class='notice'>The power of [spellname] is emblazened in your mind!</span>")
		var/obj/effect/proc_holder/spell/S = new spell
		user.mind.AddSpell(S)
		if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
			user.mind.adjust_experience(/datum/skill/magic/arcane, 100, FALSE)
	else if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
		to_chat(user, "<span class='notice'>Arcane power is emblazened in your mind!</span>")
		user.mind.adjust_experience(/datum/skill/magic/arcane, 150, FALSE)
	user.visible_message("<span class='warning'>[src] glows dark, and then crumbles!</span>")
	qdel(src)

/obj/item/rune/spell/fire_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball
	spellname = "fireball"
	// icon_state = "fire_rune"
	name = "fire rune"
	desc = "Warm with power."
	remarks = list("To understand these archaic things...", "Just catching them on fire won't do...", "Accounting for crosswinds... really?", "I think I just burned my hand...")

/obj/item/rune/spell/water_rune
	spell = /obj/effect/proc_holder/spell/targeted/ethereal_jaunt
	spellname = "ethereal jaunt"
	// icon_state = "water_rune"
	name = "water rune"
	desc = "A bit moist."
	remarks = list("To understand these archaic things...", "Mana flows through all living things...", "This spell will fatigue me...", "The spell should flow like water...")

/obj/item/rune/spell/air_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	spellname = "lightning"
	// icon_state = "air_rune"
	name = "air rune"
	desc = "Cool to the touch."
	remarks = list("To understand these archaic things...", "Done properly this could...", "I think I just shocked my hand...")

/obj/item/rune/spell/earth_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fetch
	spellname = "fetch"
	// icon_state = "earth_rune"
	name = "earth rune"
	desc = "Heavier than it looks."
	remarks = list("To understand these archaic things...", "I can only pull, not push...", "My mind feels like mud...")

/obj/item/rune/spell/blank_rune
	spell = null
	spellname = "arcane magic"
	// icon_state = "blank_rune"
	name = "rune essence"
	desc = "The source of magic in our world."
	remarks = list("My head hurts...", "I'll never understand this!", "I don't want to look away...")

// epic custom runebooks

/obj/item/rune/spell/spitfire
	spell = /obj/effect/proc_holder/spell/invoked/projectile/spitfire
	spellname = "spitfire"
	icon_state = "book5_0"
	name = "tome of spitfire"
	desc = "This tome contains detailed instructions on how to cast the spell 'Spitfire', which allows a caster to throw a mote of fire which blinds nearby targets. On a direct hit, it will also burn a single target."
	remarks = list("Think of hot things...", "Grasp the mote between your fingers...", "Wear heat-resistant gloves...", "Don't look directly at the mote...")
	
/obj/item/rune/spell/fireball
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball
	spellname = "fireball"
	icon_state = "spellbookpower1_0"
	name = "tome of fireball"
	desc = "This tome contains detailed instructions on how to cast the spell 'Fireball', which allows a caster to hurl an explosive ball of flame, searing the flesh of and knocking down nearby targets."
	remarks = list("To understand these archaic things...", "Just catching them on fire won't do...", "Accounting for crosswinds... really?", "I think I just burned my hand...")
	
/obj/item/rune/spell/greaterfireball
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball/greater
	spellname = "greater fireball"
	icon_state = "bibble_0"
	name = "tome of greater fireball"
	desc = "This tome contains detailed instructions on how to cast the spell 'Greater Fireball', which allows a caster to hurl an immensley powerful explosive ball of flame, melting and knocking down nearby targets."
	remarks = list("Let it burn inside you...", "Rage fuels the flame of power...", "Do not fumble at all costs...", "Teach them why a mage is to be feared...")

/obj/item/rune/spell/lightning
	spell = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	spellname = "lightning bolt"
	icon_state = "knowledge_0"
	name = "tome of lightning bolt"
	desc = "This tome contains detailed instructions on how to cast the spell 'Lightning Bolt', which allows a caster to shoot a single bolt of lighting from their fingertips, shocking and stunning their target."
	remarks = list("Lightning bolt... lightning bolt...", "Unlimited power...", "I think I just shocked my hand...")
	
/obj/item/rune/spell/magicmissile
	spell = /obj/effect/proc_holder/spell/invoked/projectile/arcanebolt
	spellname = "arcane bolt"
	icon_state = "book7_0"
	name = "tome of arcane bolt"
	desc = "This tome contains detailed instructions on how to cast the spell 'Arcane Bolt', also known as 'Magic Missile'. It allows the caster to hurl a missile of arcane magic that harms a target on a direct hit. This spell recharges very quickly."
	remarks = list("Despite common belief, missiles will not always find their target...", "What's 'force damage'?..", "I think I just bruised my hand...")
	
/obj/item/rune/spell/repulse
	spell = /obj/effect/proc_holder/spell/invoked/push_spell
	spellname = "repulse"
	icon_state = "book4_0"
	name = "tome of repulse"
	desc = "This tome contains detailed instructions on how to cast the spell 'Repulse', which allows a caster to send anyone near them flying in random directions, giving the caster an opportunity to escape or reposition."
	remarks = list("This might save my life...", "None shall lay their hands upon me...", "This might be useful near steep falls...")
	
/obj/item/rune/spell/darkvision
	spell = /obj/effect/proc_holder/spell/targeted/touch/darkvision
	spellname = "darkvision"
	icon_state = "book_0"
	name = "tome of darkvision"
	desc = "This tome contains detailed instructions on how to cast the spell 'Darkvision', which allows a caster to grant themselves or another person the ability to see in the dark for 10 minutes."
	remarks = list("I can see the universe...", "Dark-dwellers shall fear me...", "Torches are for the unwise...")
	
/obj/item/rune/spell/haste
	spell = /obj/effect/proc_holder/spell/invoked/haste
	spellname = "haste"
	icon_state = "book2_0"
	name = "tome of haste"
	desc = "This tome contains detailed instructions on how to cast the spell 'Haste', which allows a caster to grant themselves or another person magically increased speed for 60 seconds."
	remarks = list("Speed... more speed...", "None shall catch me...", "No side effects, you say...?")
	
	
/obj/item/rune/spell/message
	spell = /obj/effect/proc_holder/spell/self/message
	spellname = "message"
	icon_state = "basic_book_0"
	name = "tome of message"
	desc = "This tome contains detailed instructions on how to cast the spell 'Message', which allows a caster to magically speak directly - and optionally, anonymously - into another person's mind. The caster must know the target's name."
	remarks = list("Couriers be damned...", "How useful...", "Perhaps I can change my voice...?")
	
/obj/item/rune/spell/snare
	spell = /obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe
	spellname = "ensnare"
	icon_state = "book6_0"
	name = "tome of ensnare"
	desc = "This tome contains detailed instructions on how to cast the spell 'Ensnare', which allows a caster to magically halt anyone in a small radius in which they can see."
	remarks = list("Halt...!", "Cease your movement...", "Careful not to backfire...")
