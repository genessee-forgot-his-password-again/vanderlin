GLOBAL_LIST_INIT(bandit_quotes, world.file2list("strings/rt/banditlines.txt"))
GLOBAL_LIST_INIT(bandit_aggro, world.file2list("strings/rt/banditaggrolines.txt"))

/mob/living/carbon/human/species/human/northern/npc/bandit
	ai_controller = /datum/ai_controller/human_npc
	faction = list(FACTION_MATTHIOS)
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	possible_rmb_intents = list()

	wander = FALSE

/mob/living/carbon/human/species/human/northern/npc/bandit/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	AddComponent(/datum/component/combat_noise, list("aggro" = 2))
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

// Bandit Thug - Blunt lvl1

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_one/after_creation()
	..()
	job = "Brigand Thug"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blunt_one)

/datum/outfit/job/npc/bandit/blunt_one/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 8
	H.base_speed = 6
	H.base_constitution = 8
	H.base_endurance = 5
	H.base_intelligence = 3

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	belt = /obj/item/storage/belt/leather/rope
	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	if(prob(25))
		armor = /obj/item/clothing/armor/gambeson/light
	pants = /obj/item/clothing/pants/tights/colored/black
	shoes = /obj/item/clothing/shoes/simpleshoes
	mask = /obj/item/clothing/face/shepherd/clothmask
	if(prob(25))
		head = /obj/item/clothing/head/armingcap
	if(prob(50))
		var/obj/item/weapon/mace/cudgel/P = new()
		H.put_in_hands(P, forced = TRUE)
	else
		var/obj/item/weapon/mace/bludgeon/copper/P = new()
		H.put_in_hands(P, forced = TRUE)

// Bandit Henchman - Blunt lvl2

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_two/after_creation()
	..()
	job = "Brigand Henchman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blunt_two)

/datum/outfit/job/npc/bandit/blunt_two/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 10
	H.base_speed = 8
	H.base_constitution = 10
	H.base_endurance = 8
	H.base_intelligence = 4

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	gloves = /obj/item/clothing/gloves/leather
	pants = /obj/item/clothing/pants/tights/colored/black
	shirt = /obj/item/clothing/shirt/shortshirt/colored/uncolored
	if(prob(50))
		armor = /obj/item/clothing/armor/gambeson
	else
		armor = /obj/item/clothing/armor/leather
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	if(prob(75))
		head = /obj/item/clothing/head/helmet/leather
	else
		head = /obj/item/clothing/head/helmet/leather/conical
	mask = /obj/item/clothing/face/shepherd/clothmask
	var/obj/item/weapon/mace/P = new()
	var/obj/item/weapon/shield/wood/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Marauder - Blunt lvl3

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_three/after_creation()
	..()
	job = "Brigand Marauder"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blunt_three)

/datum/outfit/job/npc/bandit/blunt_three/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 11
	H.base_speed = 8
	H.base_constitution = 11
	H.base_endurance = 10
	H.base_intelligence = 4

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	gloves = /obj/item/clothing/gloves/chain/iron
	pants = /obj/item/clothing/pants/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/armor/chainmail/iron
	else
		armor = /obj/item/clothing/armor/chainmail/hauberk/iron
	if(prob(50))
		shoes = /obj/item/clothing/shoes/boots/leather
	else
		shoes = /obj/item/clothing/shoes/boots/furlinedboots
	belt = /obj/item/storage/belt/leather
	if(prob(50))
		head = /obj/item/clothing/head/helmet/skullcap
	else
		head = /obj/item/clothing/head/helmet/kettle/iron
	mask = /obj/item/clothing/face/shepherd/clothmask
	neck = /obj/item/clothing/neck/coif/cloth
	var/obj/item/weapon/mace/steel/P = new()
	var/obj/item/weapon/shield/heater/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Pounder - Blunt lvl4

/mob/living/carbon/human/species/human/northern/npc/bandit/blunt_four/after_creation()
	..()
	job = "Brigand Pounder"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blunt_four)

