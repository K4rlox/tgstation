/datum/action/cooldown/spell/touch/nuclear_fist
	name = "Nuclear Fist"
	desc = "This spell channels raw manliness, allowing you punch your enemies across the galaxy, causing them to detonate violently if hitting any other living being midflight."
	school = SCHOOL_EVOCATION
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 10 SECONDS
	any_casting = TRUE
	hand_path = /obj/item/melee/touch_attack/nuclearfist
	sound = 'sound/effects/magic/nuclear_fist.ogg'
	invocation = "I CAST FIST!"

/obj/item/melee/touch_attack/nuclearfist
	name = "\improper PURE MANLINESS"
	desc = "SHOW THEM RAW POWER"

/datum/action/cooldown/spell/touch/nuclearfist/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	caster.visible_message(
		span_warning("The feedback blows [caster]'s arm off!"),
		span_userdanger("The spell bounces from [victim]'s skin back into your arm!"),
	)
	// Off goes the arm we were casting with!
	var/obj/item/bodypart/to_dismember = caster.get_holding_bodypart_of_item(hand)
	to_dismember?.dismember()

/obj/item/melee/touch_attack/nuclearfist/afterattack(atom/movable/target, mob/living/carbon/user, proximity)
	if(!proximity || target == user || !ismob(target) || !iscarbon(user) || user.resting || user.handcuffed) //exploding after touching yourself would be bad
		return
	var/mob/M = target
	do_sparks(4, FALSE, M.loc)
	for(var/mob/living/L in view(src, 7))
		if(L != user)
			L.flash_act(affect_silicon = FALSE)
	var/obj/projectile/magic/nuclear/P = new(get_turf(src))
	P.victim = target
	target.forceMove(P)
	return ..()

/datum/action/cooldown/spell/touch/nuclearfist/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	caster.visible_message(
		span_warning("The feedback blows [caster]'s arm off!"),
		span_userdanger("The spell bounces from [victim]'s skin back into your arm!"),
	)
	// Off goes the arm we were casting with!
	var/obj/item/bodypart/to_dismember = caster.get_holding_bodypart_of_item(hand)
	to_dismember?.dismember()
