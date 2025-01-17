GLOBAL_LIST_INIT(bandit_quotes, world.file2list("strings/rt/banditlines.txt"))
GLOBAL_LIST_INIT(bandit_aggro, world.file2list("strings/rt/banditaggrolines.txt"))

/mob/living/carbon/human/species/human/northern/npc/bandit
	aggressive=1
	mode = AI_IDLE
	ambushable = FALSE
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
	var/obj/item/rogueweapon/mace/cudgel/P = new()
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

	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	head = /obj/item/clothing/head/roguetown/armingcap
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	var/obj/item/rogueweapon/mace/P = new()
	var/obj/item/rogueweapon/shield/wood/POH = new()
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
	var/obj/item/rogueweapon/polearm/spear/stone/P = new()
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

	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	head = /obj/item/clothing/head/roguetown/armingcap
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	var/obj/item/rogueweapon/polearm/spear/P = new()
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

	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	head = /obj/item/clothing/head/roguetown/armingcap
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	var/obj/item/rogueweapon/sword/iron/P = new()
	var/obj/item/rogueweapon/shield/wood/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)
