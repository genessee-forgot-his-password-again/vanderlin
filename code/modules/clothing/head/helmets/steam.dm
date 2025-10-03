/obj/item/clothing/head/helmet/heavy/steam
	name = "steamknight helmet"
	desc = "Part of the the steamknight armor. Requires knowledge in engineering to operate."
	icon_state = "steamknight_helm"
	icon = 'icons/roguetown/clothing/steamknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	anvilrepair = /datum/skill/craft/engineering
	block2add = null // no fov block, was trying to make it so theres a fov block if its unpowered but it didn't really work out sadly, was too buggy
	item_weight = 9 * BRONZE_MULTIPLIER
	smeltresult = /obj/item/ingot/bronze

/obj/item/clothing/head/helmet/heavy/steam/dropped(mob/living/carbon/user)
	// Locate the boiler in the back slots
	var/obj/item/clothing/cloak/boiler/B = locate(/obj/item/clothing/cloak/boiler) in list(user.backr, user.backl)
	if(B)
		B.power_off(user)

	. = ..()
