GLOBAL_LIST_INIT(bum_quotes, world.file2list("strings/rt/bumlines.txt"))
GLOBAL_LIST_INIT(bum_aggro, world.file2list("strings/rt/bumaggrolines.txt"))

/mob/living/carbon/human/species/human/northern/bum
	aggressive=0
	mode = AI_IDLE
	faction = list("bums", "station")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()

	wander = FALSE

/mob/living/carbon/human/species/human/northern/bum/ambush
	aggressive=1

	wander = TRUE

/mob/living/carbon/human/species/human/northern/bum/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(target != newtarg)
			say(pick(GLOB.bum_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/bum/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/bum/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/human/northern/bum/after_creation()
	..()
	job = "Beggar"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/vagrant)

/mob/living/carbon/human/species/human/northern/bum/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))
	if(prob(3))
		say(pick(GLOB.bum_quotes))
	if(prob(3))
		emote(pick("laugh","burp","yawn","grumble","mumble","blink_r","clap"))

GLOBAL_LIST_INIT(bandit_quotes, world.file2list("strings/rt/banditlines.txt"))
GLOBAL_LIST_INIT(bandit_aggro, world.file2list("strings/rt/banditaggrolines.txt"))

/mob/living/carbon/human/species/human/northern/npc/bandit
	aggressive=1
	mode = AI_IDLE
	ambushable = FALSE
	faction = list("bandits", "station")
	flee_in_pain = TRUE
	possible_rmb_intents = list()
	wander = TRUE

/mob/living/carbon/human/species/human/northern/npc/bandit/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(target != newtarg)
			say(pick(GLOB.bandit_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/npc/bandit/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/human/northern/npc/bandit/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))
	if(prob(3))
		say(pick(GLOB.bandit_quotes))
	if(prob(3))
		emote(pick("laugh","burp","yawn","grumble","mumble","blink_r","clap"))

// Bandit Thug - Blunt lvl1

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_one/after_creation()
	..()
	job = "Brigand Thug"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blunt_one)

/datum/outfit/job/roguetown/npc/bandit/blunt_one/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 8
	H.TOTALSPD = 6
	H.TOTALCON = 8
	H.TOTALEND = 5
	H.TOTALINT = 3

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	belt = /obj/item/storage/belt/rogue/leather/rope
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	if(prob(25))
		head = /obj/item/clothing/head/roguetown/armingcap
	if(prob(50))
		var/obj/item/rogueweapon/mace/cudgel/P = new()
		H.put_in_hands(P, forced = TRUE)
	else
		var/obj/item/rogueweapon/mace/copperbludgeon/P = new()
		H.put_in_hands(P, forced = TRUE)

// Bandit Henchman - Blunt lvl2

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_two/after_creation()
	..()
	job = "Brigand Henchman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blunt_two)

/datum/outfit/job/roguetown/npc/bandit/blunt_two/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 10
	H.TOTALSPD = 8
	H.TOTALCON = 10
	H.TOTALEND = 8
	H.TOTALINT = 4

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(75))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	else
		head = /obj/item/clothing/head/roguetown/helmet/leather/conical
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	var/obj/item/rogueweapon/mace/P = new()
	var/obj/item/rogueweapon/shield/wood/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Marauder - Blunt lvl3

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_three/after_creation()
	..()
	job = "Brigand Marauder"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blunt_three)

/datum/outfit/job/roguetown/npc/bandit/blunt_three/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 11
	H.TOTALSPD = 8
	H.TOTALCON = 11
	H.TOTALEND = 10
	H.TOTALINT = 4

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	else
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	else
		shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	else
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	neck = /obj/item/clothing/neck/roguetown/coif/cloth
	var/obj/item/rogueweapon/mace/steel/P = new()
	var/obj/item/rogueweapon/shield/heater/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Pounder - Blunt lvl4

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_four/after_creation()
	..()
	job = "Brigand Pounder"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blunt_four)

/datum/outfit/job/roguetown/npc/bandit/blunt_four/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 12
	H.TOTALSPD = 9
	H.TOTALCON = 12
	H.TOTALEND = 11
	H.TOTALINT = 5

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	else
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust
	else
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
	belt = /obj/item/storage/belt/rogue/leather/steel
	if(prob(75))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/rust
	else
		head = /obj/item/clothing/head/roguetown/helmet/sallet
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	else
		neck = /obj/item/clothing/neck/roguetown/gorget
	var/obj/item/rogueweapon/mace/steel/morningstar/P = new()
	var/obj/item/rogueweapon/shield/tower/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Rebel - Polearm lvl1

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_one/after_creation()
	..()
	job = "Brigand Rebel"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/polearm_one)