/datum/outfit/job/npc/bandit/blunt_four/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 12
	H.base_speed = 9
	H.base_constitution = 12
	H.base_endurance = 11
	H.base_intelligence = 5

	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	if(prob(75))
		shirt = /obj/item/clothing/armor/chainmail
	else
		shirt = /obj/item/clothing/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/chain
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/armor/cuirass/iron
	shoes = /obj/item/clothing/shoes/boots/armor/light
	belt = /obj/item/storage/belt/leather/steel
	if(prob(75))
		head = /obj/item/clothing/head/helmet/visored/sallet/iron
	else
		head = /obj/item/clothing/head/helmet/visored/knight/iron
	if(prob(50))
		neck = /obj/item/clothing/neck/chaincoif/iron
	else
		neck = /obj/item/clothing/neck/gorget
	var/obj/item/weapon/mace/steel/morningstar/P = new()
	var/obj/item/weapon/shield/tower/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Rebel - Polearm lvl1

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_one/after_creation()
	..()
	job = "Brigand Rebel"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/polearm_one)

/datum/outfit/job/npc/bandit/polearm_one/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 8
	H.base_speed = 6
	H.base_constitution = 8
	H.base_endurance = 5
	H.base_intelligence = 3

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	belt = /obj/item/storage/belt/leather/rope
	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	if(prob(25))
		armor = /obj/item/clothing/armor/gambeson/light
	pants = /obj/item/clothing/pants/tights/colored/black
	shoes = /obj/item/clothing/shoes/simpleshoes
	mask = /obj/item/clothing/face/shepherd/clothmask
	if(prob(25))
		head = /obj/item/clothing/head/armingcap
	if(prob(50))
		var/obj/item/weapon/polearm/spear/stone/copper/P = new()
		H.put_in_hands(P, forced = TRUE)
	else
		var/obj/item/weapon/pitchfork/P = new()
		H.put_in_hands(P, forced = TRUE)

// Bandit Turncoat - Polearm lvl2

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_two/after_creation()
	..()
	job = "Brigand Turncoat"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/polearm_two)

/datum/outfit/job/npc/bandit/polearm_two/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 10
	H.base_speed = 8
	H.base_constitution = 10
	H.base_endurance = 8
	H.base_intelligence = 4

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	gloves = /obj/item/clothing/gloves/leather
	pants = /obj/item/clothing/pants/tights/colored/black
	shirt = /obj/item/clothing/shirt/shortshirt/colored/uncolored
	if(prob(50))
		armor = /obj/item/clothing/armor/gambeson
	else
		armor = /obj/item/clothing/armor/leather
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	if(prob(75))
		head = /obj/item/clothing/head/helmet/leather
	else
		head = /obj/item/clothing/head/helmet/leather/conical
	mask = /obj/item/clothing/face/shepherd/clothmask
	var/obj/item/weapon/polearm/spear/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Renegade - Polearm lvl3

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_three/after_creation()
	..()
	job = "Brigand Marauder"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/polearm_three)

/datum/outfit/job/npc/bandit/polearm_three/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 11
	H.base_speed = 8
	H.base_constitution = 11
	H.base_endurance = 10
	H.base_intelligence = 4

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	gloves = /obj/item/clothing/gloves/chain/iron
	pants = /obj/item/clothing/pants/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/armor/chainmail/iron
	else
		armor = /obj/item/clothing/armor/chainmail/hauberk/iron
	if(prob(50))
		shoes = /obj/item/clothing/shoes/boots/leather
	else
		shoes = /obj/item/clothing/shoes/boots/furlinedboots
	belt = /obj/item/storage/belt/leather
	if(prob(50))
		head = /obj/item/clothing/head/helmet/skullcap
	else
		head = /obj/item/clothing/head/helmet/kettle/iron
	mask = /obj/item/clothing/face/shepherd/clothmask
	neck = /obj/item/clothing/neck/coif/cloth
	var/obj/item/weapon/polearm/spear/billhook/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Reachfighter - Polearm lvl4

/mob/living/carbon/human/species/human/northern/npc/bandit/polearm_four/after_creation()
	..()
	job = "Brigand Reachfighter"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/polearm_four)

/datum/outfit/job/npc/bandit/polearm_four/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 12
	H.base_speed = 9
	H.base_constitution = 12
	H.base_endurance = 11
	H.base_intelligence = 5

	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	if(prob(75))
		shirt = /obj/item/clothing/armor/chainmail
	else
		shirt = /obj/item/clothing/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/chain
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/armor/cuirass/iron
	shoes = /obj/item/clothing/shoes/boots/armor/light
	belt = /obj/item/storage/belt/leather/steel
	if(prob(75))
		head = /obj/item/clothing/head/helmet/visored/sallet/iron
	else
		head = /obj/item/clothing/head/helmet/visored/knight/iron
	if(prob(50))
		neck = /obj/item/clothing/neck/chaincoif/iron
	else
		neck = /obj/item/clothing/neck/gorget
	var/obj/item/weapon/polearm/halberd/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Goon - Blade lvl1

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_one/after_creation()
	..()
	job = "Brigand Goon"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blade_one)

