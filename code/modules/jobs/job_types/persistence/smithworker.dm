/datum/job/persistence/smithworker
	title = "Smithworker"
	tutorial = "You are a blacksmith, somewhat skilled in the creation of arms and armor in a forge. Ensure the town isn't defenseless."
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	outfit = /datum/outfit/blacksmith_p
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/outfit/blacksmith_p/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		H.cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'
	//general skills
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)

	//job specific skills
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE) // so they can gather materials poorly w/o any miners

	//stats
	H.change_stat(STATKEY_STR, pick(0,1))
	H.change_stat(STATKEY_CON, pick(0,1))
	H.change_stat(STATKEY_END, pick(0,1))

	//traits

	//gear
	head = pick(/obj/item/clothing/head/hatfur, /obj/item/clothing/head/hatblu, /obj/item/clothing/head/brimmed)
	armor = pick(/obj/item/clothing/armor/leather/vest, /obj/item/clothing/armor/gambeson/light/striped)
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	pants = pick(/obj/item/clothing/pants/trou, /obj/item/clothing/pants/tights/colored/random)
	shoes = /obj/item/clothing/shoes/boots/leather

	belt = pick(/obj/item/storage/belt/leather, /obj/item/storage/belt/leather/rope)
	cloak = /obj/item/clothing/cloak/apron/brown

	beltl = /obj/item/weapon/hammer/wood
	beltr = /obj/item/weapon/tongs/stone
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/recipe_book/blacksmithing = 1, /obj/item/weapon/knife/villager = 1)