/datum/outfit/job/roguetown/npc/bandit/polearm_one/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 8
	H.TOTALSPD = 6
	H.TOTALCON = 8
	H.TOTALEND = 5
	H.TOTALINT = 3

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	belt = /obj/item/storage/belt/rogue/leather/rope
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	if(prob(25))
		head = /obj/item/clothing/head/roguetown/armingcap
	if(prob(50))
		var/obj/item/rogueweapon/polearm/spear/stone/copper/P = new()
		H.put_in_hands(P, forced = TRUE)
	else
		var/obj/item/rogueweapon/pitchfork/copper/P = new()
		H.put_in_hands(P, forced = TRUE)

// Bandit Turncoat - Polearm lvl2

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_two/after_creation()
	..()
	job = "Brigand Turncoat"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/polearm_two)

/datum/outfit/job/roguetown/npc/bandit/polearm_two/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 10
	H.TOTALSPD = 8
	H.TOTALCON = 10
	H.TOTALEND = 8
	H.TOTALINT = 4

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(75))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	else
		head = /obj/item/clothing/head/roguetown/helmet/leather/conical
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	var/obj/item/rogueweapon/polearm/spear/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Renegade - Polearm lvl3

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_three/after_creation()
	..()
	job = "Brigand Marauder"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/polearm_three)

/datum/outfit/job/roguetown/npc/bandit/polearm_three/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 11
	H.TOTALSPD = 8
	H.TOTALCON = 11
	H.TOTALEND = 10
	H.TOTALINT = 4

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	else
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	else
		shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	else
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	neck = /obj/item/clothing/neck/roguetown/coif/cloth
	var/obj/item/rogueweapon/polearm/spear/billhook/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Reachfighter - Polearm lvl4

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_four/after_creation()
	..()
	job = "Brigand Reachfighter"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/polearm_four)

/datum/outfit/job/roguetown/npc/bandit/polearm_four/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 12
	H.TOTALSPD = 9
	H.TOTALCON = 12
	H.TOTALEND = 11
	H.TOTALINT = 5

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	else
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust
	else
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
	belt = /obj/item/storage/belt/rogue/leather/steel
	if(prob(75))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/rust
	else
		head = /obj/item/clothing/head/roguetown/helmet/sallet
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	else
		neck = /obj/item/clothing/neck/roguetown/gorget
	var/obj/item/rogueweapon/polearm/halberd/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Goon - Blade lvl1

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_one/after_creation()
	..()
	job = "Brigand Goon"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blade_one)

/datum/outfit/job/roguetown/npc/bandit/blade_one/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 8
	H.TOTALSPD = 6
	H.TOTALCON = 8
	H.TOTALEND = 5
	H.TOTALINT = 3

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	belt = /obj/item/storage/belt/rogue/leather/rope
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	if(prob(25))
		head = /obj/item/clothing/head/roguetown/armingcap
	var/obj/item/rogueweapon/sword/short/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Enforcer - Blade lvl2

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_two/after_creation()
	..()
	job = "Brigand Enforcer"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blade_two)

/datum/outfit/job/roguetown/npc/bandit/blade_two/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 10
	H.TOTALSPD = 8
	H.TOTALCON = 10
	H.TOTALEND = 8
	H.TOTALINT = 4

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(75))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	else
		head = /obj/item/clothing/head/roguetown/helmet/leather/conical
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	var/obj/item/rogueweapon/sword/iron/P = new()
	var/obj/item/rogueweapon/shield/wood/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Cutthroat - Blade lvl3

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_three/after_creation()
	..()
	job = "Brigand Cutthroat"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blade_three)

/datum/outfit/job/roguetown/npc/bandit/blade_three/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 11
	H.TOTALSPD = 8
	H.TOTALCON = 11
	H.TOTALEND = 10
	H.TOTALINT = 4

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	gloves = /obj/item/clothing/gloves/roguetown/chain/iron
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	else
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	else
		shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	else
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	neck = /obj/item/clothing/neck/roguetown/coif/cloth
	var/obj/item/rogueweapon/sword/sabre/P = new()
	var/obj/item/rogueweapon/shield/heater/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Bladewarden - Blade lvl4

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_four/after_creation()
	..()
	job = "Brigand Bladewarden"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/bandit/blade_four)

/datum/outfit/job/roguetown/npc/bandit/blade_four/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = 12
	H.TOTALSPD = 9
	H.TOTALCON = 12
	H.TOTALEND = 11
	H.TOTALINT = 5

	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	else
		shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/roguetown/chain
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust
	else
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
	belt = /obj/item/storage/belt/rogue/leather/steel
	if(prob(75))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/rust
	else
		head = /obj/item/clothing/head/roguetown/helmet/sallet
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	else
		neck = /obj/item/clothing/neck/roguetown/gorget
	var/obj/item/rogueweapon/sword/sabre/cutlass/P = new()
	var/obj/item/rogueweapon/shield/tower/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)
