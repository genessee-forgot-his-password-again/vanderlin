/obj/item/reagent_containers/syringe
	name = "infusion syringe"
	desc = ""
	icon = 'icons/obj/medical.dmi'
	item_state = "syringe"
	icon_state = "syringe"
	amount_per_transfer_from_this = 5
	grid_width = 64
	grid_height = 32
	possible_transfer_amounts = list()
	volume = 15
	var/mode = SYRINGE_DRAW
	var/busy = FALSE		// needed for delayed drawing of blood
	var/proj_piercing = 0 //does it pierce through thick clothes when shot with syringe gun
	reagent_flags = TRANSPARENT

/obj/item/reagent_containers/syringe/Initialize()
	. = ..()
	if(list_reagents) //syringe starts in inject mode if its already got something inside
		mode = SYRINGE_INJECT
		update_appearance()

/obj/item/reagent_containers/syringe/on_reagent_change(changetype)
	update_appearance()

/obj/item/reagent_containers/syringe/pickup(mob/user)
	..()
	update_appearance()

/obj/item/reagent_containers/syringe/dropped(mob/user)
	..()
	update_appearance()

/obj/item/reagent_containers/syringe/attack_self(mob/user)
	mode = !mode
	update_appearance()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/reagent_containers/syringe/attack_hand()
	. = ..()
	update_appearance()

/obj/item/reagent_containers/syringe/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/reagent_containers/syringe/attackby(obj/item/I, mob/user, params)
	return

/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user , proximity)
	. = ..()
	if(busy)
		return
	if(!proximity)
		return
	if(!target.reagents)
		return

	var/mob/living/L
	if(isliving(target))
		L = target
		if(!L.can_inject(user, 1))
			return

	// chance of monkey retaliation
	if(ismonkey(target) && prob(MONKEY_SYRINGE_RETALIATION_PROB))
		var/mob/living/carbon/monkey/M
		M = target
		M.retaliate(user)

	switch(mode)
		if(SYRINGE_DRAW)

			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("The syringe is full."))
				return

			if(L) //living mob
				var/drawn_amount = reagents.maximum_volume - reagents.total_volume
				if(target != user)
					target.visible_message(span_danger("[user] is trying to take a blood sample from [target]!"), \
									span_danger("[user] is trying to take a blood sample from you!"))
					busy = TRUE
					if(!do_after(user, 4 SECONDS, target, extra_checks=CALLBACK(L, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
						busy = FALSE
						return
					if(reagents.total_volume >= reagents.maximum_volume)
						return
				busy = FALSE
				if(L.transfer_blood_to(src, drawn_amount))
					user.visible_message(span_notice("[user] takes a blood sample from [L]."))
				else
					to_chat(user, span_warning("I am unable to draw any blood from [L]!"))

			else //if not mob
				if(!target.reagents.total_volume)
					to_chat(user, span_warning("[target] is empty!"))
					return

				if(!target.is_drawable(user))
					to_chat(user, span_warning("I cannot directly remove reagents from [target]!"))
					return

				var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?

				to_chat(user, span_notice("I fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
			if (reagents.total_volume >= reagents.maximum_volume)
				mode=!mode
				update_appearance()

		if(SYRINGE_INJECT)
			// Always log attemped injections for admins
			var/contained = reagents.log_list()
			log_combat(user, target, "attempted to inject", src, addition="which had [contained]")

			if(!reagents.total_volume)
				to_chat(user, span_warning("[src] is empty!"))
				return

			if(!L && !target.is_injectable(user)) //only checks on non-living mobs, due to how can_inject() handles
				to_chat(user, span_warning("I cannot directly fill [target]!"))
				return

			if(target.reagents.total_volume >= target.reagents.maximum_volume)
				to_chat(user, span_notice("[target] is full."))
				return

			if(L) //living mob
				if(!L.can_inject(user, TRUE))
					return
				if(L != user)
					L.visible_message(span_danger("[user] is trying to inject [L]!"), \
											span_danger("[user] is trying to inject you!"))
					if(!do_after(user, 4 SECONDS, L, extra_checks=CALLBACK(L, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
						return
					if(!reagents.total_volume)
						return
					if(L.reagents.total_volume >= L.reagents.maximum_volume)
						return
					L.visible_message(span_danger("[user] injects [L] with the syringe!"), \
									span_danger("[user] injects you with the syringe!"))

				if(L != user)
					log_combat(user, L, "injected", src, addition="which had [contained]")
				else
					L.log_message("injected themselves ([contained]) with [src.name]", LOG_ATTACK, color="orange")
			reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user, method = INJECT)
			to_chat(user, span_notice("I inject [amount_per_transfer_from_this] units of the solution. The syringe now contains [reagents.total_volume] units."))
			if (reagents.total_volume <= 0 && mode==SYRINGE_INJECT)
				mode = SYRINGE_DRAW
				update_appearance()


/obj/item/reagent_containers/syringe/update_icon()
	. = ..()
	var/rounded_vol
	if(reagents && reagents.total_volume)
		rounded_vol = CLAMP(round((reagents.total_volume / volume * 15),5), 1, 15)
	else
		rounded_vol = 0
	icon_state = "syringe-[rounded_vol]"
	item_state = "syringe_[rounded_vol]"

/obj/item/reagent_containers/syringe/update_overlays()
	. = ..()
	var/rounded_vol
	if(reagents && reagents.total_volume)
		rounded_vol = CLAMP(round((reagents.total_volume / volume * 15),5), 1, 15)
		var/image/filling_overlay = mutable_appearance('icons/obj/reagentfillings.dmi', "syringe[rounded_vol]")
		filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling_overlay
		var/datum/reagent/master = reagents.get_master_reagent()
		if(master?.glows)
			. += emissive_appearance('icons/obj/reagentfillings.dmi', "syringe[rounded_vol]")
	else
		rounded_vol = 0

	if(ismob(loc))
		var/mob/M = loc
		var/injoverlay
		switch(mode)
			if (SYRINGE_DRAW)
				injoverlay = "draw"
			if (SYRINGE_INJECT)
				injoverlay = "inject"
		. += injoverlay
		M.update_inv_hands()