/datum/outfit/job/npc/bandit/blade_one/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 8
	H.base_speed = 6
	H.base_constitution = 8
	H.base_endurance = 5
	H.base_intelligence = 3

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	belt = /obj/item/storage/belt/leather/rope
	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	if(prob(25))
		armor = /obj/item/clothing/armor/gambeson/light
	pants = /obj/item/clothing/pants/tights/colored/black
	shoes = /obj/item/clothing/shoes/simpleshoes
	mask = /obj/item/clothing/face/shepherd/clothmask
	if(prob(25))
		head = /obj/item/clothing/head/armingcap
	var/obj/item/weapon/sword/coppermesser/P = new()
	H.put_in_hands(P, forced = TRUE)

// Bandit Enforcer - Blade lvl2

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_two/after_creation()
	..()
	job = "Brigand Enforcer"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blade_two)

/datum/outfit/job/npc/bandit/blade_two/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 10
	H.base_speed = 8
	H.base_constitution = 10
	H.base_endurance = 8
	H.base_intelligence = 4

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)

	gloves = /obj/item/clothing/gloves/leather
	pants = /obj/item/clothing/pants/tights/colored/black
	shirt = /obj/item/clothing/shirt/shortshirt/colored/uncolored
	if(prob(50))
		armor = /obj/item/clothing/armor/gambeson
	else
		armor = /obj/item/clothing/armor/leather
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	if(prob(75))
		head = /obj/item/clothing/head/helmet/leather
	else
		head = /obj/item/clothing/head/helmet/leather/conical
	mask = /obj/item/clothing/face/shepherd/clothmask
	var/obj/item/weapon/sword/iron/P = new()
	var/obj/item/weapon/shield/wood/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Cutthroat - Blade lvl3

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_three/after_creation()
	..()
	job = "Brigand Cutthroat"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blade_three)

/datum/outfit/job/npc/bandit/blade_three/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 11
	H.base_speed = 8
	H.base_constitution = 11
	H.base_endurance = 10
	H.base_intelligence = 4

	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	gloves = /obj/item/clothing/gloves/chain/iron
	pants = /obj/item/clothing/pants/trou/leather
	if(prob(75))
		armor = /obj/item/clothing/armor/chainmail/iron
	else
		armor = /obj/item/clothing/armor/chainmail/hauberk/iron
	if(prob(50))
		shoes = /obj/item/clothing/shoes/boots/leather
	else
		shoes = /obj/item/clothing/shoes/boots/furlinedboots
	belt = /obj/item/storage/belt/leather
	if(prob(50))
		head = /obj/item/clothing/head/helmet/skullcap
	else
		head = /obj/item/clothing/head/helmet/kettle/iron
	mask = /obj/item/clothing/face/shepherd/clothmask
	neck = /obj/item/clothing/neck/coif/cloth
	var/obj/item/weapon/sword/arming/P = new()
	var/obj/item/weapon/shield/heater/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)

// Bandit Bladewarden - Blade lvl4

/mob/living/carbon/human/species/human/northern/npc/bandit/blade_four/after_creation()
	..()
	job = "Brigand Bladewarden"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/npc/bandit/blade_four)

/datum/outfit/job/npc/bandit/blade_four/pre_equip(mob/living/carbon/human/H)
	..()

	H.base_strength = 12
	H.base_speed = 9
	H.base_constitution = 12
	H.base_endurance = 11
	H.base_intelligence = 5

	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	if(prob(75))
		shirt = /obj/item/clothing/armor/chainmail
	else
		shirt = /obj/item/clothing/armor/chainmail/hauberk
	gloves = /obj/item/clothing/gloves/chain
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/armor/cuirass/iron
	shoes = /obj/item/clothing/shoes/boots/armor/light
	belt = /obj/item/storage/belt/leather/steel
	if(prob(75))
		head = /obj/item/clothing/head/helmet/visored/sallet/iron
	else
		head = /obj/item/clothing/head/helmet/visored/knight/iron
	if(prob(50))
		neck = /obj/item/clothing/neck/chaincoif/iron
	else
		neck = /obj/item/clothing/neck/gorget
	var/obj/item/weapon/sword/decorated/P = new()
	var/obj/item/weapon/shield/tower/POH = new()
	H.put_in_hands(P, forced = TRUE)
	H.put_in_hands(POH, forced = TRUE)
