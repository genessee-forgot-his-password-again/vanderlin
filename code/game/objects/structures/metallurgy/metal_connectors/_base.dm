/obj/structure/channel_connector
	abstract_type = /obj/structure/channel_connector
	var/list/connected_dirs = list() // Directions this connector accepts channels from
	var/list/connected_channels = list() // Actual channel references keyed by direction

/obj/structure/channel_connector/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/channel_connector/LateInitialize()
	. = ..()
	connect_to_channels()

/obj/structure/channel_connector/Destroy()
	for(var/direction in connected_channels)
		var/obj/structure/metal_channel/channel = connected_channels[dir]
		if(channel)
			channel.unset_connection(get_dir(channel, src))
			channel.update_appearance(UPDATE_OVERLAYS)
	return ..()

/obj/structure/channel_connector/proc/connect_to_channels()
	for(var/direction in connected_dirs)
		var/turf/target_turf = get_step(src, text2num(direction))
		var/obj/structure/metal_channel/channel = locate(/obj/structure/metal_channel) in target_turf
		if(channel)
			connected_channels[direction] = channel
			channel.set_connection(get_dir(channel, src))
			channel.update_appearance(UPDATE_OVERLAYS)

/obj/structure/channel_connector/proc/on_channel_built_nearby()
	for(var/direction in connected_dirs)
		if(connected_channels[direction]) // Already have a connection in this direction
			continue

		var/turf/target_turf = get_step(src, text2num(direction))
		var/obj/structure/metal_channel/channel = locate(/obj/structure/metal_channel) in target_turf
		if(channel)
			connected_channels[direction] = channel
			channel.set_connection(get_dir(channel, src))
			channel.update_appearance(UPDATE_OVERLAYS)
			update_appearance(UPDATE_OVERLAYS)
