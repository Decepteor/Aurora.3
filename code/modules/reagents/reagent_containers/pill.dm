////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/pill
	name = "pill"
	desc = "a pill."
	icon = 'icons/obj/chemical.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/stacks/lefthand_medical.dmi',
		slot_r_hand_str = 'icons/mob/items/stacks/righthand_medical.dmi',
		)
	icon_state = null
	item_state = "pill"
	possible_transfer_amounts = null
	w_class = 1
	slot_flags = SLOT_EARS
	volume = 60
	drop_sound = 'sound/items/drop/food.ogg'
	pickup_sound = 'sound/items/pickup/food.ogg'

	New()
		..()
		if(!icon_state)
			icon_state = "pill[rand(1, 20)]"

	attack(mob/M as mob, mob/user as mob, def_zone)
		//TODO: replace with standard_feed_mob() call.

		if(M == user)
			if(!M.can_eat(src))
				return

			M.visible_message("<b>[M]</b> swallows a pill.", SPAN_NOTICE("You swallow \the [src]."), null, 2)
			if(reagents.total_volume)
				reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
			qdel(src)
			return 1

		else if(istype(M, /mob/living/carbon/human))
			if(!M.can_force_feed(user, src))
				return

			user.visible_message(SPAN_WARNING("[user] attempts to force [M] to swallow \the [src]!"))

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			if(!do_mob(user, M))
				return

			user.visible_message(SPAN_WARNING("[user] forces [M] to swallow \the [src]."))

			var/contained = reagentlist()
			M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been fed [name] by [key_name(user)] Reagents: [contained]</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [name] to [key_name(M)] Reagents: [contained]</font>")
			msg_admin_attack("[key_name_admin(user)] fed [key_name_admin(M)] with [name] Reagents: [contained] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)",ckey=key_name(user),ckey_target=key_name(M))

			if(reagents.total_volume)
				reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
			qdel(src)

			return 1

		return 0

	afterattack(obj/target, mob/user, proximity)

		if(proximity && target.is_open_container() && target.reagents)
			if(!target.reagents.total_volume)
				to_chat(user, SPAN_NOTICE("You can't dissolve \the [src] in an empty [target]."))
				return
			to_chat(user, SPAN_NOTICE("You dissolve \the [src] in [target]."))

			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Spiked \a [target] with a pill. Reagents: [reagentlist()]</font>")
			msg_admin_attack("[user.name] ([user.ckey]) spiked \a [target] with a pill. Reagents: [reagentlist()] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)",ckey=key_name(user),ckey_target=key_name(target))

			reagents.trans_to(target, reagents.total_volume)
			for(var/mob/O in viewers(2, user))
				O.show_message(SPAN_WARNING("[user] puts something in \the [target]."), 1)

			qdel(src)
			return

		. = ..()

////////////////////////////////////////////////////////////////////////////////
/// Pills. END
////////////////////////////////////////////////////////////////////////////////

//Pills
/obj/item/reagent_containers/pill/antitox
	name = "anti-toxins pill"
	desc = "Neutralizes many common toxins."
	icon_state = "pill17"
	reagents_to_add = list(/datum/reagent/dylovene = 25)

/obj/item/reagent_containers/pill/tox
	name = "toxins pill"
	desc = "Highly toxic."
	icon_state = "pill5"
	reagents_to_add = list(/datum/reagent/toxin = 50)

/obj/item/reagent_containers/pill/cyanide
	name = "cyanide pill"
	desc = "Don't swallow this."
	icon_state = "pill5"
	reagents_to_add = list(/datum/reagent/toxin/cyanide = 50)

/obj/item/reagent_containers/pill/adminordrazine
	name = "adminordrazine pill"
	desc = "It's magic. We don't have to explain it."
	icon_state = "pill16"
	reagents_to_add = list(/datum/reagent/adminordrazine = 50)

/obj/item/reagent_containers/pill/stox
	name = "sleeping pill"
	desc = "Commonly used to treat insomnia."
	icon_state = "pill8"
	reagents_to_add = list(/datum/reagent/soporific = 15)

/obj/item/reagent_containers/pill/kelotane
	name = "kelotane pill"
	desc = "Used to treat burns."
	icon_state = "pill11"
	reagents_to_add = list(/datum/reagent/kelotane = 15)

/obj/item/reagent_containers/pill/perconol
	name = "perconol pill"
	desc = "A painkiller for the ages. Chewables!"
	icon_state = "pill8"
	reagents_to_add = list(/datum/reagent/perconol = 15)


/obj/item/reagent_containers/pill/mortaphenyl
	name = "mortaphenyl pill"
	desc = "A mortaphenyl pill, it's a potent painkiller."
	icon_state = "pill8"
	reagents_to_add = list(/datum/reagent/mortaphenyl = 15)

/obj/item/reagent_containers/pill/corophenidate
	name = "corophenidate pill"
	desc = "Improves the ability to concentrate."
	icon_state = "pill8"
	reagents_to_add = list(/datum/reagent/mental/corophenidate = 15)
  
/obj/item/reagent_containers/pill/minaphobin
	name = "minaphobin pill"
	desc = "Mild anti-depressant."
	icon_state = "pill8"
	reagents_to_add = list(/datum/reagent/mental/minaphobin = 15)

/obj/item/reagent_containers/pill/inaprovaline
	name = "inaprovaline pill"
	desc = "Used to stabilize patients."
	icon_state = "pill20"
	reagents_to_add = list(/datum/reagent/inaprovaline = 30)

/obj/item/reagent_containers/pill/dexalin
	name = "dexalin pill"
	desc = "Used to treat oxygen deprivation."
	icon_state = "pill16"
	reagents_to_add = list(/datum/reagent/dexalin = 15)

/obj/item/reagent_containers/pill/dexalin_plus
	name = "dexalin Plus pill"
	desc = "Used to treat extreme oxygen deprivation."
	icon_state = "pill8"
	reagents_to_add = list(/datum/reagent/dexalin/plus = 15)

/obj/item/reagent_containers/pill/dermaline
	name = "dermaline pill"
	desc = "Used to treat burn wounds."
	icon_state = "pill12"
	reagents_to_add = list(/datum/reagent/dermaline = 15)

/obj/item/reagent_containers/pill/dylovene
	name = "dylovene pill"
	desc = "A broad-spectrum anti-toxin."
	icon_state = "pill13"
	reagents_to_add = list(/datum/reagent/dylovene = 15)

/obj/item/reagent_containers/pill/bicaridine
	name = "bicaridine pill"
	desc = "Used to treat physical injuries."
	icon_state = "pill18"
	reagents_to_add = list(/datum/reagent/bicaridine = 20)

/obj/item/reagent_containers/pill/happy
	name = "happy pill"
	desc = "Happy happy joy joy!"
	icon_state = "pill18"
	reagents_to_add = list(/datum/reagent/space_drugs = 15, /datum/reagent/sugar = 15)

/obj/item/reagent_containers/pill/zoom
	name = "zoom pill"
	desc = "Zoooom!"
	icon_state = "pill18"
	reagents_to_add = list(/datum/reagent/impedrezene = 10, /datum/reagent/synaptizine = 5, /datum/reagent/hyperzine = 5)

/obj/item/reagent_containers/pill/thetamycin
	name = "thetamycin pill"
	desc = "Contains theta-lactam antibiotics."
	icon_state = "pill19"
	reagents_to_add = list(/datum/reagent/thetamycin = 15)

/obj/item/reagent_containers/pill/bio_vitamin
	name = "vitamin pill"
	desc = "Contains a meal's worth of nutrients."
	icon_state = "pill11"
	reagents_to_add = list(/datum/reagent/nutriment = 20)

/obj/item/reagent_containers/pill/bio_vitamin/Initialize()
	reagents_to_add += list(pick(/datum/reagent/drink/banana, /datum/reagent/drink/berryjuice, /datum/reagent/drink/grapejuice, /datum/reagent/drink/lemonjuice, /datum/reagent/drink/limejuice, /datum/reagent/drink/orangejuice, /datum/reagent/drink/watermelonjuice) = 1)
	. = ..()

/obj/item/reagent_containers/pill/rmt
	name = "regenerative-muscular tissue supplement pill"
	desc = "Commonly abbreviated to RMT, it contains chemicals rampantly used by those seeking to remedy the effects of prolonged zero-gravity adaptations."
	icon_state = "pill19"
	reagents_to_add = list(/datum/reagent/rmt = 15)

/obj/item/reagent_containers/pill/cetahydramine
	name = "cetahydramine pill"
	desc = "Contains modern Cetahydramine, often compared to ancient Benadryl. Helps with sneezing, can cause drowsiness."
	icon_state = "pill19"
	reagents_to_add = list(/datum/reagent/cetahydramine = 5)
