--[[
CDDL HEADER START

This file and its contents are supplied under the terms of the
Common Development and Distribution License ("CDDL"), version 1.0.
You may only use this file in accordance with the terms of version
1.0 of the CDDL.

A full copy of the text of the CDDL should have accompanied this
source.  A copy of the CDDL is also available via the Internet at
http://www.illumos.org/license/CDDL.

CDDL HEADER END

Copyright 2016 Saso Kiselkov. All rights reserved.

RAAS advisories:

	1) Altimeter setting during approach
	    Message: "ALTIMETER SETTING"
	    Frequency: once
	    Conditions:
		*) GPS, corrected baro altitude and static air temp inputs
		   are functional
		*) Aircraft has descended below the Transition Altitude (from
		   database) for more than 30 seconds or Height Above Field is
		   less than 1500 feet.
		*) Aircraft is within 20nm of the EGPWS selected destination
		   airport and airport is not indicated as QFE (in database),
		   altimeter setting is not QFE and QFE program pin is not
		   selected
		*) Radio Height is greater than 600 feet
		*) The difference between Corrected Altitude and GPS Altitude
		   exceeds a threshold computed by EGPWS

	2) Altimeter setting during climb
	    Message: "ALTIMETER SETTING"
	    Frequency: once
	    Conditions:
		*) Above Transition Altitude
		*) Corrected Baro Altitude and Uncorrected Baro Altitude inputs
		   are functional
		*) The aircraft has been above the Transition Altitude (from
		   database) for more than 30 seconds but not more than 5 mins
		*) The difference between Corrected Altitude and Uncorrected
		   Altitude is less than a threshold computed by EGPWS, or
		   Barometric Altitude Reference does not equal standard,
		   depending on the selected aircraft type.

	3) Taxiway landing
	    Message: "CAUTION TAXIWAY! CAUTION TAXIWAY!"
	    Frequency: repeat
	    Conditions:
		*) Between 250 and 150 feet AGL
		*) Not aligned with runway
		*) Advisory not available below 150 feet AGL

	4) Unstable approach (flaps)
	    Message: "FLAPS, FLAPS" or "UNSTABLE! UNSTABLE!"
	    Frequency: once
	    Conditions:
		*) GPS and Radio Altimeter inputs are functional
		*) Aircraft is within 5nm of destination runway
		*) Landing flaps is not selected
		*) Aircraft is below 950 feet AGL (1st message, "FLAPS, FLAPS")
		*) Aircraft is below 600 feet AGL and lined up with the
		   runway (2nd message, "FLAPS, FLAPS")
		*) Aircraft is between 450 and 300 feet AGL (message:
		    "UNSTABLE! UNSTABLE!")

	5) Unstable approach (too high)
	    Message: "TOO HIGH! TOO HIGH!" or "UNSTABLE! UNSTABLE!"
	    Frequency: once
	    Conditions:
		*) GPS, Corrected Baro Altitude and Radio Altimeter inputs are
		   functional
		*) Landing runway has known G/S angle in database
		*) Landing gear is down and Landing Flap is set
		*) Aircraft departs more than 0.5 degrees above optimal G/S
		   angle
		*) Lined up with the landing runway and Radio Altitude between
		   950 and 600 feet AGL (1st message, "TOO HIGH! TOO HIGH!")
		*) Lined up with the landing runway, between 600 and 450 feet
		   AGL, irrespective of gear and flap setting (2nd message,
		   "TOO HIGH! TOO HIGH!")
		*) Lined up with the landing runway, between 300 and 450 feet
		   AGL, irrespective of gear and flap setting (3rd message,
		   "UNSTABLE! UNSTABLE!")

	6) Insufficient runway length on ground
	    Message: "ON RUNWAY XX[LCR], YYYY THOUSAND REMAINING"
	    Frequency: once
	    Conditions:
		*) Aircraft on runway
		*) Within 20 degrees of runway heading
		*) Runway length available is marginal for normal takeoff

	7) Long landing
	    Message: "LONG LANDING! LONG LANDING!"
	    Frequency: once
	    Conditions:
		*) Aircraft below 100 feet AGL
		*) No weight on wheels detected
		*) Touchdown didn't occur within first 1000 feet or 1/3 of
		   runway length or remaining runway length shorter than
		   operator-defined threshold (whichever is shortest)

	8) Runway distance remaining
	    Message: "XXXX THOUSAND REMAINING"
	    Conditions:
		*) Aircraft on or above last half of runway below 100 feet AGL
		*) Groundspeed > 40 knots
		*) Calls suppressed during go-around
		    +) Above 100 feet AGL
		    +) Climb rate 300 FPM or greater
		*) Does not ensure aircraft will or can be stopped before
		   runway edge / end

	9) Approaching runway in flight
	    Message: "APPROACHING XX[LCR]"
	    Conditions:
		*) Between 750 and 300 feet AFE
		*) Within approximately 3 nm of runway
		*) Track aligned within 20 degrees of runway
		*) Within approximately 200 feet, plus width, of runway
		   centerline
		*) Suppressed between 520-480 feet AGL, 420-380 feet AGL and
		   320-300 feet AGL to allow for crew/radio altimeter callouts

	10) Approaching runway on the ground
	    Message: "APPROACHING XX[LCR]"
	    Conditions:
		*) Nose of the aircraft approximately 1 second from crossing
		   boundary of 1.5x runway width from the runway centerline
		   (calculated based on ground speed)
		*) Inhibited above 40 knots ground speed

	11) On runway
	    Message: "ON RUNWAY XX[LCR]"
	    Conditions:
		*) Aircraft on runway
		*) Within 20 degrees of runway heading

	12) Short runway for landing
	    Message: "CAUTION! SHORT RUNWAY! SHORT RUNWAY!"
	    Conditions:
		*) Between 450 and 300 feet AFE
		*) Within approximately 3nm of runway
		*) Track aligned within 20 degrees of runway
		*) Within approximately 200 feet, plus runway width, of
		   runway centerline
		*) Runway length below operator-defined minimum

	13) On taxiway takeoff
	    Message: "CAUTION! ON TAXIWAY! ON TAXIWAY!"
	    Conditions:
		*) Aircraft not on runway
		*) Ground speed above 40 knots

	14) Short runway for takeoff
	    Message: "CAUTION! SHORT RUNWAY! SHORT RUNWAY!"
	    Conditions:
		*) Aircraft on runway
		*) Within 20 degrees of runway heading
		*) Runway length below operator-defined minimum
		*) Ground speed above 40 knots

	15) Distance remaining for rejected takeoff
	    Message: "XXXX THOUSAND/HUNDRED REMAINING"
	    Conditions:
		*) Max ground speed attained above 40 knots
		*) Decelerated 5 knots below max ground speed
		*) Ground speed above 40 knots

	16) Too fast on approach
	    Message: "TOO FAST! TOO FAST!" or "UNSTABLE! UNSTABLE!"
	    Conditions:
		*) <WON'T IMPLEMENT>

	17) Nearing runway end
	    Message: "100 HUNDRED REMAINING"
	    Conditions:
		*) 100 feet of runway remaining
		*) Within 20 degrees of runway heading
		*) Ground speed below 40 knots

	18) Extended holding on runway
	    Message: "ON RUNWAY XX[LCR]"
	    Conditions:
		*) Aircraft on runway
		*) Within 20 degrees of runway heading
		*) Holding in position for extended period (ground speed
		   below 3 kts)
		*) Operator-defined initial delay (60, 90, 120, 180, 240 or
		   300 seconds) and repeat intervals (30, 60, 90, 120, 180,
		   240 or 300 seconds)

	19) Takeoff flaps
	    Message: "ON RUNWAY XX[LCR] FLAPS! FLAPS!"
	    Conditions:
		*) Aircraft on runway
		*) Within 20 degrees of runway heading
		*) Flaps not in takeoff configuration

--]]

local DIRSEP

-- function indirection tables
raas = {}
raas.dbg = {}
raas.matrix = {}
raas.vect2 = {}
raas.vect3 = {}
raas.xlate = {}
raas.conv = {}
raas.fpp = {}
raas.const = {}

if SYSTEM == "IBM" then
	DIRSEP = "\\"
else
	DIRSEP = "/"
end
raas.const.EXEC_INTVAL = 0.5			-- seconds
raas.const.HDG_ALIGN_THRESH = 25		-- degrees
raas.const.SPEED_THRESH = 20.5			-- m/s, 40 knots
raas.const.HIGH_SPEED_THRESH = 30.9		-- m/s, 60 knots
raas.const.SLOW_ROLL_THRESH = 5.15		-- m/s, 10 knots
raas.const.STOPPED_THRESH = 2.06		-- m/s, 4 knots
raas.const.EARTH_MSL = 6371000			-- meters
raas.const.RWY_PROXIMITY_LAT_FRACT = 3
raas.const.RWY_PROXIMITY_LON_DISPL = 609.57	-- meters, 2000 ft
raas.const.RWY_PROXIMITY_TIME_FACT = 2		-- seconds
raas.const.LANDING_ROLLOUT_TIME_FACT = 1	-- seconds
raas.const.RADALT_GRD_THRESH = 5		-- feet
raas.const.RADALT_FLARE_THRESH = 100		-- feet
raas.const.RADALT_DEPART_THRESH = 100		-- feet
raas.const.STARTUP_DELAY = 3			-- seconds
raas.const.INIT_MSG_TIMEOUT = 25		-- seconds
raas.const.ARPT_RELOAD_INTVAL = 10		-- seconds
raas.const.ARPT_LOAD_LIMIT = 8 * 1852		-- meters, 8nm distance
raas.const.ACCEL_STOP_SPD_THRESH = 2.6		-- m/s, 5 knots
raas.const.STOP_INIT_DELAY = 300		-- meters
raas.const.BOGUS_THR_ELEV_LIMIT = 500		-- feet
raas.const.STD_BARO_REF = 29.92			-- inches of mercury
raas.const.ALTM_SETTING_TIMEOUT = 30		-- seconds
raas.const.ALTM_SETTING_ALT_CHK_LIMIT = 1500	-- feet
raas.const.ALTIMETER_SETTING_QNH_ERR_LIMIT = 120-- feet
raas.const.ALTM_SETTING_QFE_ERR_LIMIT = 120	-- feet
raas.const.ALTM_SETTING_BARO_ERR_LIMIT = 0.02	-- inches of mercury
raas.const.IMMEDIATE_STOP_DIST = 50		-- meters
raas.const.GOAROUND_CLB_RATE_THRESH = 300	-- feet per minute
raas.const.OFF_RWY_HEIGHT_MAX = 250		-- feet
raas.const.OFF_RWY_HEIGHT_MIN = 100		-- feet

raas.const.RWY_APCH_PROXIMITY_LAT_ANGLE = 3.3	-- degrees
raas.const.RWY_APCH_PROXIMITY_LON_DISPL = 5500	-- meters
-- precomputed, since it doesn't change
raas.const.RWY_APCH_PROXIMITY_LAT_DISPL =
    raas.const.RWY_APCH_PROXIMITY_LON_DISPL *
    math.tan(math.rad(raas.const.RWY_APCH_PROXIMITY_LAT_ANGLE))
raas.const.RWY_APCH_FLAP1_THRESH = 950		-- feet
raas.const.RWY_APCH_FLAP2_THRESH = 600		-- feet
raas.const.RWY_APCH_FLAP3_THRESH = 450		-- feet
raas.const.RWY_APCH_FLAP4_THRESH = 300		-- feet
raas.const.ARPT_APCH_BLW_ELEV_THRESH = 500	-- feet
raas.const.RWY_APCH_ALT_MAX = 700		-- feet
raas.const.RWY_APCH_ALT_MIN = 320		-- feet
raas.const.SHORT_RWY_APCH_ALT_MAX = 390		-- feet
raas.const.SHORT_RWY_APCH_ALT_MIN = 320		-- feet
raas.const.RWY_APCH_SUPP_WINDOWS = {		-- Suppress 'approaching'
    {["max"] = 530, ["min"] = 480},		-- annunciations in these
    {["max"] = 430, ["min"] = 380},		-- altitude windows (based
}						-- on radio altitude).
raas.const.TATL_REMOTE_ARPT_DIST_LIMIT = 500000	-- meters
raas.const.MIN_BUS_VOLT = 11			-- Volts
raas.const.BUS_LOAD_AMPS = 2			-- Amps
raas.const.XRAAS_apt_dat_cache_version = 3
raas.const.UNITS_APPEND_INTVAL = 120		-- seconds

-- This is what we set our ND alert dataref to when we want to communicate
-- to the aircraft's FMS that it should display a message on the ND. Value
-- '0' is reserved for 'nothing'.
--
-- Since the dataref is an int and we need to annunciate various messages,
-- we split this int into several bitfields:
-- bits 0 - 7  (8 bits):	message ID
-- bits 8 - 13 (6 bits):	numeric runway ID:
--				'00' means 'taxiway'
--				'01' through '36' means a runway ID
--				'37' means 'RWYS' (i.e. multiple runways)
-- bits 14 - 15 (2 bits):	'0' means 'no suffix'
--				'1' means 'RIGHT'
--				'2' means 'LEFT'
--				'3' means 'CENTER'
-- bits 16 - 23 (8 bits):	Runway length available to the nearest 100
--				feet or meters. '0' means 'do not display'.
-- Bits 8 through 23 are only used by the ND_ALERT_APP and ND_ALERT_ON messages.
raas.const.ND_ALERT_FLAPS = 1		-- 'FLAPS' message on ND
raas.const.ND_ALERT_TOO_HIGH = 2	-- 'TOO HIGH' message on ND
raas.const.ND_ALERT_TOO_FAST = 3	-- 'TOO FAST' message on ND
raas.const.ND_ALERT_UNSTABLE = 4	-- 'UNSTABLE' message on ND
raas.const.ND_ALERT_TWY = 5		-- 'TAXIWAY' message on ND
raas.const.ND_ALERT_SHORT_RWY = 6	-- 'SHORT RUNWAY' message on ND
raas.const.ND_ALERT_ALTM_SETTING = 7	-- 'ALTM SETTING' message on ND

-- ND alert severity
raas.const.ND_ALERT_ROUTINE = 0
raas.const.ND_ALERT_NONROUTINE = 1
raas.const.ND_ALERT_CAUTION = 2

-- These two messages encode what we're approaching/on in bits 8 through 15
raas.const.ND_ALERT_APP = 8		-- 'APP XX' or 'APP XX ZZ' messages.
--					'XX' means runway ID (8 - 15).
--					'ZZ' means runway length (bits 16 - 23).
raas.const.ND_ALERT_ON = 9		-- 'ON XX' or 'ON XX ZZ' messages.
--					'XX' means runway ID (bits 8 - 15).
--					'ZZ' means runway length (bits 16 - 23).

raas.const.ND_ALERT_LONG_LAND = 10


raas.const.MSG_PRIO_LOW = 1
raas.const.MSG_PRIO_MED = 2
raas.const.MSG_PRIO_HIGH = 3

raas.const.incompat_acf = {
    "LES_Saab_340A"
}

-- config stuff (to be overridden by acf)
RAAS_enabled = true
RAAS_min_engines = 2				-- count
RAAS_min_MTOW = 5700				-- kg
RAAS_allow_helos = false
RAAS_auto_disable_notify = true
RAAS_override_electrical = false
RAAS_override_replay = false
RAAS_speak_units = true

RAAS_use_imperial = true
RAAS_min_takeoff_dist = 1000			-- meters
RAAS_min_landing_dist = 800			-- meters
RAAS_min_rotation_dist = 400			-- meters
RAAS_min_rotation_angle = 3			-- degrees
RAAS_stop_dist_cutoff = 1500			-- meters
RAAS_voice_female = true
RAAS_voice_volume = 1.0
RAAS_disable_ext_view = true
RAAS_min_landing_flap = 0.5			-- ratio
RAAS_min_takeoff_flap = 0.1			-- ratio
RAAS_max_takeoff_flap = 0.75			-- ratio

RAAS_ND_alerts_enabled = true
RAAS_ND_alert_filter = raas.const.ND_ALERT_ROUTINE
RAAS_ND_alert_overlay_enabled = true
RAAS_ND_alert_overlay_force = false
RAAS_ND_alert_timeout = 7			-- seconds

RAAS_on_rwy_warn_initial = 60			-- seconds
RAAS_on_rwy_warn_repeat = 120			-- seconds
RAAS_on_rwy_warn_max_n = 3

RAAS_GPWS_priority_dataref = "sim/cockpit2/annunciators/GPWS"
RAAS_GPWS_inop_dataref = "sim/cockpit/warnings/annunciators/GPWS"

-- Although this can be overridden by the config file, it is not documented
-- deliberately, as understanding how this table behaves requires some amount
-- of knowledge of how X-RAAS handles distance readouts. Thus, you change it
-- at your own peril.
RAAS_accel_stop_distances = {
	-- Because we examine these ranges in 0.5 second intervals, there is
	-- a maximum speed at which we are guaranteed to announce the distance
	-- remaining. The ranges are configured so as to allow for a healthy
	-- maximum speed margin over anything that could be reasonably attained
	-- over that portion of the runway.
	[9000] = {["max"] = 2807, ["min"] = 2743},	-- 9200-9000 ft, 250 KT
	[8000] = {["max"] = 2503, ["min"] = 2439},	-- 8200-8000 ft, 250 KT
	[7000] = {["max"] = 2198, ["min"] = 2134},	-- 7200-7000 ft, 250 KT
	[6000] = {["max"] = 1892, ["min"] = 1828},	-- 6200-6000 ft, 250 KT
	[5000] = {["max"] = 1588, ["min"] = 1524},	-- 5200-5000 ft, 250 KT
	[4000] = {["max"] = 1284, ["min"] = 1220},	-- 4200-4000 ft, 250 KT
	[3000] = {["max"] = 1036, ["min"] = 915},	-- 3200-3000 ft, 250 KT
	[2000] = {["max"] = 674, ["min"] = 610},	-- 2200-2000 ft, 250 KT
	[1000] = {["max"] = 369, ["min"] = 305},	-- 1200-1000 ft, 250 KT
	[500] = {["max"] = 185, ["min"] = 153},		-- 600-500 ft, 125 KT
	[100] = {["max"] = 46, ["min"] = 31}		-- 150-100 ft, 60 KT
}

RAAS_too_high_enabled = true
RAAS_too_fast_enabled = true
RAAS_gpa_limit_mult = 2			-- multiplier
RAAS_gpa_limit_max = 8			-- degrees

RAAS_alt_setting_enabled = true
RAAS_qnh_alt_enabled = true
RAAS_qfe_alt_enabled = false

RAAS_US_runway_numbers = false

RAAS_long_land_lim_abs = 610			-- 2000 feet
RAAS_long_land_lim_fract = 0.25			-- fraction between 0 and 1

-- Debug settings. These aren't documented, as they're rather advanced.
RAAS_debug = {}
RAAS_debug_graphical = false
RAAS_debug_graphical_bg = 0

-- DO NOT CHANGE THIS!
raas.const.xpdir = SCRIPT_DIRECTORY .. ".." .. DIRSEP .. ".." .. DIRSEP ..
    ".." .. DIRSEP .. ".." .. DIRSEP

local dr = {}

raas.cur_arpts = {}
raas.start_time = os.clock()
raas.last_exec_time = raas.start_time
raas.last_airport_reload = 0
raas.ND_alert_start_time = 0

raas.airport_geo_table = {}
raas.apt_dat = {}

raas.on_rwy_ann = {}
raas.apch_rwy_ann = {}
raas.apch_rwys_ann = false	-- when multiple met the criteria
raas.air_apch_rwy_ann = {}
raas.air_apch_rwys_ann = false	-- when multiple met the criteria
raas.air_apch_short_rwy_ann = false
raas.air_apch_flap1_ann = {}
raas.air_apch_flap2_ann = {}
raas.air_apch_flap3_ann = {}
raas.air_apch_gpa1_ann = {}
raas.air_apch_gpa2_ann = {}
raas.air_apch_gpa3_ann = {}
raas.air_apch_spd1_ann = {}
raas.air_apch_spd2_ann = {}
raas.air_apch_spd3_ann = {}
raas.on_twy_ann = false
raas.long_landing_ann = false
raas.short_rwy_takeoff_chk = false
raas.on_rwy_timer = -1
raas.on_rwy_warnings = 0
raas.off_rwy_ann = false
raas.rejected_takeoff = nil

raas.accel_stop_max_spd = {}
raas.accel_stop_ann_initial = 0
raas.departed = false
raas.arriving = false
raas.landing = false

raas.TA = 0
raas.TL = 0
raas.TATL_field_elev = nil
raas.TATL_state = "alt"
raas.TATL_transition = -1
raas.TATL_source = nil

local messages = {
	["0"] = {}, ["1"] = {}, ["2"] = {}, ["3"] = {}, ["4"] = {},
	["5"] = {}, ["6"] = {}, ["7"] = {}, ["8"] = {}, ["9"] = {}, ["30"] = {},
	["alt_set"] = {}, ["apch"] = {}, ["avail"] = {}, ["caution"] = {},
	["center"] = {}, ["feet"] = {}, ["flaps"] = {}, ["hundred"] = {},
	["left"] = {}, ["long_land"] = {}, ["meters"] = {}, ["on_rwy"] = {},
	["on_twy"] = {}, ["right"] = {}, ["rmng"] = {}, ["rwys"] = {},
	["pause"] = {}, ["short_rwy"] = {}, ["thousand"] = {},
	["too_fast"] = {}, ["too_high"] = {}, ["twy"] = {}, ["unstable"] = {}
}
raas.cur_msg = {}
raas.view_is_ext = false
raas.bus_loaded = -1
raas.last_elev = 0
raas.last_gs = 0	-- in m/s
raas.last_units_call = 0

-- Checks if RAAS_debug has index `category' set to a value of greater than
-- or equal to `level' and if yes, prints "RAAS_debug[<category>]: <msg>"
function raas.dbg.log(category, level, msg)
	if RAAS_debug[category] ~= nil and RAAS_debug[category] >= level then
		logMsg("RAAS_debug[" .. category .. "]: " .. msg)
	end
end

--[[
   Author: Julio ]Manuel Fernandez-Diaz
   Date:   January 12, 2007
   (For Lua 5.1)

   Modified slightly by RiciLake to avoid the unnecessary table traversal
   in tablecount()

   Formats tables with cycles recursively to any depth.
   The output is returned as a string.
   References to other tables are shown as values.
   Self references are indicated.

   The string returned is "Lua code", which can be processed
   (in the case in which indent is composed by spaces or "--").
   Userdata and function keys and values are shown as strings,
   which logically are exactly not equivalent to the original code.

   This routine can serve for pretty formatting tables with
   proper indentations, apart from printing them:

      print(table.show(t, "t"))   -- a typical use

   Heavily based on "Saving tables with cycles", PIL2, p. 113.

   Arguments:
      t is the table.
      name is the name of the table (optional)
      indent is a first indentation (optional).
--]]

-- (RiciLake) returns true if the table is empty
function table.isempty(t)
	return next(t) == nil
end

function shallowcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

-- Returns a pair of integer indices that can be used into the
-- raas.airport_geo_table to retrieve the tile for a given latitude & longitude.
function raas.geo_table_idx(lat, lon)
	if lat < -80 or lat > 80 then
		return nil, nil
	end
	lat = math.floor(lat)
	if lon < -180 then
		lon = lon + 360
	end
	if lon >= 180 then
		lon = lon - 360
	end
	lon = math.floor(lon)

	return lat, lon
end

-- Retrieves the geo table tile which contains lat & lon. If create is true,
-- if the tile doesn't exit, it will be created.
-- Returns the table tile (if it exists) and a boolean returning whether the
-- table tile was created in this call (provided create==true).
function raas.geo_table_get_tile(lat, lon, create)
	local created = false
	local lat_tbl, lon_tbl

	lat, lon = raas.geo_table_idx(lat, lon)
	if lat == nil or lon == nil then
		return nil, false
	end

	lat_tbl = raas.airport_geo_table[lat]
	if lat_tbl == nil then
		if not create then
			return nil, false
		end
		created = true
		lat_tbl = {}
		raas.airport_geo_table[lat] = lat_tbl
	end

	lon_tbl = lat_tbl[lon]
	if lon_tbl == nil then
		if not create then
			return nil, false
		end
		created = true
		lon_tbl = {}
		lat_tbl[lon] = lon_tbl
	end

	return lon_tbl, created
end

function table.show(t, name, indent)
	local cart     -- a container
	local autoref  -- for self references

	local function basicSerialize(o)
		local so = tostring(o)
		if type(s) == "function" then
			local info = debug.getinfo(o, "S")
			-- info.name is nil because o is not a calling level
			if info.what == "C" then
				return string.format("%q", so .. ", C function")
			else
				-- the information is defined through lines
				return string.format("%q", so ..
				    ", defined in (" .. info.linedefined ..
				    "-" .. info.lastlinedefined .. ")" ..
				    info.source)
			end
		elseif type(o) == "number" or type(o) == "boolean" then
			return so
		else
			return string.format("%q", so)
		end
	end

	local function addtocart(value, name, indent, saved, field)
		indent = indent or ""
		saved = saved or {}
		field = field or name

		cart = cart .. indent .. field

		if type(value) ~= "table" then
			cart = cart .. " = " .. basicSerialize(value) .. ";\n"
		else
			if saved[value] then
				cart = cart .. " = {}; -- " .. saved[value]
				    .. " (self reference)\n"
				autoref = autoref ..  name .. " = " ..
				    saved[value] .. ";\n"
			else
				saved[value] = name
				if table.isempty(value) then
					cart = cart .. " = {};\n"
				else
					cart = cart .. " = {\n"
					for k, v in pairs(value) do
						k = basicSerialize(k)
						local fname = string.format(
						    "%s[%s]", name, k)
						field = string.format("[%s]", k)
						-- three spaces between levels
						addtocart(v, fname, indent ..
						    "   ", saved, field)
					end
					cart = cart .. indent .. "};\n"
				end
			end
		end
	end

	name = name or "__unnamed__"
	if type(t) ~= "table" then
		return name .. " = " .. basicSerialize(t)
	end
	cart, autoref = "", ""
	addtocart(t, name, indent)
	return cart .. autoref
end

function raas.matrix.mul(x, y, xrows, ycols, sz)
	local z = {}

	for i = 1, sz * ycols do
		z[i] = 0
	end
	for row = 0, xrows - 1 do
		for col = 0, ycols - 1 do
			for i = 0, sz - 1 do
				z[row * ycols + col + 1] =
				    z[row * ycols + col + 1] +
				    x[row * sz + i + 1] * y[i * ycols + col + 1]
			end
		end
	end

	return z
end

function table.count(t)
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

-- Splits string `str' at separators `sep' and returns an array of components
-- (without the separators).
function string.split(str, sep, skip_empty)
	local res = {}
	local s = 1

	while true do
		local e = str:find(sep, s, true)
		if e == nil then
			break
		end
		if not skip_empty or e - s > 0 then
			res[#res + 1] = str:sub(s, e - #sep)
		end
		s = e + #sep
	end
	if not skip_empty or #str > s then
		res[#res + 1] = str:sub(s)
	end

	return res
end

-- Returns the relative heading between `hdg1' and `hdg2'. A positive return
-- value indicates a right turn and a negative a left turn.
function raas.rel_hdg(hdg1, hdg2)
	if hdg1 > hdg2 then
		if hdg1 > hdg2 + 180 then
			return 360 - hdg1 + hdg2
		else
			return -(hdg1 - hdg2)
		end
	else
		if hdg2 > hdg1 + 180 then
			return -(360 - hdg2 + hdg1)
		else
			return hdg2 - hdg1
		end
	end
end

function raas.m2ft(m)
	assert(m ~= nil)
	return m * 3.281
end

function raas.ft2m(ft)
	assert(ft ~= nil)
	return ft / 3.281
end

-- Basic 2-space vector math. Just read the function names for what they do.

function raas.vect2.add(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return {a[1] + b[1], a[2] + b[2]}
end

function raas.vect2.sub(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return {a[1] - b[1], a[2] - b[2]}
end

function raas.vect2.scmul(a, x)
	assert(a ~= nil)
	assert(x ~= nil)
	return {a[1] * x, a[2] * x}
end

function raas.vect2.abs(a)
	assert(a ~= nil)
	return math.sqrt((a[1] * a[1]) + (a[2] * a[2]))
end

function raas.vect2.set_abs(a, abs)
	assert(a ~= nil)
	assert(abs ~= nil)
	local oldval = raas.vect2.abs(a)
	if oldval ~= 0 then
		return raas.vect2.scmul(a, abs / oldval), oldval
	else
		return a, 0
	end
end

function raas.vect2.norm(v, right)
	assert(v ~= nil)
	assert(right ~= nil)
	if right then
		return {v[2], -v[1]}
	else
		return {-v[2], v[1]}
	end
end

function raas.vect2.neg(v)
	assert(v ~= nil)
	return {-v[1], -v[2]}
end

-- Converts a heading in degrees into a unit direction vector in local space.
function raas.vect2.hdg2dir(hdg)
	assert(hdg ~= nil)
	return {math.sin(math.rad(hdg)), math.cos(math.rad(hdg))}
end

-- Does the reverse of raas.vect2.hdg2dir.
function raas.vect2.dir2hdg(dir)
	assert(dir ~= nil)
	if dir[1] >= 0 and dir[2] >= 0 then
		return math.deg(math.asin(dir[1] / raas.vect2.abs(dir)))
	elseif dir[1] < 0 and dir[2] >= 0 then
		return 360 + math.deg(math.asin(dir[1] / raas.vect2.abs(dir)))
	else
		return 180 - math.deg(math.asin(dir[1] / raas.vect2.abs(dir)))
	end
end

function raas.vect2.parallel(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return (a[2] == 0 and b[2] == 0) or ((a[1] / a[2]) == (b[1] / b[2]))
end

function vect2_eq(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return a[1] == b[1] and a[2] == b[2]
end

-- Checks if two vectors intersect. The vectors are specified by:
--	`a' Direction & magnitude of first vector.
--	`oa' Vector pointing to the origin of the first vector.
--	`b' Direction & magnitude of second vector.
--	`ob' Vector pointing to the origin of the second vector.
--	`confined' A boolean flag. If set, intersections are only examined
--	  on the vectors, otherwise the vectors are considered as if they
--	  were lines of infinite length.
function raas.vect2.vect_isect(a, oa, b, ob, confined)
	assert(a ~= nil)
	assert(oa ~= nil)
	assert(b ~= nil)
	assert(ob ~= nil)
	assert(confined ~= nil)

	if raas.vect2.parallel(a, b) then
		return nil
	end
	if vect2_eq(oa, ob) then
		return oa
	end
	local p1 = oa
	local p2 = raas.vect2.add(oa, a)
	local p3 = ob
	local p4 = raas.vect2.add(ob, b)

	local det = (p1[1] - p2[1]) * (p3[2] - p4[2]) -
	    (p1[2] - p2[2]) * (p3[1] - p4[1])
	local ca = p1[1] * p2[2] - p1[2] * p2[1]
	local cb = p3[1] * p4[2] - p3[2] * p4[1]
	local res = {
	    (ca * (p3[1] - p4[1]) - cb * (p1[1] - p2[1])) / det,
	    (ca * (p3[2] - p4[2]) - cb * (p1[2] - p2[2])) / det
	}

	if confined then
		if res[1] < math.min(p1[1], p2[1]) or
		    res[1] > math.max(p1[1], p2[1]) or
		    res[1] < math.min(p3[1], p4[1]) or
		    res[1] > math.max(p3[1], p4[1]) or
		    res[2] < math.min(p1[2], p2[2]) or
		    res[2] > math.max(p1[2], p2[2]) or
		    res[2] < math.min(p3[2], p4[2]) or
		    res[2] > math.max(p3[2], p4[2]) then
			return nil
		end
	end

	return res
end

-- Checks if a vector and a polygon intersect.
--	`a' Direction & magnitude of first vector.
--	`oa' Vector pointing to the origin of the first vector.
--	`poly' An array of 2-space vectors specifying the points on the polygon.
-- Returns an array of vectors pointing to the intersection points.
function raas.vect2.poly_isect(a, oa, poly)
	assert(a ~= nil)
	assert(oa ~= nil)
	assert(poly ~= nil)

	local res = {}

	for i = 0, #poly - 1 do
		local pt1 = poly[i + 1]
		local pt2 = poly[((i + 1) % #poly) + 1]
		local v = raas.vect2.sub(pt2, pt1)
		local isect = raas.vect2.vect_isect(a, oa, v, pt1, true)
		if isect ~= nil then
			res[#res + 1] = isect
		end
	end

	return res
end

-- Checks if a point lies inside of a polygon.
--	`pt' A vector pointing to the position of the point to examine.
--	`poly' An array of 2-space vectors specifying the points on the polygon.
function raas.vect2.in_poly(pt, poly)
	assert(pt ~= nil)
	assert(poly ~= nil)

	-- Simplest approach is ray casting. Construct a vector from `pt' to
	-- a point very far away and count how many edges of the bbox polygon
	-- we hit. If we hit an even number, we're outside, otherwise we're
	-- inside.
	local v = raas.vect2.sub({1000000, 1000000}, pt)
	local isects = raas.vect2.poly_isect(v, pt, poly)
	return (#isects % 2) ~= 0
end

-- Basic 3-space vector math. Just read the function names for what they do.

function raas.vect3.unit(v)
	assert(v ~= nil)

	local len = raas.vect3.abs(v)
	if len == 0 then
		return nil
	else
		return {v[1] / len, v[2] / len, v[3] / len}, len
	end
end

function raas.vect3.add(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return {a[1] + b[1], a[2] + b[2] , a[3] + b[3]}
end

function raas.vect3.sub(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return {a[1] - b[1], a[2] - b[2] , a[3] - b[3]}
end

function raas.vect3.abs(a)
	assert(a ~= nil)
	return math.sqrt(a[1] * a[1] + a[2] * a[2] + a[3] * a[3])
end

function raas.vect3.scmul(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return {a[1] * b, a[2] * b, a[3] * b}
end

function raas.vect3.dotprod(a, b)
	assert(a ~= nil)
	assert(b ~= nil)
	return a[1] * b[1] + a[2] * b[2] + a[3] * b[3]
end

-- Checks if a 3-space vector intersects with a sphere's surface.
--	`a' Direction & magnitude of first vector.
--	`oa' Vector pointing to the origin of the first vector.
--	`c' A 3-space vector pointing to the center of the sphere.
--	`r' A scalar indicating the radius of the sphere.
--	`confined' A boolean flag. If set, intersections are only examined
--	  on the first vector, otherwise the vector is considered as if it
--	  were a line of infinite length.
function raas.vect3.sph_isect(v, o, c, r, confined)
	assert(v ~= nil)
	assert(o ~= nil)
	assert(c ~= nil)
	assert(r ~= nil)
	assert(confined ~= nil)

	local l, d = raas.vect3.unit(v)
	local o_min_c = raas.vect3.sub(o, c)
	local l_dot_o_min_c = raas.vect3.dotprod(l, o_min_c)
	local o_min_c_abs = raas.vect3.abs(o_min_c)
	local sqrt_tmp = (l_dot_o_min_c * l_dot_o_min_c) -
	    (o_min_c_abs * o_min_c_abs) + (r * r)
	local i = {}

	if sqrt_tmp > 0 then
		-- Two solutions
		local i_d
		sqrt_tmp = math.sqrt(sqrt_tmp)
		i_d = -l_dot_o_min_c - sqrt_tmp
		if not confined or (i_d >= 0 and i_d <= d) then
			i[#i + 1] = raas.vect3.add(raas.vect3.scmul(l, i_d), o)
		end
		i_d = -l_dot_o_min_c + sqrt_tmp
		if not confined or (i_d >= 0 and i_d <= d) then
			i[#i + 1] = raas.vect3.add(raas.vect3.scmul(l, i_d), o)
		end
		return i
	elseif sqrt_tmp == 0 then
		-- One solution
		local i_d = -l_dot_o_min_c
		if not confined or (i_d >= 0 and i_d <= d) then
			i[#i + 1] = raas.vect3.add(raas.vect3.scmul(l, i_d), o)
		end
		return i
	else
		-- No solutions
		return {}
	end
end

-- Initializes a set of translation matrices to allow conversion between
-- spherical coordinates (latitude & longitude).
--	`displac' A relative latitude & longitude of the translation from
--	  the origin point.
--	`rot' A rotation to be applied to the coordinate conversion along
--	  the X axis after the coordinate has been translated to the new
--	  origin point specified by `displac'.
--	`inv' A boolean flag indicating if this translation is supposed to
--	  be an inversion of `displac' and `rot'. This allows constructing
--	  two exactly opposite translations to convert back and forth
--	  between two origin points on a sphere:
--		forward_xlate = raas.xlate.init_sph(displac, rot, false)
--		backware_xlate = raas.xlate.init_sph(displac, rot, false)
-- The returned table must be passed to raas.xlate.sph_vect during translation.
function raas.xlate.init_sph(displac, rot, inv)
	assert(displac ~= nil)
	assert(rot ~= nil)
	assert(inv ~= nil)

	local alpha, bravo, theta

	local xlate = {}
	if not inv then
		alpha = math.rad(displac[1])
		bravo = math.rad(-displac[2])
		theta = math.rad(rot)
	else
		alpha = math.rad(-displac[1])
		bravo = math.rad(displac[2])
		theta = math.rad(-rot)
	end

	local sin_alpha, cos_alpha = math.sin(alpha), math.cos(alpha)
	local sin_bravo, cos_bravo = math.sin(bravo), math.cos(bravo)
	local sin_theta, cos_theta = math.sin(theta), math.cos(theta)
	--[[
		+-                  -+
		| cos(a)   0  sin(a) |
		|    0     1     0   |
		| -sin(a)  0  cos(a) |
		+-                  -+
	--]]
	local R_a = {
	    cos_alpha, 0, sin_alpha,
	    0, 1, 0,
	    -sin_alpha, 0, cos_alpha
	}
	--[[
		+-                  -+
		| cos(g)  -sin(g)  0 |
		| sin(g)   cos(g)  0 |
		|   0        0     1 |
		+-                  -+
	--]]
	local R_b = {
	    cos_bravo, -sin_bravo, 0,
	    sin_bravo, cos_bravo, 0,
	    0, 0, 1
	}

	if not inv then
		xlate[1] = raas.matrix.mul(R_a, R_b, 3, 3, 3)
	else
		xlate[1] = raas.matrix.mul(R_b, R_a, 3, 3, 3)
	end

	-- The rotation matrix
	xlate[2] = {
	    cos_theta, -sin_theta,
	    sin_theta, cos_theta
	}

	return xlate
end

-- Given a 3-space vector, translates it according to the spherical
-- translation `xlate'.
function raas.xlate.sph_vect(p, xlate)
	assert(p ~= nil)
	assert(xlate ~= nil)

	local q = raas.matrix.mul(xlate[1], p, 3, 1, 3)
	local r = {q[2], q[3]}
	local s = raas.matrix.mul(xlate[2], r, 2, 1, 2)
	q[2] = s[1]
	q[3] = s[2]
	return q
end

-- Given a set of spherical coordinates {latitude, longitude}, converts them
-- into 3-space ECEF coordinate space. See: https://en.wikipedia.org/wiki/ECEF
function raas.conv.sph2ecef(pos)
	assert(pos ~= nil)

	local lat_rad = math.rad(pos[1])
	local lon_rad = math.rad(pos[2])
	local R0 = raas.const.EARTH_MSL * math.cos(lat_rad)
	return {R0 * math.cos(lon_rad), R0 * math.sin(lon_rad),
	    raas.const.EARTH_MSL * math.sin(lat_rad)}
end

-- Constructs an orthographic sphere-to-flat plane projection centered at
-- the geographic coordinates at `center'. If the projection shouldn't be
-- oriented `north-up', pass a non-zero `rot' (in degrees) here.
function raas.fpp.init_ortho(center, rot)
	assert(center ~= nil)
	assert(rot ~= nil)

	local fpp = {}

	fpp[1] = raas.xlate.init_sph(center, rot, false)
	fpp[2] = raas.xlate.init_sph(center, rot, true)

	return fpp
end

-- Converts a point defined by spherical coordinates `spp' ({latitude,
-- longitude}) according to the flat-plane-projection `fpp' into a 2-space
-- vector on the projected plane.
function raas.fpp.sph2fpp(pos, fpp)
	assert(pos ~= nil)
	assert(fpp ~= nil)
	local pos_v = raas.xlate.sph_vect(raas.conv.sph2ecef(pos), fpp[1])
	return {pos_v[2], pos_v[3]}
end

-- Inverts the projection done by raas.fpp.sph2fpp(). Please note that since
-- we only support orthographic projections, there are always two points that
-- could correspond to a given projection (since the projection is identical
-- for points on the opposite side of the sphere). In that case, we assume
-- that the caller meant the point on the near side of the sphere.
function raas.fpp.fpp2sph(pos, fpp)
	assert(pos ~= nil)
	assert(fpp ~= nil)

	local v = {-1000000000, pos[1], pos[2]}
	local o = {1000000000, 0, 0}
	local i = raas.vect3.sph_isect(v, o, {0, 0, 0}, raas.const.EARTH_MSL,
	    false)

	if n == 0 then
		return nil
	end
	r = raas.xlate.sph_vect(i[1], fpp[2])

	return ecef2sph(r)
end

-- Returns true if `x' is within the numerical ranges in `rngs', which is an
-- array containing tables of this format:
--	{
--		{["max"] = range_upper_value, ["min"] = range_lower_value},
--		... <etc> ...
--	}
-- The range check is inclusive.
function raas.number_in_rngs(x, rngs)
	for i, rng in pairs(rngs) do
		if x <= rng["max"] and x >= rng["min"] then
			return true
		end
	end
	return false
end

function raas.reset()
	dr.baro_alt = dataref_table("sim/flightmodel/misc/h_ind")
	dr.rad_alt = dataref_table("sim/cockpit2/gauges/indicators/" ..
	    "radio_altimeter_height_ft_pilot")
	dr.airspeed = dataref_table(
	    "sim/flightmodel/position/indicated_airspeed")
	dr.gs = dataref_table("sim/flightmodel/position/groundspeed")
	dr.lat = dataref_table("sim/flightmodel/position/latitude")
	dr.lon = dataref_table("sim/flightmodel/position/longitude")
	dr.elev = dataref_table("sim/flightmodel/position/elevation")
	dr.hdg = dataref_table("sim/flightmodel/position/true_psi")
	dr.pitch = dataref_table("sim/flightmodel/position/true_theta")
	dr.nw_offset = dataref_table("sim/flightmodel/parts/" ..
	    "tire_z_no_deflection")
	dr.flaprqst = dataref_table("sim/flightmodel/controls/flaprqst")
	dr.gear = dataref_table("sim/aircraft/parts/acf_gear_deploy")
	dr.gear_type = dataref_table("sim/aircraft/parts/acf_gear_type")
	dr.baro_set = dataref_table("sim/cockpit/misc/barometer_setting")
	dr.baro_sl = dataref_table("sim/weather/barometer_sealevel_inhg")
	dr.ext_view = dataref_table("sim/graphics/view/view_is_external")
	dr.bus_volt = dataref_table("sim/cockpit2/electrical/bus_volts")
	dr.avionics_on = dataref_table("sim/cockpit/electrical/avionics_on")
	dr.num_engines = dataref_table("sim/aircraft/engine/acf_num_engines")
	dr.mtow = dataref_table("sim/aircraft/weight/acf_m_max")
	dr.ICAO = dataref_table("sim/aircraft/view/acf_ICAO")
	if RAAS_GPWS_priority_dataref ~= nil then
		dr.gpws_prio = dataref_table(RAAS_GPWS_priority_dataref)
	else
		dr.gpws_prio = {[0] = 0}
	end
	if RAAS_GPWS_inop_dataref ~= nil then
		dr.gpws_inop = dataref_table(RAAS_GPWS_inop_dataref)
	else
		dr.gpws_inop = {[0] = 0}
	end

	-- This is an ugly hack, but we can't create custom datarefs from
	-- within Lua
	dr.ND_alert = dataref_table(
	    "sim/multiplayer/position/plane19_taxi_light_on")

	dr.replay_mode = dataref_table("sim/operation/prefs/replay_mode")

	-- Unfortunately at this moment electrical loading is broken,
	-- because X-Plane resets plugin_bus_load_amps when the aircraft
	-- is repositioned, making it impossible for us to track our
	-- electrical load appropriately. So it's better to disable it,
	-- than to have it be broken.
	--dr.plug_bus_load = dataref_table("sim/cockpit2/electrical/" ..
	--    "plugin_bus_load_amps")
	dr.plug_bus_load = {[0] = 0, [1] = 0}

end

-- Converts an quantity which is calculated per execution cycle of X-RAAS
-- into a per-minute quantity, so the caller need not worry about X-RAAS
-- execution frequency
function raas.conv_per_min(x)
	return x * (60 / raas.const.EXEC_INTVAL)
end

-- Returns true if landing gear is fully retracted, false otherwise.
function raas.gear_is_up()
	for i = 0, 9 do
		if dr.gear_type[i] ~= 0 and dr.gear[i] > 0 then
			return false
		end
	end
	return true
end

function raas.GPWS_has_priority()
	return dr.gpws_prio[0] ~= 0
end

function raas.chk_acf_dr(acf_icaos, dr_name)
	for i, icao in pairs(acf_icaos) do
		if PLANE_ICAO == icao then
			return dataref_table(dr_name) ~= nil
		end
	end
	return false
end

-- Checks if the aircraft has a terrain override mode on the GPWS and if it
-- does, returns true if it GPWS terrain warnings are overridden, otherwise
-- returns false.
function raas.gpws_terr_ovrd()
	if raas.chk_acf_dr({"B752", "B753"}, "anim/75/button") then
		return dataref_table("anim/75/button")[0] == 1
	elseif raas.chk_acf_dr({"B772", "B773", "B77L", "B77W"},
	    "anim/51/button") then
		return dataref_table("anim/51/button")[0] == 1
	elseif raas.chk_acf_dr({"B733"}, "ixeg/733/misc/egpws_gear_act") then
		return dataref_table("ixeg/733/misc/egpws_gear_act")[0] == 1
	elseif raas.chk_acf_dr({"B732"}, "FJS/732/Annun/GPWS_InhibitSwitch")
	    then
		return dataref_table("FJS/732/Annun/GPWS_InhibitSwitch")[0] == 1
	elseif raas.chk_acf_dr({"A332", "A333", "A338", "A339", "A318",
	    "A319", "A320", "A321"}, "sim/custom/xap/gpws_terr") then
		return dataref_table("sim/custom/xap/gpws_terr")[0] ~= 0
	end
	return false
end

-- Checks if the aircraft has a flaps override mode on the GPWS and if it
-- does, returns true if it GPWS flaps warnings are overridden, otherwise
-- returns false. If the aircraft doesn't have a flaps override GPWS mode,
-- we attempt to also examine if the aircraft has a terrain override mode.
function raas.gpws_flaps_ovrd()
	if raas.chk_acf_dr({"B752", "B753"}, "anim/72/button") then
		return dataref_table("anim/72/button")[0] == 1
	elseif raas.chk_acf_dr({"B772", "B773", "B77L", "B77W"},
	    "anim/79/button") then
		return dataref_table("anim/79/button")[0] == 1
	elseif raas.chk_acf_dr({"B733"}, "ixeg/733/misc/egpws_flap_act") then
		return dataref_table("ixeg/733/misc/egpws_flap_act")[0] == 1
	elseif raas.chk_acf_dr({"A332", "A333", "A338", "A339", "A318",
	    "A319", "A320", "A321"}, "sim/custom/xap/gpws_flap") then
		return dataref_table("sim/custom/xap/gpws_flap")[0] ~= 0
	end
	return raas.gpws_terr_ovrd()
end

-- Given a runway ID, returns the reciprocal runway ID.
function raas.recip_rwy_id(rwy_id)
	assert(rwy_id ~= nil)

	local num = tonumber(rwy_id:sub(1, 2))
	local recip_num = num + 18
	local recip_suffix = ""
	local recip
	if recip_num > 36 then
		recip_num = recip_num - 36
	end
	if #rwy_id > 2 then
		local suffix = rwy_id:sub(3, 3)
		if suffix == "L" then
			recip_suffix = "R"
		elseif suffix == "R" then
			recip_suffix = "L"
		else
			recip_suffix = suffix
		end
	end
	if recip_num < 10 then
		recip = "0" .. recip_num .. recip_suffix
	else
		recip = recip_num .. recip_suffix
	end
	return recip
end

-- Given a runway threshold vector, direction vector, width, length and
-- threshold longitudinal displacement, prepares a bounding box which
-- encompasses that runway.
function raas.make_rwy_bbox(thresh_v, dir_v, width, len, long_displ)
	assert(thresh_v ~= nil)
	assert(dir_v ~= nil)
	assert(width ~= nil)
	assert(len ~= nil)
	assert(long_displ ~= nil)

	local a, b, c, d, len_displ_v
	local vect2 = raas.vect2

	-- displace the 'a' point from the runway threshold laterally
	-- by 1/2 width to the right
	a = vect2.add(thresh_v, vect2.set_abs(vect2.norm(dir_v, true),
	    width / 2))
	-- pull it back by `long_displ'
	a = vect2.add(a, vect2.set_abs(vect2.neg(dir_v), long_displ))

	-- do the same for the `d' point, but displace to the left
	d = vect2.add(thresh_v, vect2.set_abs(vect2.norm(dir_v, false),
	    width / 2))
	-- pull it back by `long_displ'
	d = vect2.add(d, vect2.set_abs(vect2.neg(dir_v), long_displ))

	-- points `b' and `c' are along the runway simply as runway len +
	-- long_displ
	len_displ_v = vect2.set_abs(dir_v, len + long_displ)
	b = vect2.add(a, len_displ_v)
	c = vect2.add(d, len_displ_v)

	return {a, b, c, d}
end

-- Checks if the numerical runway type `t' is a hard-surface runway. From
-- the X-Plane v850 apt.dat spec:
--	t=1: asphalt
--	t=2: concrete
--	t=15: unspecified hard surface (transparent)
function raas.rwy_is_hard(t)
	return (t == 1 or t == 2 or t == 15)
end

-- Parses an apt.dat (or X-RAAS_apt_dat.cache) file, parses its contents
-- and reconstructs our raas.apt_dat table. This is called at the start of
-- X-RAAS to populate the airport and runway database. The 
function raas.map_apt_dat(apt_dat_fname)
	assert(apt_dat_fname ~= nil)

	raas.dbg.log("tile", 2, "raas.map_apt_dat(\"" .. apt_dat_fname .. "\")")

	apt_dat_f = io.open(apt_dat_fname)
	if apt_dat_f == nil then
		return 0
	end

	local arpt_cnt = 0
	local apt = nil
	local icao = nil
	local comps

	while true do
		local line = apt_dat_f:read()
		if line == nil then
			break
		end
		if line:find("1 ", 1, true) == 1 then
			local comps = string.split(line, " ", true)
			local new_icao = comps[5]
			local thisTA, thisTL = 0, 0
			local lat, lon

			if #comps >= 9 and
			    comps[6]:find("TA:", 1, true) == 1 and
			    comps[7]:find("TL:", 1, true) == 1 and
			    comps[8]:find("LAT:", 1, true) == 1 and
			    comps[9]:find("LON:", 1, true) == 1 then
				thisTA = tonumber(comps[6]:sub(4))
				thisTL = tonumber(comps[7]:sub(4))
				lat = tonumber(comps[8]:sub(5))
				lon = tonumber(comps[9]:sub(5))
			end

			icao = nil
			apt = nil

			if raas.apt_dat[new_icao] == nil then
				arpt_cnt = arpt_cnt + 1
				apt = {
				    ["elev"] = tonumber(comps[2]),
				    ["rwys"] = {},
				    ["TA"] = thisTA,
				    ["TL"] = thisTL,
				    ["lat"] = lat,
				    ["lon"] = lon
				}
				icao = new_icao
				raas.apt_dat[icao] = apt
				if lat ~= nil and lon ~= nil then
					local tile = raas.geo_table_get_tile(
					    lat, lon, false)
					assert(tile ~= nil)
					tile[icao] = {lat, lon}
					raas.dbg.log("tile", 2, "geo_xref\t" ..
					    icao .. "\t" .. lat .. "\t" .. lon)
				end
			end
		elseif line:find("100 ", 1, true) == 1 and icao ~= nil then
			local comps = string.split(line, " ", true)
			local width = comps[2]
			local id1 = comps[8 + 1]
			local lat1 = comps[8 + 2]
			local lon1 = comps[8 + 3]
			local displ1 = comps[8 + 4]
			local blast1 = comps[8 + 5]
			local id2 = comps[8 + 9 + 1]
			local lat2 = comps[8 + 9 + 2]
			local lon2 = comps[8 + 9 + 3]
			local displ2 = comps[8 + 9 + 4]
			local blast2 = comps[8 + 9 + 5]
			local rwys = apt["rwys"]
			local gpa1, gpa2, tch1, tch2, telev1, telev2 =
			    0, 0, 0, 0, 0, 0
			local rwy

			if raas.rwy_is_hard(tonumber(comps[3])) then
				if #comps >= 28 and
				    comps[23]:find("GPA1:", 1, true) == 1 and
				    comps[24]:find("GPA2:", 1, true) == 1 and
				    comps[25]:find("TCH1:", 1, true) == 1 and
				    comps[26]:find("TCH2:", 1, true) == 1 and
				    comps[27]:find("TELEV1:", 1, true) == 1 and
				    comps[28]:find("TELEV2:", 1, true) == 1 then
					gpa1 = tonumber(comps[23]:sub(6))
					gpa2 = tonumber(comps[24]:sub(6))
					tch1 = tonumber(comps[25]:sub(6))
					tch2 = tonumber(comps[26]:sub(6))
					telev1 = tonumber(comps[27]:sub(8))
					telev2 = tonumber(comps[28]:sub(8))
				end

				rwy = {
				    ["w"] = width,
				    ["id1"] = id1, ["lat1"] = lat1,
				    ["lon1"] = lon1, ["dis1"] = displ1,
				    ["bla1"] = blast1, ["gpa1"] = gpa1,
				    ["tch1"] = tch1, ["te1"] = telev1,
				    ["id2"] = id2, ["lat2"] = lat2,
				    ["lon2"] = lon2, ["dis2"] = displ2,
				    ["bla2"] = blast2, ["gpa2"] = gpa2,
				    ["tch2"] = tch2, ["te2"] = telev2
				}

				rwys[#rwys + 1] = rwy
			end
		end
	end

	io.close(apt_dat_f)

	return arpt_cnt
end

-- Locates all apt.dat files used by X-Plane to display scenery. It consults
-- scenery_packs.ini to determine which scenery packs are currently enabled
-- and together with the default apt.dat returns them in a list sorted
-- numerically in preference order (lowest index for highest priority).
-- If the as_keys argument is true, the returned list is instead indexed
-- by the apt.dat file name and the values are the preference order of that
-- apt.dat (starting from 1 for highest priority and increasing with lowering
-- priority).
-- The apt.dat filenames relative to the X-Plane main folder
-- (raas.const.xpdir), not full filesystem paths.
function raas.find_all_apt_dats(as_keys)
	local apt_dats = {}
	local i = 1

	local scenery_packs_ini = io.open(raas.const.xpdir ..
	    "Custom Scenery" .. DIRSEP .. "scenery_packs.ini")

	if scenery_packs_ini ~= nil then
		for line in scenery_packs_ini:lines() do
			if line:find("SCENERY_PACK ", 1, true) == 1 then
				local scn_name = line:sub(14)
				local filename = scn_name ..
				    "Earth nav data" .. DIRSEP .. "apt.dat"
				local fp = io.open(raas.const.xpdir ..
				    filename)
				if fp ~= nil then
					fp:close()
					if as_keys then
						apt_dats[filename] = i
						i = i + 1
					else
						apt_dats[#apt_dats + 1] =
						    filename
					end
				end
			end
		end
		io.close(scenery_packs_ini)
	end

	local default_apt_dat_filename = "Resources" .. DIRSEP ..
	    "default scenery" .. DIRSEP .. "default apt dat" ..
	    DIRSEP .. "Earth nav data" .. DIRSEP .. "apt.dat"
	if as_keys then
		apt_dats[default_apt_dat_filename] = i
	else
		apt_dats[#apt_dats + 1] = default_apt_dat_filename
	end

	return apt_dats
end

-- Reloads ~/GNS430/navdata/Airports.txt and populates our raas.apt_dat
-- airports with the latest info in it, notably:
-- *) transition altitudes & transition levels for the airports
-- *) runway threshold elevation, glide path angle & threshold crossing height
function raas.load_airports_txt()
	-- We first try the Custom Data version, as that's more up to date
	local airports_fname = raas.const.xpdir .. "Custom Data" .. DIRSEP ..
	    "GNS430" .. DIRSEP .. "navdata" .. DIRSEP .. "Airports.txt"
	local fp = io.open(airports_fname)
	local last_arpt = nil

	if fp == nil then
		-- Try the Airports.txt shipped with X-Plane.
		airports_fname = raas.const.xpdir .. "Resources" .. DIRSEP ..
		    "GNS430" .. DIRSEP .. "navdata" .. DIRSEP .. "Airports.txt"
		fp = io.open(airports_fname)
		if fp == nil then
			logMsg("X-RAAS: missing Airports.txt, please check " ..
			    "your navdata and recreate the cache")
			return
		end
	end

	for line in fp:lines() do
		if line:find("A,", 1, true) == 1 then
			local comps = string.split(line, ",")
			local icao = comps[2]
			local lat = tonumber(comps[4])
			local lon = tonumber(comps[5])
			local TA = tonumber(comps[7])
			local TL = tonumber(comps[8])
			local db_arpt = raas.apt_dat[icao]

			last_arpt = nil

			if db_arpt ~= nil then
				last_arpt = db_arpt
				last_arpt["TA"] = TA
				last_arpt["TL"] = TL
				last_arpt["lat"] = lat
				last_arpt["lon"] = lon
			end
		elseif line:find("R,", 1, true) == 1 and last_arpt ~= nil then
			local comps = string.split(line, ",")
			local rwy_id = comps[2]
			local telev = tonumber(comps[11])
			local gpa = tonumber(comps[12])
			local tch = tonumber(comps[13])

			for i, rwy in pairs(last_arpt["rwys"]) do
				if rwy["id1"] == rwy_id then
					rwy["gpa1"] = gpa
					rwy["tch1"] = tch
					rwy["te1"] = telev
				elseif rwy["id2"] == rwy_id then
					rwy["gpa2"] = gpa
					rwy["tch2"] = tch
					rwy["te2"] = telev
					break
				end
			end
		end
	end

	fp:close()
end

function raas.os_is_unix()
	return SYSTEM ~= "IBM"
end

function raas.create_directories(dirnames)
	local cmd, args = nil, ""

	for i, dirname in pairs(dirnames) do
		assert(dirname:find("\"", 1, true) == nil)
	end
	if raas.os_is_unix() then
		for i, dirname in pairs(dirnames) do
			args = args .. " \"" .. dirname .. "\""
		end
		cmd = "mkdir -p -- " .. args
		raas.dbg.log("file", 1, "executing: " .. cmd)
		assert(os.execute(cmd) == 0)
	else
		-- Because CMD.EXE on Windows is dumb as a sack of hammers,
		-- we need to feed it commands in 8191-character increments,
		-- because NOBODY would ever need more than 8191 characters
		-- on a line, right?
		for i, dirname in pairs(dirnames) do
			-- the 290 character reserve here is because CMD.EXE
			-- counts the hostname and current directory into
			-- its line length (?!)
			if #args + #dirname + 3 > 7900 then
				-- Unfuck any slashes into backslashes to deal
				-- with FlyWithLua's broken SCRIPT_DIRECTORY
				args = args:gsub("/", "\\")
				cmd = "mkdir " .. args
				raas.dbg.log("file", 1, "executing: " .. cmd)
				assert(os.execute(cmd) == 0)
				args = ""
			end
			args = args .. " \"" .. dirname .. "\""
		end
		if args ~= "" then
			args = args:gsub("/", "\\")
			cmd = "mkdir " .. args
			raas.dbg.log("file", 1, "executing: " .. cmd)
			assert(os.execute(cmd) == 0)
		end
	end
end

function raas.remove_directory(dirname)
	local cmd

	assert(dirname:find("..", 1, true) == nil)
	if raas.os_is_unix() then
		assert(dirname:find("/", 1, true) ~= 1 or #dirname > 1)
		cmd = "rm -rf -- \"" .. dirname .. "\""
	else
		dirname = dirname:gsub("/", "\\")
		assert(dirname:find("[a-zA-Z]:\\") ~= 1 or #dirname > 3)
		assert(dirname:find("[a-zA-Z]:\\[Ww][Ii][Nn][Dd][Oo][Ww][Ss]")
		    == nil)
		cmd = "rd /s /q \"" .. dirname .. "\""
	end

	raas.dbg.log("file", 1, "executing: " .. cmd)
	local res = os.execute(cmd)
end

function raas.apt_dat_cache_dir(lat, lon)
	local lat10 = math.floor(lat / 10) * 10
	local lon10 = math.floor(lon / 10) * 10
	return string.format("%s%s%s%03d%s%03d", SCRIPT_DIRECTORY,
	    "X-RAAS_apt_dat_cache", DIRSEP, lat10, "_", lon10)
end

function raas.write_apt_dat(icao, arpt)
	local rwys = arpt["rwys"]
	local elev, TA, TL, lat, lon = arpt["elev"], arpt["TA"], arpt["TL"],
	    arpt["lat"], arpt["lon"]

	assert(elev ~= nil and TA ~= nil and TL ~= nil and lat ~= nil and
	    lon ~= nil)

	local lat_idx, lon_idx = raas.geo_table_idx(lat, lon)
	if lat_idx == nil or lon_idx == nil then
		return
	end

	local fname = string.format("%s%s%03d_%03d",
	    raas.apt_dat_cache_dir(lat_idx, lon_idx), DIRSEP, lat_idx, lon_idx)
	local fp = io.open(fname, "a")
	assert(fp ~= nil)

	fp:write("1 " .. elev .. " 0 0 " .. icao .. " TA:" .. TA ..
	    " TL:" .. TL .. " LAT:" .. lat .. " LON:" .. lon .. "\n")
	for i, rwy in pairs(rwys) do
		local id1, lat1, lon1, dis1, bla1, gpa1, tch1, te1 =
		    rwy["id1"], rwy["lat1"], rwy["lon1"], rwy["dis1"],
		    rwy["bla1"], rwy["gpa1"], rwy["tch1"], rwy["te1"]
		local id2, lat2, lon2, dis2, bla2, gpa2, tch2, te2 =
		    rwy["id2"], rwy["lat2"], rwy["lon2"], rwy["dis2"],
		    rwy["bla2"], rwy["gpa2"], rwy["tch2"], rwy["te2"]
		assert(id1 ~= nil and lat1 ~= nil and lon1 ~= nil and
		    dis1 ~= nil and bla1 ~= nil and gpa1 ~= nil and
		    tch1 ~= nil and te1 ~= nil)
		assert(id2 ~= nil and lat2 ~= nil and lon2 ~= nil and
		    dis2 ~= nil and bla2 ~= nil and gpa2 ~= nil and
		    tch2 ~= nil and te2 ~= nil)

		fp:write("100 " .. rwy["w"] ..
		    " 1 0 0 0 0 0 " ..
		    id1 .. " " ..
		    lat1 .. " " ..
		    lon1 .. " " ..
		    dis1 .. " " ..
		    bla1 .. " 0 0 0 0 " ..
		    id2 .. " " ..
		    lat2 .. " " ..
		    lon2 .. " " ..
		    dis2 .. " " ..
		    bla2 ..
		    " GPA1:" .. gpa1 ..
		    " GPA2:" .. gpa2 ..
		    " TCH1:" .. tch1 ..
		    " TCH2:" .. tch2 ..
		    " TELEV1:" .. te1 ..
		    " TELEV2:" .. te2 ..
		    "\n")
	end
	fp:close()
end

-- Returns the file size of an apt.dat. The passed path must be relative
-- to the main X-Plane directory.
function raas.get_apt_dat_size(apt_dat)
	local fp = io.open(raas.const.xpdir .. apt_dat)
	if fp == nil then
		return nil
	end
	local sz = fp:seek("end")
	fp:close()
	return sz
end

-- Returns the AIRAC cycle number of the currently installed AIRAC database.
-- Returns `nil' if the AIRAC cycle is unknown.
function raas.get_airac_cycle()
	-- We first try the Custom Data version, as that's more up to date
	local filename = raas.const.xpdir .. "Custom Data" .. DIRSEP ..
	    "GNS430" .. DIRSEP .. "navdata" .. DIRSEP .. "Airports.txt"
	local fp = io.open(filename)

	if fp == nil then
		-- Try the Airports.txt shipped with X-Plane.
		filename = raas.const.xpdir .. "Resources" .. DIRSEP ..
		    "GNS430" .. DIRSEP .. "navdata" .. DIRSEP .. "Airports.txt"
		fp = io.open(filename)
		if fp == nil then
			logMsg("X-RAAS: missing Airports.txt, please check " ..
			    "your navdata and recreate the cache")
			return nil
		end
	end

	local first_line = fp:read("*line")
	if first_line == nil then
		logMsg("X-RAAS: truncated Airports.txt, please check " ..
		    "your navdata and recreate the cache")
		return nil
	end

	fp:close()
	local line_comps = first_line:split(",")
	if #line_comps < 5 or line_comps[1] ~= "X" then
		logMsg("X-RAAS: malformed first line in Airports.txt, " ..
		    "please check your navdata and recreate the cache")
		return nil
	end

	return tonumber(line_comps[2])
end

-- Checks if the airport data cache is up to date. We check the apt_dats
-- list to see if it is exactly the same as the airport sceneries that
-- are installed in the simulator and we also compare AIRAC cycles. We
-- perform one additional check for the default apt.dat file - we check
-- its file size to see if it has changed. We can't check any other apt.dat
-- files, as that takes too long.
-- Returns true If the cache is up to date, otherwise returns false.
function raas.apt_dat_cache_up_to_date()
	-- We check if our apt_dats list corresponds with the installed
	-- sceneries. Additions or removals are detected and the cache
	-- recreated. We also check the size of the default scenery apt.dat
	-- to see if it's changed.
	-- Finally, we check our airac cycle, as updates can cause the
	-- cache to become outdated.
	local filename = SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache" ..
	    DIRSEP .. "apt_dats"
	local fp = io.open(filename)

	if fp == nil then
		raas.dbg.log("tile", 1, "no apt_dats file in cache")
		return false
	end

	local cached_apt_dats = {}
	local real_apt_dats = raas.find_all_apt_dats(true)
	assert(real_apt_dats ~= nil)

	for line in fp:lines() do
		local space = line:find(" ", 1, true)
		if space == nil then
			break
		end
		cached_apt_dats[line:sub(space + 1)] =
		    tonumber(line:sub(1, space - 1))
	end

	for apt_dat, x in pairs(cached_apt_dats) do
		if real_apt_dats[apt_dat] == nil then
			raas.dbg.log("tile", 1, "removed apt_dat: " .. apt_dat)
			return false
		end
		-- Check the file size of the default apt dat, since that
		-- can change between X-Plane updates and changes A LOT of
		-- runway locations.
		-- Unfortunately, we can't check every apt.dat, since it's
		-- rather slow.
		if apt_dat:find("default apt dat", 1, true) ~= nil then
			if raas.get_apt_dat_size(apt_dat) ~=
			    cached_apt_dats[apt_dat] then
				raas.dbg.log("tile", 1,
				    "change in size of apt_dat: " .. apt_dat)
				return false
			end
		end
	end

	for apt_dat, x in pairs(real_apt_dats) do
		if cached_apt_dats[apt_dat] == nil then
			raas.dbg.log("tile", 1, "new apt_dat: " .. apt_dat)
			return false
		end
	end

	filename = SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache" ..
	    DIRSEP .. "airac_cycle"
	fp = io.open(filename)
	if fp == nil then
		raas.dbg.log("tile", 1, "missing airac_cycle file in cache")
		return false
	end
	local cached_airac_cycle = tonumber(fp:read("*all"))
	fp:close()
	local cur_airac_cycle = raas.get_airac_cycle()

	if cached_airac_cycle ~= cur_airac_cycle then
		raas.dbg.log("tile", 1, "AIRAC cycle changed")
		return false
	end

	return true
end

-- Writes a new apt_dats file into the airport data cache. Each line
-- in the file consists of two fields:
-- *) a file size, followed by a space
-- *) the apt.dat filename (relative to the X-Plane root directory)
function raas.write_apt_dats_file()
	local filename = SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache" ..
	    DIRSEP .. "apt_dats"
	local apt_dats_fp = io.open(filename, "w")
	local apt_dats = raas.find_all_apt_dats(false)

	for i, apt_dat in pairs(apt_dats) do
		local sz = raas.get_apt_dat_size(apt_dat)
		apt_dats_fp:write(tostring(sz) .. " " .. apt_dat .. "\n")
	end

	apt_dats_fp:close()
end

-- Writes a new airac_cycle file into the airport data cache. This is
-- just a simple number of the currently active AIRAC cycle.
function raas.write_airac_cycle_file()
	local filename = SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache" ..
	    DIRSEP .. "airac_cycle"
	local fp = io.open(filename, "w")
	fp:write(tostring(raas.get_airac_cycle()))
	fp:close()
end

-- Takes the current state of the raas.apt_dat table and writes all the airports
-- in it to the X-RAAS_apt_dat.cache so that a subsequent run of X-RAAS can
-- pick this info up.
function raas.recreate_apt_dat_cache()
	local version_filename = SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache" ..
	    DIRSEP .. "version"
	local version = nil
	local version_file = io.open(version_filename)

	if version_file ~= nil then
		version = tonumber(version_file:read("*all"))
		version_file:close()
	end

	if version == raas.const.XRAAS_apt_dat_cache_version and
	    raas.apt_dat_cache_up_to_date() then
		-- cache version current, no need to rebuild it
		raas.dbg.log("tile", 1, "X-RAAS_apt_dat_cache up to date")
		return
	end

	local apt_dat_files = raas.find_all_apt_dats(false)
	assert(apt_dat_files ~= nil)

	-- First scan all the provided apt.dat files
	for i = 1, #apt_dat_files do
		raas.map_apt_dat(raas.const.xpdir .. apt_dat_files[i])
	end
	for icao, arpt in pairs(raas.apt_dat) do
		if table.isempty(arpt["rwys"]) then
			raas.apt_dat[icao] = nil
		end
	end
	raas.load_airports_txt()

	raas.remove_directory(SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache")
	raas.create_directories({SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache"})
	version_file = io.open(version_filename, "w")
	version_file:write(tostring(raas.const.XRAAS_apt_dat_cache_version))
	version_file:close()

	raas.write_apt_dats_file()
	raas.write_airac_cycle_file()

	local dirs = {}
	local dir_set = {}
	for icao, arpt in pairs(raas.apt_dat) do
		local lat, lon = arpt["lat"], arpt["lon"]
		if lat ~= nil and lon ~= nil then
			dir_set[raas.apt_dat_cache_dir(lat, lon)] = true
		end
	end
	for dir, i in pairs(dir_set) do
		dirs[#dirs + 1] = dir
	end
	raas.create_directories(dirs)
	dir_set = nil
	dirs = nil

	for icao, arpt in pairs(raas.apt_dat) do
		if arpt["lat"] ~= nil then
			raas.write_apt_dat(icao, arpt)
		end
	end

	raas.apt_dat = {}
end

-- Scans the cached copy of X-RAAS_apt_dat.cache and if it doesn't exist,
-- recreates the cache from raw X-Plane navigational and scenery data.
function raas.map_apt_dats()
	raas.recreate_apt_dat_cache()
end

--[[
  The approach proximity bounding box is constructed as follows:

    5500 meters
    |<------->|
    |         |
  d +-_  (c1) |
    |   -._3 degrees
    |      -_ c
    |         +-------------------------------+
    |         | ====  ----         ----  ==== |
  x +   thr_v-+ ==== - ------> dir_v - - ==== |
    |         | ====  ----         ----  ==== |
    |         +-------------------------------+
    |      _- b
    |   _-.
  a +--    (b1)

  If there is another parallel runway, we make sure our bounding boxes
  don't overlap. We do this by introducing two additional points, b1 and
  c1, in between a and b or c and d respectively. We essentially shear
  the overlapping excess from the bounding polygon.
--]]
function raas.make_apch_prox_bbox(db_rwys, rwy_id, thr_v, width, dir_v, fpp)
	assert(db_rwys ~= nil)
	assert(rwy_id ~= nil)
	assert(thr_v ~= nil)
	assert(width ~= nil)
	assert(dir_v ~= nil)
	assert(fpp ~= nil)

	local x, a, b, b1, c, c1, d
	local bbox = {}
	local limit_left, limit_right = 1000000, 1000000
	local vect2 = raas.vect2

	x = vect2.add(thr_v, vect2.set_abs(vect2.neg(dir_v),
	    raas.const.RWY_APCH_PROXIMITY_LON_DISPL))
	a = vect2.add(x, vect2.set_abs(vect2.norm(dir_v, true),
	    width / 2 + raas.const.RWY_APCH_PROXIMITY_LAT_DISPL))
	b = vect2.add(thr_v, vect2.set_abs(vect2.norm(dir_v, true), width / 2))
	c = vect2.add(thr_v, vect2.set_abs(vect2.norm(dir_v, false), width / 2))
	d = vect2.add(x, vect2.set_abs(vect2.norm(dir_v, false),
	    width / 2 + raas.const.RWY_APCH_PROXIMITY_LAT_DISPL))

	-- If our rwy_id designator contains a L/C/R, then we need to
	-- look for another parallel runway
	if #rwy_id >= 3 then
		local num_id = rwy_id:sub(1, 2)
		local myhdg = vect2.dir2hdg(dir_v)

		for i, orwy in pairs(db_rwys) do
			if (orwy["id1"]:sub(1, 2) == num_id and
			    orwy["id1"] ~= rwy_id) or
			    (orwy["id2"]:sub(1, 2) == num_id and
			    orwy["id2"] ~= rwy_id) then
				-- this is a parallel runway, measure the
				-- distance to it from us
				local lat1, lon1 = orwy["lat1"], orwy["lon1"]
				assert(lat1 ~= nil and lon1 ~= nil)
				local othr_v = raas.fpp.sph2fpp({lat1, lon1},
				    fpp)
				local v = vect2.sub(othr_v, thr_v)
				local a = raas.rel_hdg(vect2.dir2hdg(dir_v),
				    vect2.dir2hdg(v))
				local dist = math.abs(math.sin(math.rad(a)) *
				    vect2.abs(v))

				if a < 0 then
					limit_left = math.min(dist / 2,
					    limit_left)
				else
					limit_right = math.min(dist / 2,
					    limit_right)
				end
			end
		end
	end

	if limit_left < raas.const.RWY_APCH_PROXIMITY_LAT_DISPL then
		c1 = vect2.vect_isect(vect2.sub(d, c), c, vect2.neg(dir_v),
		    vect2.add(thr_v, vect2.set_abs(vect2.norm(dir_v, false),
		    limit_left)), false)
		d = vect2.add(x, vect2.set_abs(vect2.norm(dir_v, false),
		    limit_left))
	end
	if limit_right < raas.const.RWY_APCH_PROXIMITY_LAT_DISPL then
		b1 = vect2.vect_isect(vect2.sub(b, a), a, vect2.neg(dir_v),
		    vect2.add(thr_v, vect2.set_abs(vect2.norm(dir_v, true),
		    limit_right)), false)
		a = vect2.add(x, vect2.set_abs(vect2.norm(dir_v, true),
		    limit_right))
	end

	bbox[#bbox + 1] = a
	if b1 then
		bbox[#bbox + 1] = b1
	end
	bbox[#bbox + 1] = b
	bbox[#bbox + 1] = c
	if c1 then
		bbox[#bbox + 1] = c1
	end
	bbox[#bbox + 1] = d

	return bbox
end

-- Given an airport ID and an airport flat plane transform, loads the
-- runway info stored in the raas.apt_dat database into a more easily workable
-- (but more verbose in terms of used memory) format. This function also
-- constructs the transformed threshold coordinates and bounding boxes.
function raas.load_rwy_info(arpt_id, fpp)
	assert(arpt_id ~= nil)
	assert(fpp ~= nil)

	local rwys = {}
	local db_arpt = raas.apt_dat[arpt_id]
	local db_rwys = db_arpt["rwys"]
	local vect2 = raas.vect2

	--[[
	 RAAS runway proximity entry bounding box is defined as:
	
	                 1000ft                                   1000ft
	               |<------>|                               |<------>|
	               |        |                               |        |
	        ---- d +-------------------------------------------------+ c
	    1.5x  ^    |        |                               |        |
	     rwy  |    |        |                               |        |
	    width |    |        +-------------------------------+        |
	          v    |        | ====  ----         ----  ==== |        |
	        -------|-thresh-x ==== - - - - - - - - - - ==== |        |
	          ^    |        | ====  ----         ----  ==== |        |
	    1.5x  |    |        +-------------------------------+        |
	     rwy  |    |                                                 |
	    width v    |                                                 |
	        ---- a +-------------------------------------------------+ b
	--]]

	for i, db_rwy in pairs(db_rwys) do
		local width = db_rwy["w"]
		local lat1, lon1, lat2, lon2 = db_rwy["lat1"], db_rwy["lon1"],
		    db_rwy["lat2"], db_rwy["lon2"]
		assert(lat1 ~= nil and lon1 ~= nil and lat2 ~= nil and
		    lon2 ~= nil)

		local dt1v = raas.fpp.sph2fpp({lat1, lon1}, fpp)
		local displ1 = db_rwy["dis1"]
		local blast1 = db_rwy["bla1"]
		assert(displ1 ~= nil and blast1 ~= nil)

		local dt2v = raas.fpp.sph2fpp({lat2, lon2}, fpp)
		local displ2 = db_rwy["dis2"]
		local blast2 = db_rwy["bla2"]
		assert(displ2 ~= nil and blast2 ~= nil)

		local dir_v = vect2.sub(dt2v, dt1v)
		local dlen = vect2.abs(dir_v)
		local hdg1 = vect2.dir2hdg(dir_v)
		local hdg2 = vect2.dir2hdg(vect2.neg(dir_v))

		local t1v = vect2.add(dt1v, vect2.set_abs(dir_v, displ1))
		local t2v = vect2.add(dt2v, vect2.set_abs(vect2.neg(dir_v),
		    displ2))
		local len = vect2.abs(vect2.sub(t2v, t1v))

		local rwy = shallowcopy(db_rwy)
		rwy["t1v"] = t1v
		rwy["t2v"] = t2v
		rwy["dt1v"] = dt1v
		rwy["dt2v"] = dt2v
		rwy["hdg1"] = hdg1
		rwy["hdg2"] = hdg2
		rwy["len"] = len
		rwy["dlen"] = dlen
		-- landing length, from t1v to dt2v and from t2v to dt1v
		rwy["llen1"] = vect2.abs(vect2.sub(dt2v, t1v))
		rwy["llen2"] = vect2.abs(vect2.sub(dt1v, t2v))

		rwy["rwy_bbox"] = raas.make_rwy_bbox(t1v, dir_v, width, len, 0)
		rwy["tora_bbox"] = raas.make_rwy_bbox(dt1v, dir_v, width,
		    dlen, 0)
		rwy["asda_bbox"] = raas.make_rwy_bbox(dt1v, dir_v, width,
		    dlen + blast2, blast1)

		local prox_lon_bonus1 = math.max(displ1,
		    raas.const.RWY_PROXIMITY_LON_DISPL - displ1)
		local prox_lon_bonus2 = math.max(displ2,
		    raas.const.RWY_PROXIMITY_LON_DISPL - displ2)

		rwy["prox_bbox"] = raas.make_rwy_bbox(t1v, dir_v,
		    raas.const.RWY_PROXIMITY_LAT_FRACT * width,
		    len + prox_lon_bonus2, prox_lon_bonus1)
		rwy["apch_prox_bbox1"] = raas.make_apch_prox_bbox(db_rwys,
		    db_rwy["id1"], t1v, width, dir_v, fpp)
		rwy["apch_prox_bbox2"] = raas.make_apch_prox_bbox(db_rwys,
		    db_rwy["id2"], t2v, width, vect2.neg(dir_v), fpp)

		rwys[#rwys + 1] = rwy
	end

	return rwys
end

-- Given an airport, loads the information of the airport into a more readily
-- workable (but more verbose) format. This function prepares a flat plane
-- transform centered on the airport's reference point and pre-computes all
-- relevant points for the airport in that space.
function raas.load_airport(arpt_id)
	assert(arpt_id ~= nil)
	local db_arpt = raas.apt_dat[arpt_id]
	local lat = db_arpt["lat"]
	local lon = db_arpt["lon"]
	assert(lat ~= nil and lon ~= nil)
	local fpp = raas.fpp.init_ortho({lat, lon}, 0)
	local ecef = raas.conv.sph2ecef({lat, lon})
	local arpt = {
	    ["arpt_id"] = arpt_id,
	    ["fpp"] = fpp,
	    ["rwys"] = raas.load_rwy_info(arpt_id, fpp),
	    ["lat"] = lat,
	    ["lon"] = lon,
	    ["ecef"] = ecef,
	    ["elev"] = db_arpt["elev"],
	    ["TA"] = db_arpt["TA"],
	    ["TL"] = db_arpt["TL"]
	}
	return arpt
end

-- The actual worker function for raas.find_nearest_airports. Performs the
-- search in a specified raas.airport_geo_table square. Position is a 3-space
-- ECEF vector.
function raas.find_nearest_airports_tile(pos, lat, lon, arpt_list)
	assert(pos ~= nil)
	assert(lat ~= nil)
	assert(lon ~= nil)
	assert(arpt_list ~= nil)

	local tile = raas.geo_table_get_tile(lat, lon, false)
	if tile == nil then
		return
	end

	for arpt_id, coords in pairs(tile) do
		local arpt_pos = raas.conv.sph2ecef(coords)
		if raas.vect3.abs(raas.vect3.sub(pos, arpt_pos)) <
		    raas.const.ARPT_LOAD_LIMIT then
			arpt_list[arpt_id] = coords
		end
	end
end

-- Locates all airports within an raas.const.ARPT_LOAD_LIMIT distance limit
-- (in meters) of a geographic reference position. The airports are searched
-- for in the raas.apt_dat database and this function returns a table of airport
-- IDs which matched the search.
function raas.find_nearest_airports(reflat, reflon)
	assert(reflat ~= nil)
	assert(reflon ~= nil)

	local pos = raas.conv.sph2ecef({reflat, reflon})
	local arpt_list = {}

	for i = -1, 1 do
		for j = -1, 1 do
			raas.find_nearest_airports_tile(pos, reflat + i,
			    reflon + j, arpt_list)
		end
	end

	return arpt_list
end

function raas.load_airports_in_tile(lat, lon)
	local tile, created = raas.geo_table_get_tile(lat, lon, true)
	lat, lon = raas.geo_table_idx(lat, lon)

	if created then
		raas.map_apt_dat(string.format("%s%s%03d_%03d",
		    raas.apt_dat_cache_dir(lat, lon), DIRSEP, lat, lon), false)
	end
end

function raas.unload_airports_in_tile(lat, lon)
	assert(raas.airport_geo_table[lat] ~= nil)
	local tile = raas.airport_geo_table[lat][lon]

	for icao, coords in pairs(tile) do
		raas.apt_dat[icao] = nil
	end
	raas.airport_geo_table[lat][lon] = nil
end

function raas.load_nearest_airport_tiles()
	local lat, lon = dr.lat[0], dr.lon[0]

	for i = -1, 1 do
		for j = -1, 1 do
			raas.load_airports_in_tile(lat + i, lon + j)
		end
	end
end

function raas.lon_delta(x, y)
	local u, d = math.max(x, y), math.min(x, y)
	if u - d <= 180 then
		return u - d
	else
		return (180 - u) - (-180 - d)
	end
end

function raas.unload_distant_airport_tiles()
	local lat, lon = raas.geo_table_idx(dr.lat[0], dr.lon[0])

	for lat_i, lat_tbl in pairs(raas.airport_geo_table) do
		for lon_i, lon_tbl in pairs(lat_tbl) do
			if lat_i < lat - 1 or lat_i > lat + 1 or
			    raas.lon_delta(lon_i, lon) > 1 then
				raas.dbg.log("tile", 1, "unloading tile " ..
				    lat_i .. " x " .. lon_i)
				raas.unload_airports_in_tile(lat_i, lon_i)
			end
		end
		if lat_i < lat - 1 or lat_i > lat + 1 then
			raas.dbg.log("tile", 1, "unloading lat " .. lat_i)
			raas.airport_geo_table[lat_i] = nil
		end
	end
end

-- Locates any airports within a 8 nm radius of the aircraft and loads
-- their RAAS data from the raas.apt_dat database. The function then updates
-- raas.cur_arpts with the new information and expunges airports that are no
-- longer in range.
function raas.load_nearest_airports()
	local now = os.time()
	if now - raas.last_airport_reload < raas.const.ARPT_RELOAD_INTVAL then
		return
	end
	raas.last_airport_reload = now

	raas.load_nearest_airport_tiles()
	raas.unload_distant_airport_tiles()
	local new_arpts = raas.find_nearest_airports(dr.lat[0], dr.lon[0])

	for arpt_id, arpt in pairs(raas.cur_arpts) do
		if new_arpts[arpt_id] == nil then
			raas.cur_arpts[arpt_id] = nil
		end
	end
	for arpt_id, coords in pairs(new_arpts) do
		if raas.cur_arpts[arpt_id] == nil then
			raas.cur_arpts[arpt_id] = raas.load_airport(arpt_id)
		end
	end
end

-- Computes the aircraft's on-ground velocity vector. The length of the
-- vector is computed as a `time_fact' (in seconds) extra ahead of the
-- actual aircraft's nosewheel position.
function raas.acf_vel_vector(time_fact)
	assert(time_fact ~= nil)
	return raas.vect2.set_abs(raas.vect2.hdg2dir(dr.hdg[0]),
	    time_fact * dr.gs[0] - dr.nw_offset[0])
end

-- Determines which of two ends of a runway is closer to the aircraft's
-- current position.
function raas.closest_rwy_end(pos, rwy)
	assert(pos ~= nil)
	assert(rwy ~= nil)

	if raas.vect2.abs(raas.vect2.sub(pos, rwy["dt1v"])) <
	    raas.vect2.abs(raas.vect2.sub(pos, rwy["dt2v"])) then
		return rwy["id1"]
	else
		return rwy["id2"]
	end
end

-- Translates a runway identifier into a suffix suitable for passing to
-- raas.play_msg for announcing whether the runway is left, center or right.
-- If no suffix is present, returns nil.
function raas.rwy_lcr_msg(str)
	assert(str ~= nil)

	local lcr
	if #str < 3 then
		return nil
	end
	lcr = str:sub(3, 3)
	if lcr == "L" then
		return "left"
	elseif lcr == "R" then
		return "right"
	elseif lcr == "C" then
		return "center"
	end
	return nil
end

-- Given a runway ID, appends appropriate messages suitable for raas.play_msg
-- to say it out loud.
function raas.rwy_id_to_msg(rwy_id, msg)
	assert(rwy_id ~= nil)
	assert(msg ~= nil)

	local first_digit = rwy_id:sub(1, 1)
	if first_digit ~= "0" or not RAAS_US_runway_numbers then
		msg[#msg + 1] = first_digit
	end
	msg[#msg + 1] = rwy_id:sub(2, 2)
	msg[#msg + 1] = raas.rwy_lcr_msg(rwy_id)
end

-- Converts a thousands value to the proper single-digit pronunciation
function raas.thousands_msg(thousands, msg)
	if thousands >= 10 then
		msg[#msg + 1] = tostring(thousands / 10)
		msg[#msg + 1] = tostring(thousands % 10)
	else
		msg[#msg + 1] = tostring(thousands)
	end
end

-- Given a distance in meters, converts it into a message suitable for
-- raas.play_msg based on the user's current imperial/metric settings.
function raas.dist_to_msg(dist, msg, div_by_100)
	assert(dist ~= nil)
	assert(msg ~= nil)

	if not div_by_100 then
		if RAAS_use_imperial then
			local dist_ft = dist * 3.281
			if dist_ft >= 1000 then
				local thousands = math.floor(dist_ft / 1000)
				raas.thousands_msg(thousands, msg)
				msg[#msg + 1] = "thousand"
			elseif dist_ft >= 500 then
				msg[#msg + 1] = "5"
				msg[#msg + 1] = "hundred"
			elseif dist_ft >= 100 then
				msg[#msg + 1] = "1"
				msg[#msg + 1] = "hundred"
			else
				msg[#msg + 1] = "0"
			end
		else
			local dist_300incr = math.floor(dist / 300) * 300
			local dist_thousands = math.floor(dist_300incr / 1000)
			local dist_hundreds = dist_300incr % 1000
			if dist_thousands > 0 and dist_hundreds > 0 then
				raas.thousands_msg(dist_thousands, msg)
				msg[#msg + 1] = "thousand"
				msg[#msg + 1] = tostring(dist_hundreds / 100)
				msg[#msg + 1] = "hundred"
			elseif dist_thousands > 0 then
				msg[#msg + 1] = tostring(dist_thousands)
				msg[#msg + 1] = "thousand"
			elseif dist >= 100 then
				if dist_hundreds > 0 then
					msg[#msg + 1] = tostring(math.floor(
					    dist_hundreds / 100))
					msg[#msg + 1] = "hundred"
				else
					msg[#msg + 1] = "1"
					msg[#msg + 1] = "hundred"
				end
			elseif dist >= 30 then
				msg[#msg + 1] = "30"
			else
				msg[#msg + 1] = "0"
			end
		end
	else
		local thousands, hundreds
		if RAAS_use_imperial then
			local dist_ft = dist * 3.281
			thousands = math.floor(dist_ft / 1000)
			hundreds = math.floor((dist_ft % 1000) / 100)
		else
			thousands = math.floor(dist / 1000)
			hundreds = math.floor((dist % 1000) / 100)
		end
		if thousands ~= 0 then
			raas.thousands_msg(thousands, msg)
			msg[#msg + 1] = "thousand"
		end
		if hundreds ~= 0 then
			msg[#msg + 1] = tostring(hundreds)
			msg[#msg + 1] = "hundred"
		end
		if thousands == 0 and hundreds == 0 then
			msg[#msg + 1] = "0"
		end
	end

	local now = os.clock()

	if now - raas.last_units_call > raas.const.UNITS_APPEND_INTVAL and
	    RAAS_speak_units then
		if RAAS_use_imperial then
			msg[#msg + 1] = "feet"
		else
			msg[#msg + 1] = "meters"
		end
	end
	raas.last_units_call = now

	return true
end

function raas.do_approaching_rwy(arpt_id, rwy_id, rwy_name, rwy_len, on_ground)
	if (on_ground and (raas.apch_rwy_ann[arpt_id .. rwy_id] ~= nil or
	    raas.on_rwy_ann[arpt_id .. rwy_id])) or
	    (not on_ground and raas.air_apch_rwy_ann[arpt_id .. rwy_id] ~= nil) then
		return
	end

	if not on_ground or dr.gs[0] < raas.const.SPEED_THRESH then
		local msg, msg_prio, force_ann
		local annunciated_rwys = false

		if (on_ground and raas.apch_rwys_ann) or
		    (not on_ground and raas.air_apch_rwys_ann) then
			return
		end

		-- Multiple runways being approached?
		if (on_ground and not table.isempty(raas.apch_rwy_ann)) or
		    (not on_ground and not table.isempty(raas.air_apch_rwy_ann)) then
			if on_ground then
				-- On the ground we don't want to re-annunciate
				-- "approaching" once the runway is resolved
				raas.apch_rwy_ann[arpt_id .. rwy_id] = true
			else
				-- In the air, we DO want to re-annunciate
				-- "approaching" once the runway is resolved
				raas.air_apch_rwy_ann = {}
			end
			-- If the "approaching ..." annunciation for the
			-- previous runway is still playing, try to modify
			-- it to say "approaching runways"
			if raas.cur_msg["msg"] ~= nil and
			    raas.cur_msg["msg"][1] == "apch" and
			    raas.cur_msg["playing"] <= 1 then
				raas.cur_msg["msg"] = {"apch", "rwys"}
				raas.cur_msg["prio"] = raas.const.MSG_PRIO_MED
				annunciated_rwys = true
				raas.ND_alert(raas.const.ND_ALERT_APP,
				    raas.const.ND_ALERT_ROUTINE, "37")
			end
			if on_ground then
				raas.apch_rwys_ann = true
			else
				raas.air_apch_rwys_ann = true
			end
			if annunciated_rwys then
				return
			end
		end

		if (on_ground and not raas.apch_rwys_ann) or
		    (not on_ground and not raas.air_apch_rwys_ann) or
		    not annunciated_rwys then
			local dist_ND = nil
			local level = raas.const.ND_ALERT_ROUTINE

			msg = {"apch"}
			raas.rwy_id_to_msg(rwy_name, msg)
			msg_prio = raas.const.MSG_PRIO_LOW

			if not on_ground and rwy_len < RAAS_min_landing_dist
			    then
				raas.dist_to_msg(rwy_len, msg, true)
				msg[#msg + 1] = "avail"
				msg_prio = raas.const.MSG_PRIO_HIGH
				dist_ND = rwy_len
				level = raas.const.ND_ALERT_NONROUTINE
			end

			raas.play_msg(msg, msg_prio)
			raas.ND_alert(raas.const.ND_ALERT_APP, level,
			    rwy_name, dist_ND)
		end
	end

	if on_ground then
		raas.apch_rwy_ann[arpt_id .. rwy_id] = true
	else
		raas.air_apch_rwy_ann[arpt_id .. rwy_id] = true
	end
end

function raas.ground_runway_approach_arpt_rwy(arpt, rwy_id, rwy, pos_v,
    vel_v)
	assert(arpt ~= nil)
	assert(rwy_id ~= nil)
	assert(rwy ~= nil)
	assert(pos_v ~= nil)
	assert(vel_v ~= nil)

	local prox_bbox = rwy["prox_bbox"]
	local arpt_id = arpt["arpt_id"]

	if raas.vect2.in_poly(pos_v, prox_bbox) or
	    not table.isempty(raas.vect2.poly_isect(vel_v, pos_v, prox_bbox))
	    then
		raas.do_approaching_rwy(arpt_id, rwy_id,
		    raas.closest_rwy_end(pos_v, rwy), 0, true)
		return true
	else
		raas.apch_rwy_ann[arpt_id .. rwy_id] = nil
		return false
	end
end

function raas.ground_runway_approach_arpt(arpt, vel_v)
	assert(arpt ~= nil)
	assert(vel_v ~= nil)

	local fpp = arpt["fpp"]
	local pos_v = raas.fpp.sph2fpp({dr.lat[0], dr.lon[0]}, arpt["fpp"])
	local in_prox = 0

	for i, rwy in pairs(arpt["rwys"]) do
		local rwy_id = rwy["id1"]
		if raas.ground_runway_approach_arpt_rwy(arpt, rwy_id, rwy,
		    pos_v, vel_v) then
			in_prox = in_prox + 1
		end
	end

	return in_prox
end

function raas.ground_runway_approach()
	local in_prox = 0

	if dr.rad_alt[0] < raas.const.RADALT_FLARE_THRESH then
		local vel_v = raas.acf_vel_vector(
		    raas.const.RWY_PROXIMITY_TIME_FACT)
		for arpt_id, arpt in pairs(raas.cur_arpts) do
			in_prox = in_prox + raas.ground_runway_approach_arpt(
			    arpt, vel_v)
		end
	end

	if in_prox == 0 then
		if raas.landing then
			raas.dbg.log("flt_state", 1, "raas.landing = false")
		end
		raas.landing = false
	end
	if in_prox <= 1 then
		raas.apch_rwys_ann = false
	end
end

function raas.perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v, no_flap_check,
    non_routine)
	assert(rwy_id ~= nil)
	assert(no_flap_check ~= nil)
	assert(non_routine ~= nil)

	local msg = {"on_rwy"}
	local dist
	local flaprqst = dr.flaprqst[0]
	local dist_ND = nil
	local allow_on_rwy_ND_alert = true
	local level = raas.const.ND_ALERT_ROUTINE

	if non_routine then
		level = raas.const.ND_ALERT_NONROUTINE
	end

	if pos_v ~= nil and opp_thr_v ~= nil then
		dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	else
		dist = 10000000
	end

	raas.rwy_id_to_msg(rwy_id, msg)
	if dist < RAAS_min_takeoff_dist and not raas.landing then
		-- This nesting is needed to avoid dist_to_msg resetting
		-- the units callout time in case we end up not using this
		-- callout due to the conditions above.
		if raas.dist_to_msg(dist, msg, true) then
			dist_ND = dist
			level = raas.const.ND_ALERT_NONROUTINE
			msg[#msg + 1] = "rmng"
		end
	end

	if (flaprqst < RAAS_min_takeoff_flap or
	    flaprqst > RAAS_max_takeoff_flap) and not raas.landing and
	    not raas.gpws_flaps_ovrd() and not no_flap_check then
		msg[#msg + 1] = "flaps"
		msg[#msg + 1] = "flaps"

		allow_on_rwy_ND_alert = false
		raas.ND_alert(raas.const.ND_ALERT_FLAPS,
		    raas.const.ND_ALERT_CAUTION)
	end

	raas.play_msg(msg, raas.const.MSG_PRIO_HIGH)
	if allow_on_rwy_ND_alert then
		raas.ND_alert(raas.const.ND_ALERT_ON, level, rwy_id,
		    dist_ND)
	end
end

function raas.on_rwy_check(arpt_id, rwy_id, hdg, rwy_hdg, pos_v, opp_thr_v)
	assert(arpt_id ~= nil)
	assert(rwy_id ~= nil)
	assert(hdg ~= nil)
	assert(rwy_hdg ~= nil)
	assert(pos_v ~= nil)
	assert(opp_thr_v ~= nil)

	local now = os.time()
	local rhdg = math.abs(raas.rel_hdg(hdg, rwy_hdg))

	-- If we are not at all on the appropriate runway heading, don't
	-- generate any annunciations
	if rhdg >= 90 then
		-- reset the annunciation if the aircraft turns around fully
		if raas.on_rwy_ann[arpt_id .. rwy_id] ~= nil then
			raas.dbg.log("ann_state", 1, "raas.on_rwy_ann[" ..
			    arpt_id .. rwy_id .. "] = nil")
			raas.on_rwy_ann[arpt_id .. rwy_id] = nil
		end
		return
	end

	if raas.on_rwy_timer ~= -1 and raas.rejected_takeoff == nil and
	    ((now - raas.on_rwy_timer > RAAS_on_rwy_warn_initial and
	    raas.on_rwy_warnings == 0) or
	    (now - raas.on_rwy_timer - RAAS_on_rwy_warn_initial >
	    raas.on_rwy_warnings * RAAS_on_rwy_warn_repeat)) and
	    raas.on_rwy_warnings < RAAS_on_rwy_warn_max_n then
		raas.on_rwy_warnings = raas.on_rwy_warnings + 1
		raas.perform_on_rwy_ann(rwy_id, nil, nil, true, true)
		raas.perform_on_rwy_ann(rwy_id, nil, nil, true, true)
	end

	if rhdg > raas.const.HDG_ALIGN_THRESH then
		return
	end

	if raas.on_rwy_ann[arpt_id .. rwy_id] == nil then
		if dr.gs[0] < raas.const.SPEED_THRESH then
			raas.perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v,
			    raas.rejected_takeoff ~= nil, false)
		end
		raas.dbg.log("ann_state", 1, "raas.on_rwy_ann[" .. arpt_id ..
		    rwy_id .. "] = true")
		raas.on_rwy_ann[arpt_id .. rwy_id] = true
	end
end

function raas.stop_check_reset(arpt_id, rwy_id)
	assert(arpt_id ~= nil)
	assert(rwy_id ~= nil)

	if raas.accel_stop_max_spd[arpt_id .. rwy_id] ~= nil then
		raas.accel_stop_max_spd[arpt_id .. rwy_id] = nil
		raas.accel_stop_ann_initial = 0
		for i, info in pairs(RAAS_accel_stop_distances) do
			info["ann"] = false
		end
	end
end

function raas.takeoff_rwy_dist_check(opp_thr_v, pos_v)
	assert(opp_thr_v ~= nil)
	assert(pos_v ~= nil)

	if raas.short_rwy_takeoff_chk then
		return
	end

	local dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	raas.short_rwy_takeoff_chk = true
	if dist < RAAS_min_takeoff_dist then
		raas.play_msg({"caution", "short_rwy", "short_rwy"},
		    raas.const.MSG_PRIO_HIGH)
		raas.ND_alert(raas.const.ND_ALERT_SHORT_RWY,
		    raas.const.ND_ALERT_CAUTION)
	end
end

function raas.perform_rwy_dist_remaining_callouts(opp_thr_v, pos_v, prepend)
	assert(opp_thr_v ~= nil)
	assert(pos_v ~= nil)

	local dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	local theinfo = nil
	local maxdelta = 1000000
	local msg = {}

	for i, info in pairs(RAAS_accel_stop_distances) do
		local min = info["min"]
		local max = info["max"]

		if dist > min and dist < max then
			theinfo = info
			break
		end
		if prepend ~= nil and dist > min and dist - min < maxdelta then
			theinfo = info
			maxdelta = dist - min
		end
	end

	assert(prepend == nil or theinfo ~= nil)

	if theinfo == nil or theinfo["ann"] == true then
		return
	end

	if prepend ~= nil then
		msg = prepend
	end

	theinfo["ann"] = true

	if raas.dist_to_msg(dist, msg, false) then
		msg[#msg + 1] = "rmng"
		raas.play_msg(msg, raas.const.MSG_PRIO_MED)
	end
end

function raas.acf_rwy_rel_pitch(te, ote, len)
	assert(te ~= nil)
	assert(ote ~= nil)
	assert(len ~= nil)

	local rwy_angle = math.deg(math.asin((ote - te) / len))
	return dr.pitch[0] - rwy_angle
end

-- Checks if at the current rate of deceleration, we are going to come to
-- a complete stop before traveling `dist_rmng' (in meters). Returns true
-- if we are going to stop before that, false otherwise.
function raas.decel_check(dist_rmng)
	local cur_gs = dr.gs[0]
	local decel_rate = (cur_gs - raas.last_gs) / raas.const.EXEC_INTVAL
	if decel_rate >= 0 then
		return false
	end
	local t = cur_gs / (-decel_rate)
	local d = cur_gs * t + 0.5 * decel_rate * t * t
	return d < dist_rmng
end

function raas.stop_check(arpt_id, rwy, suffix, hdg, pos_v)
	assert(arpt_id ~= nil)
	assert(rwy ~= nil)
	assert(suffix ~= nil)
	assert(hdg ~= nil)
	assert(pos_v ~= nil)

	local osuffix
	if suffix == "1" then
		osuffix = "2"
	else
		osuffix = "1"
	end
	local rwy_id = rwy["id" .. suffix]
	local opp_thr_v = rwy["dt" .. osuffix .. "v"]
	local rwy_hdg = rwy["hdg" .. suffix]
	local len = rwy["llen" .. suffix]
	local te, ote = rwy["te" .. suffix], rwy["te" .. osuffix]

	local gs = dr.gs[0]
	local maxspd
	local dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	local rhdg = math.abs(raas.rel_hdg(hdg, rwy_hdg))

	if gs < raas.const.SPEED_THRESH then
		-- If there's very little runway remaining, we always want to
		-- call that fact out
		if dist < raas.const.IMMEDIATE_STOP_DIST and
		    rhdg < raas.const.HDG_ALIGN_THRESH and
		    gs > raas.const.SLOW_ROLL_THRESH then
			raas.perform_rwy_dist_remaining_callouts(opp_thr_v,
			    pos_v)
		else
			raas.stop_check_reset(arpt_id, rwy_id)
		end
		return
	end

	if rhdg > raas.const.HDG_ALIGN_THRESH then
		return
	end

	if dr.rad_alt[0] > raas.const.RADALT_GRD_THRESH then
		raas.stop_check_reset(arpt_id, rwy_id)
		local clb_rate = raas.conv_per_min(raas.m2ft(dr.elev[0] -
		    raas.last_elev))
		if raas.departed and
		    dr.rad_alt[0] <= raas.const.RADALT_DEPART_THRESH and
		    clb_rate < raas.const.GOAROUND_CLB_RATE_THRESH then
			-- Our distance limit is the greater of either:
			-- 1) the greater of:
			--	a) runway length minus 2000 feet
			--	a) 3/4 the runway length
			-- 2) the lesser of:
			--	a) minimum safe landing distance
			--	b) full runway length
			local dist_lim = math.max(math.max(
			    len - RAAS_long_land_lim_abs,
			    len * (1 - RAAS_long_land_lim_fract)),
			    math.min(len, RAAS_min_landing_dist))
			if dist < dist_lim then
				if not raas.long_landing_ann then
					raas.play_msg({"long_land",
					    "long_land"},
					    raas.const.MSG_PRIO_HIGH)
					raas.dbg.log("ann_state", 1,
					    "raas.long_landing_ann = true")
					raas.long_landing_ann = true
					raas.ND_alert(
					    raas.const.ND_ALERT_LONG_LAND,
					    raas.const.ND_ALERT_CAUTION)
				end
				raas.perform_rwy_dist_remaining_callouts(
				    opp_thr_v, pos_v, nil)
			end
		end
		return
	end

	if not raas.arriving then
		raas.takeoff_rwy_dist_check(opp_thr_v, pos_v)
	end

	maxspd = raas.accel_stop_max_spd[arpt_id .. rwy_id]
	if maxspd == nil or gs > maxspd then
		raas.accel_stop_max_spd[arpt_id .. rwy_id] = gs
		maxspd = gs
	end
	if not raas.landing and gs < maxspd - raas.const.ACCEL_STOP_SPD_THRESH
	    then
		raas.rejected_takeoff = rwy_id
	end
	local rpitch = raas.acf_rwy_rel_pitch(te, ote, rwy["len"])
	-- We want to perform distance remaining callouts if:
	-- 1) we are NOT landing and speed has decayed below the rejected
	--    takeoff threshold, or
	-- 2) we ARE landing, distance remaining is below the stop readout
	--    cutoff and our deceleration is insufficient to stop within the
	--    remaining distance, or
	-- 3) we are NOT landing, distance remaining is below the rotation
	--    threshold and our pitch angle to the runway indicates that
	--    rotation has not yet been initiated.

	if raas.rejected_takeoff == rwy_id or (raas.landing and
	    dist < RAAS_stop_dist_cutoff and not raas.decel_check(dist)) or
	    (not raas.landing and dist < RAAS_min_rotation_dist and
	    dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH and
	    rpitch < RAAS_min_rotation_angle) then
		raas.perform_rwy_dist_remaining_callouts(opp_thr_v, pos_v)
	end
end

function raas.ground_on_runway_aligned_arpt(arpt)
	assert(arpt ~= nil)

	local on_rwy = false
	local pos_v = raas.vect2.add(raas.fpp.sph2fpp({dr.lat[0], dr.lon[0]},
	    arpt["fpp"]), raas.acf_vel_vector(
	    raas.const.LANDING_ROLLOUT_TIME_FACT))
	local arpt_id = arpt["arpt_id"]
	local hdg = dr.hdg[0]
	local airborne = dr.rad_alt[0] > raas.const.RADALT_GRD_THRESH

	for i, rwy in pairs(arpt["rwys"]) do
		local rwy_id = rwy["id1"]
		if not airborne and raas.vect2.in_poly(pos_v, rwy["tora_bbox"])
		    then
			on_rwy = true
			raas.on_rwy_check(arpt_id, rwy["id1"], hdg, rwy["hdg1"],
			    pos_v, rwy["dt2v"])
			raas.on_rwy_check(arpt_id, rwy["id2"], hdg, rwy["hdg2"],
			    pos_v, rwy["dt1v"])
		else
			if raas.on_rwy_ann[arpt_id .. rwy["id1"]] ~= nil then
				raas.dbg.log("ann_state", 1, "raas.on_rwy_ann[" ..
				    arpt_id .. rwy["id1"] .. "] = nil")
				raas.on_rwy_ann[arpt_id .. rwy["id1"]] = nil
			end
			if raas.on_rwy_ann[arpt_id .. rwy["id2"]] ~= nil then
				raas.dbg.log("ann_state", 1, "raas.on_rwy_ann[" ..
				    arpt_id .. rwy["id2"] .. "] = nil")
				raas.on_rwy_ann[arpt_id .. rwy["id2"]] = nil
			end
			if raas.rejected_takeoff == rwy["id1"] or
			    raas.rejected_takeoff == rwy["id2"] then
				raas.dbg.log("ann_state", 1,
				    "raas.rejected_takeoff = nil")
				raas.rejected_takeoff = nil
			end
		end
		if raas.vect2.in_poly(pos_v, rwy["asda_bbox"]) then
			raas.stop_check(arpt_id, rwy, "1", hdg, pos_v)
			raas.stop_check(arpt_id, rwy, "2", hdg, pos_v)
		else
			raas.stop_check_reset(arpt_id, rwy["id1"])
			raas.stop_check_reset(arpt_id, rwy["id2"])
		end
	end

	return on_rwy
end

function raas.ground_on_runway_aligned()
	local on_rwy = false

	if dr.rad_alt[0] < raas.const.RADALT_DEPART_THRESH then
		for arpt_id, arpt in pairs(raas.cur_arpts) do
			if raas.ground_on_runway_aligned_arpt(arpt) then
				on_rwy = true
			end
		end
	end

	if on_rwy and dr.gs[0] < raas.const.STOPPED_THRESH then
		if raas.on_rwy_timer == -1 then
			raas.on_rwy_timer = os.time()
		end
	else
		raas.on_rwy_timer = -1
		raas.on_rwy_warnings = 0
	end

	if not on_rwy then
		raas.short_rwy_takeoff_chk = false
		raas.rejected_takeoff = nil
	end

	-- Taxiway takeoff check
	if not on_rwy and dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH and
	    ((not raas.landing and dr.gs[0] >= raas.const.SPEED_THRESH) or
	    (raas.landing and dr.gs[0] >= raas.const.HIGH_SPEED_THRESH)) then
		if not raas.on_twy_ann then
			raas.on_twy_ann = true
			raas.play_msg({"caution", "on_twy", "on_twy"},
			    raas.const.MSG_PRIO_HIGH)
			raas.ND_alert(raas.const.ND_ALERT_ON,
			    raas.const.ND_ALERT_CAUTION, "")
		end
	elseif dr.gs[0] < raas.const.SPEED_THRESH or
	    dr.rad_alt[0] >= raas.const.RADALT_GRD_THRESH then
		raas.on_twy_ann = false
	end

	return on_rwy
end

-- Computes the glide path angle limit based on the optimal glide path angle
-- for the runway (rwy_gpa) and aircraft distance from the runway threshold
-- (dist_from_thr in meters). Returns the limiting glide path angle in
-- degrees or 90 if the aircraft is outside of the glide path angle
-- protection envelope
function raas.gpa_limit(rwy_gpa, dist_from_thr)
	assert(rwy_gpa ~= nil)
	assert(dist_from_thr ~= nil)

	-- These are the linear GPA multiplier segments:
	-- "min" is the minimum distance from the threshold (in meters)
	-- "max" is the maximum distance from the threshold (in meters)
	-- "f1" is the multiplier applied at the "min" distance point
	-- "f2" is the multiplier applied at the "max" distance point
	local gpa_factors = {
	    { ["min"] = 463, ["max"] = 926, ["f1"] = 2, ["f2"] = 1.62 },
	    { ["min"] = 926, ["max"] = 1389, ["f1"] = 1.62, ["f2"] = 1.5 },
	    { ["min"] = 1389, ["max"] = 2315, ["f1"] = 1.5, ["f2"] = 1.4 },
	    { ["min"] = 2315, ["max"] = 4167, ["f1"] = 1.4, ["f2"] = 1.33 }
	}

	-- Select the appropriate range from the gpa_factors table
	for i, factor in pairs(gpa_factors) do
		if dist_from_thr >= factor["min"] and
		    dist_from_thr < factor["max"] then
			-- Compute the multiplier as a linear interpolation
			-- between f1 and f2 depending on aircraft relative
			-- position along factor["min"] and factor["max"]
			local mult = factor["f1"] +
			    ((dist_from_thr - factor["min"]) /
			    (factor["max"] - factor["min"])) *
			    (factor["f2"] - factor["f1"])
			return math.min(math.min(RAAS_gpa_limit_mult, mult) *
			    rwy_gpa, RAAS_gpa_limit_max)
		end
	end

	return 90
end

-- Gets the landing speed selected in the FMC. This function returns two
-- values:
--	*) The landing speed (a number).
--	*) A boolean indicating if the landing speed return is a reference
--	   speed (wind margin is NOT taken into account) or an approach
--	   speed (wind margin IS taken into account). Boeing aircraft tend
--	   to use Vref, whereas Airbus aircraft tend to use Vapp (V_LS).
-- The functionality of this depends on the exact aircraft model loaded
-- and whether it exposes the landing speed to us. If the aircraft doesn't
-- support exposing the landing speed or the landing speed is not yet
-- selected in the FMC, this function returns two nil values instead.
function raas.get_land_spd()
	-- FlightFactor 777
	if raas.chk_acf_dr({"B772", "B773", "B77L", "B77W"},
	    "T7Avionics/fms/vref") then
		local val = dataref_table("T7Avionics/fms/vref")[0]
		if val < 100 then
			return nil, nil
		end
		return val, true
	-- JARDesigns A320 & A330
	elseif raas.chk_acf_dr({"A318", "A319", "A320", "A321",
	    "A322", "A333", "A338", "A339"}, "sim/custom/xap/pfd/vappr_knots")
	    then
		-- First try the Vapp, otherwise fall back to Vref
		local val = dataref_table("sim/custom/xap/pfd/vappr_knots")[0]
		if val > 100 then
			return val, false
		end
		val = dataref_table("sim/custom/xap/pfd/vref_knots")[0]
		if val > 100 then
			return val, true
		end
		return nil, nil
	end
	return nil, nil
end

-- Computes the approach speed limit. The approach speed limit is computed
-- relative to the landing speed selected in the FMC with an extra added on
-- top based on our height above the runway threshold:
-- 1) If the aircraft is outside the approach speed limit protection envelope
--	(below 300 feet or above 950 feet above runway elevation), this
--	function returns a very high speed value to guarantee that any
--	comparison with the actual airspeed will indicate "in range".
-- 2) If the FMC doesn't expose landing speed information, or the information
--	has not yet been entered, this function again returns a very high
--	spped limit value.
-- 3) If the FMC exposes landing speed information and the information has
--	been set, the computed margin value is:
--	a) if the landing speed is based on the reference landing speed (Vref),
--	   +30 knots between 300 and 500 feet, and between 500 and 950
--	   increasing linearly from +30 knots at 500 feet to +40 knots at
--	   950 feet.
--	b) if the landing speed is based on the approach landing speed (Vapp),
--	   +15 knots between 300 and 500 feet, and between 500 and 950
--	   increasing linearly from +15 knots at 500 feet to +40 knots at
--	   950 feet.
function raas.apch_spd_limit(height_abv_thr)
	local spd_factors
	local spd_margin = 10000
	local land_spd, spd_is_ref = raas.get_land_spd()

	-- If the landing speed is unknown, just return a huge number so
	-- we will always be under this speed
	if land_spd == nil then
		logMsg("land speed unknown")
		return 10000
	end

	if spd_is_ref then
		-- If the landing speed is a reference speed (Vref), we allow
		-- up to 30 knots above Vref for approach speed margin when low
		spd_factors = {
		    -- "min" and "max" are feet above threshold elevation
		    -- "f1" and "f2" are indicated airspeed values in knots
		    { ["min"] = 300, ["max"] = 500,
			["f1"] = 30, ["f2"] = 30 },
		    { ["min"] = 500, ["max"] = 950,
			["f1"] = 30, ["f2"] = 40 },
		}
	else
		-- If the landing speed is an approach speed (Vapp), we use
		-- a more restrictive speed margin value of 15 knots when low
		spd_factors = {
		    { ["min"] = 300, ["max"] = 500,
			["f1"] = 15, ["f2"] = 15 },
		    { ["min"] = 500, ["max"] = 950,
			["f1"] = 15, ["f2"] = 40 },
		}
	end

	-- Select the appropriate range from the spd_factors table
	for i, factor in pairs(spd_factors) do
		if height_abv_thr >= factor["min"] and
		    height_abv_thr < factor["max"] then
			-- Compute the speed limit as a linear interpolation
			-- between f1 and f2 depending on aircraft relative
			-- position along factor["min"] and factor["max"]
			spd_margin = factor["f1"] +
			    ((height_abv_thr - factor["min"]) /
			    (factor["max"] - factor["min"])) *
			    (factor["f2"] - factor["f1"])
			break
		end
	end

	-- If no segment above matched, we don't perform approach speed
	-- checks, so spd_margin is set to a high value to guarantee we'll
	-- always fit within limits
	return land_spd + spd_margin
end

function raas.apch_config_chk(arpt_id, rwy_id, height_abv_thr, gpa_act,
    rwy_gpa, ceil, floor, msg, flap_ann_table, gpa_ann_table, spd_ann_table,
    critical, add_pause, dist_from_thr, check_gear)
	assert(arpt_id ~= nil)
	assert(rwy_id ~= nil)
	assert(height_abv_thr ~= nil)
	assert(gpa_act ~= nil)
	assert(rwy_gpa ~= nil)
	assert(ceil ~= nil)
	assert(floor ~= nil)
	assert(msg ~= nil)
	assert(flap_ann_table ~= nil)
	assert(gpa_ann_table ~= nil)
	assert(spd_ann_table ~= nil)
	assert(critical ~= nil)
	assert(add_pause ~= nil)
	assert(dist_from_thr ~= nil)
	assert(check_gear ~= nil)

	local clb_rate = raas.conv_per_min(raas.m2ft(dr.elev[0] -
	    raas.last_elev))

	if height_abv_thr < ceil and height_abv_thr > floor and
	    (not raas.gear_is_up() or not check_gear) and
	    clb_rate < raas.const.GOAROUND_CLB_RATE_THRESH then
		raas.dbg.log("apch_conf_igchk", 2, "check at " .. ceil ..
		    "/" .. floor)
		raas.dbg.log("apch_config_chk", 2, "gpa_act = " .. gpa_act ..
		    " rwy_gpa = " .. rwy_gpa)
		if not flap_ann_table[arpt_id .. rwy_id] and
		    dr.flaprqst[0] < RAAS_min_landing_flap then
			raas.dbg.log("apch_config_chk", 1, "FLAPS: " ..
			    "flaprqst = " .. dr.flaprqst[0] ..
			    " min_flap = " .. RAAS_min_landing_flap)
			if raas.gpws_flaps_ovrd() then
				raas.dbg.log("apch_config_chk", 1,
				    "FLAPS: " .. "flaps ovrd active")
			else
				if not critical then
					msg[#msg + 1] = "flaps"
					if add_pause then
						msg[#msg + 1] = "pause"
					end
					msg[#msg + 1] = "flaps"
					raas.ND_alert(raas.const.ND_ALERT_FLAPS,
					    raas.const.ND_ALERT_CAUTION)
				else
					msg[#msg + 1] = "unstable"
					msg[#msg + 1] = "unstable"
					raas.ND_alert(
					    raas.const.ND_ALERT_UNSTABLE,
					    raas.const.ND_ALERT_CAUTION)
				end
			end
			flap_ann_table[arpt_id .. rwy_id] = true
			return true
		elseif not gpa_ann_table[arpt_id .. rwy_id] and rwy_gpa ~= 0 and
		    gpa_act > raas.gpa_limit(rwy_gpa, dist_from_thr) then
			raas.dbg.log("apch_config_chk", 1, "TOO HIGH: " ..
			    "gpa_act = " .. gpa_act ..
			    " gpa_limit=" .. raas.gpa_limit(rwy_gpa,
			    dist_from_thr))
			if raas.gpws_terr_ovrd() then
				raas.dbg.log("apch_config_chk", 1,
				    "TOO HIGH: " .. "terr ovrd active")
			else
				if not critical then
					msg[#msg + 1] = "too_high"
					if add_pause then
						msg[#msg + 1] = "pause"
					end
					msg[#msg + 1] = "too_high"
					raas.ND_alert(
					    raas.const.ND_ALERT_TOO_HIGH,
					    raas.const.ND_ALERT_CAUTION)
				else
					msg[#msg + 1] = "unstable"
					msg[#msg + 1] = "unstable"
					raas.ND_alert(
					    raas.const.ND_ALERT_UNSTABLE,
					    raas.const.ND_ALERT_CAUTION)
				end
			end
			gpa_ann_table[arpt_id .. rwy_id] = true
			return true
		elseif not spd_ann_table[arpt_id .. rwy_id] and
		    RAAS_too_fast_enabled and
		    dr.airspeed[0] > raas.apch_spd_limit(height_abv_thr) then
			raas.dbg.log("apch_config_chk", 1, string.format(
			    "TOO FAST: airspeed = %.0f apch_spd_limit = %.0f",
			    dr.airspeed[0], raas.apch_spd_limit(
			    height_abv_thr)))
			if raas.gpws_terr_ovrd() then
				raas.dbg.log("apch_config_chk", 1,
				    "TOO FAST: " .. "terr ovrd active")
			elseif raas.gpws_flaps_ovrd() then
				raas.dbg.log("apch_config_chk", 1,
				    "TOO FAST: " .. "flaps ovrd active")
			else
				if not critical then
					msg[#msg + 1] = "too_fast"
					if add_pause then
						msg[#msg + 1] = "pause"
					end
					msg[#msg + 1] = "too_fast"
					raas.ND_alert(
					    raas.const.ND_ALERT_TOO_FAST,
					    raas.const.ND_ALERT_CAUTION)
				else
					msg[#msg + 1] = "unstable"
					msg[#msg + 1] = "unstable"
					raas.ND_alert(
					    raas.const.ND_ALERT_UNSTABLE,
					    raas.const.ND_ALERT_CAUTION)
				end
			end
			spd_ann_table[arpt_id .. rwy_id] = true
			return true
		end
	end

	return false
end

function raas.air_runway_approach_arpt_rwy(arpt, rwy, suffix, pos_v, hdg,
    alt)
	assert(arpt ~= nil)
	assert(rwy ~= nil)
	assert(suffix ~= nil)
	assert(pos_v ~= nil)
	assert(hdg ~= nil)
	assert(alt ~= nil)

	local rwy_id = rwy["id" .. suffix]
	local arpt_id = arpt["arpt_id"]
	local elev = arpt["elev"]
	local rwy_hdg = rwy["hdg" .. suffix]
	local in_prox_bbox = raas.vect2.in_poly(pos_v,
	    rwy["apch_prox_bbox" .. suffix])

	if in_prox_bbox and math.abs(raas.rel_hdg(hdg, rwy_hdg)) <
	    raas.const.HDG_ALIGN_THRESH then
		local msg = {}
		local msg_prio = raas.const.MSG_PRIO_MED
		local thr_v = rwy["t" .. suffix .. "v"]
		assert(thr_v ~= nil)
		local dist = raas.vect2.abs(raas.vect2.sub(pos_v, thr_v))

		local rwy_gpa = rwy["gpa" .. suffix]
		local tch = rwy["tch" .. suffix]
		local telev = rwy["te" .. suffix]
		assert(rwy_gpa ~= nil and tch ~= nil and telev ~= nil)
		local above_tch = raas.ft2m(raas.m2ft(dr.elev[0]) -
		    (telev + tch))

		if RAAS_too_high_enabled and tch ~= 0 and rwy_gpa ~= 0 and
		    math.abs(elev - telev) < raas.const.BOGUS_THR_ELEV_LIMIT
		    then
			gpa_act = math.deg(math.atan(above_tch / dist))
		else
			gpa_act = 0
		end

		if raas.apch_config_chk(arpt_id, rwy_id, alt - telev,
		    gpa_act, rwy_gpa, raas.const.RWY_APCH_FLAP1_THRESH,
		    raas.const.RWY_APCH_FLAP2_THRESH, msg,
		    raas.air_apch_flap1_ann, raas.air_apch_gpa1_ann,
		    raas.air_apch_spd1_ann, false, true, dist, true) or
		    raas.apch_config_chk(arpt_id, rwy_id, alt - telev,
		    gpa_act, rwy_gpa, raas.const.RWY_APCH_FLAP2_THRESH,
		    raas.const.RWY_APCH_FLAP3_THRESH, msg,
		    raas.air_apch_flap2_ann, raas.air_apch_gpa2_ann,
		    raas.air_apch_spd2_ann, false, false, dist, false) or
		    raas.apch_config_chk(arpt_id, rwy_id, alt - telev,
		    gpa_act, rwy_gpa, raas.const.RWY_APCH_FLAP3_THRESH,
		    raas.const.RWY_APCH_FLAP4_THRESH, msg,
		    raas.air_apch_flap3_ann, raas.air_apch_gpa3_ann,
		    raas.air_apch_spd3_ann, true, false, dist, false) then
			msg_prio = raas.const.MSG_PRIO_HIGH
		end

		-- If we are below 700 ft AFE and we haven't annunciated yet
		if alt - telev < raas.const.RWY_APCH_ALT_MAX and
		    raas.air_apch_rwy_ann[arpt_id .. rwy_id] == nil and
		    not raas.number_in_rngs(dr.rad_alt[0],
		    raas.const.RWY_APCH_SUPP_WINDOWS) then
			-- Don't annunciate if we are too low
			if alt - telev > raas.const.RWY_APCH_ALT_MIN then
				raas.do_approaching_rwy(arpt_id, rwy_id,
				    raas.closest_rwy_end(pos_v, rwy),
				    rwy["llen" .. suffix], false)
			end
			raas.air_apch_rwy_ann[arpt_id .. rwy_id] = true
		end

		if alt - telev < raas.const.SHORT_RWY_APCH_ALT_MAX and
		    alt - telev > raas.const.SHORT_RWY_APCH_ALT_MIN and
		    rwy["llen" .. suffix] < RAAS_min_landing_dist and
		    not raas.air_apch_short_rwy_ann then
			msg[#msg + 1] = "caution"
			msg[#msg + 1] = "short_rwy"
			msg[#msg + 1] = "short_rwy"
			msg_prio = raas.const.MSG_PRIO_HIGH
			raas.air_apch_short_rwy_ann = true
			raas.ND_alert(raas.const.ND_ALERT_SHORT_RWY,
			    raas.const.ND_ALERT_CAUTION)
		end

		if not table.isempty(msg) then
			raas.play_msg(msg, msg_prio)
		end

		return true
	elseif raas.air_apch_rwy_ann[arpt_id .. rwy_id] ~= nil and
	    not in_prox_bbox then
		raas.air_apch_rwy_ann[arpt_id .. rwy_id] = nil
	end

	return false
end

function raas.reset_airport_approach_table(tbl, arpt_id)
	assert(tbl ~= nil)
	assert(arpt_id ~= nil)

	for id, val in pairs(tbl) do
		if id:find(arpt_id, 1, true) == 1 then
			tbl[id] = nil
		end
	end
end

function raas.air_runway_approach_arpt(arpt)
	assert(arpt ~= nil)

	local in_apch_bbox = 0
	local alt = raas.m2ft(dr.elev[0])
	local hdg = dr.hdg[0]
	local arpt_id = arpt["arpt_id"]
	local elev = arpt["elev"]
	if alt > elev + raas.const.RWY_APCH_FLAP1_THRESH or
	    alt < elev - raas.const.ARPT_APCH_BLW_ELEV_THRESH then
		raas.reset_airport_approach_table(raas.air_apch_flap1_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_flap2_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_flap3_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_gpa1_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_gpa2_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_gpa3_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_spd1_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_spd2_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_spd3_ann,
		    arpt_id)
		raas.reset_airport_approach_table(raas.air_apch_rwy_ann,
		    arpt_id)
		return 0
	end

	local pos_v = raas.fpp.sph2fpp({dr.lat[0], dr.lon[0]}, arpt["fpp"])
	local hdg = dr.hdg[0]

	for i, rwy in pairs(arpt["rwys"]) do
		if raas.air_runway_approach_arpt_rwy(arpt, rwy, "1", pos_v,
		    hdg, alt) or raas.air_runway_approach_arpt_rwy(arpt, rwy,
		    "2", pos_v, hdg, alt) or
		    raas.vect2.in_poly(pos_v, rwy["rwy_bbox"]) then
			in_apch_bbox = in_apch_bbox + 1
		end
	end

	return in_apch_bbox
end

function raas.air_runway_approach()
	if dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH then
		return
	end

	local in_apch_bbox = 0
	local clb_rate = raas.conv_per_min(raas.m2ft(dr.elev[0] - raas.last_elev))

	for arpt_id, arpt in pairs(raas.cur_arpts) do
		in_apch_bbox = in_apch_bbox + raas.air_runway_approach_arpt(
		    arpt)
	end

	-- If we are neither over an approach bbox nor a runway, and we're
	-- not climbing and we're in a landing configuration, we're most
	-- likely trying to land onto something that's not a runway
	if in_apch_bbox == 0 and clb_rate < 0 and not raas.gear_is_up() and
	    dr.flaprqst[0] >= RAAS_min_landing_flap then
		if dr.rad_alt[0] <= raas.const.OFF_RWY_HEIGHT_MAX then
			-- only annunciate if we're above the minimum height
			if dr.rad_alt[0] >= raas.const.OFF_RWY_HEIGHT_MIN and
			    not raas.off_rwy_ann and not raas.gpws_terr_ovrd() then
				raas.play_msg({"caution", "twy", "caution",
				    "twy"}, raas.const.MSG_PRIO_HIGH)
				raas.ND_alert(raas.const.ND_ALERT_TWY,
				    raas.const.ND_ALERT_CAUTION)
			end
			raas.off_rwy_ann = true
		else
			-- Annunciation gets reset once we climb through
			-- the maximum annunciation altitude.
			raas.off_rwy_ann = false
		end
	end
	if in_apch_bbox == 0 then
		raas.air_apch_short_rwy_ann = false
	end
	if in_apch_bbox <= 1 then
		raas.air_apch_rwys_ann = false
	end
end

function raas.find_nearest_curarpt()
	local min_dist = raas.const.ARPT_LOAD_LIMIT
	local pos_ecef = raas.conv.sph2ecef({dr.lat[0], dr.lon[0]})
	local cur_arpt

	for arpt_id, arpt in pairs(raas.cur_arpts) do
		local dist = raas.vect3.abs(raas.vect3.sub(arpt["ecef"],
		    pos_ecef))
		if dist < min_dist then
			min_dist = dist
			cur_arpt = arpt
		end
	end

	return cur_arpt
end

function raas.altimeter_setting()
	if not RAAS_alt_setting_enabled or
	    dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH then
		return
	end

	local cur_arpt = raas.find_nearest_curarpt()
	local field_changed = false
	local const = raas.const

	if cur_arpt ~= nil then
		local arpt_id = cur_arpt["arpt_id"]
		raas.dbg.log("altimeter", 2, "find_nearest_curarpt() = " ..
		    arpt_id)
		raas.TA = cur_arpt["TA"]
		raas.TL = cur_arpt["TL"]
		raas.TATL_field_elev = cur_arpt["elev"]
		if arpt_id ~= raas.TATL_source then
			raas.TATL_source = arpt_id
			field_changed = true
			raas.dbg.log("altimeter", 1, "raas.TATL_source: " ..
			    arpt_id .. " TA: " .. raas.TA .. " TL: " ..
			    raas.TL .. " field_elev: " .. raas.TATL_field_elev)
		end
	else
		local arpt_ref = XPLMFindNavAid(nil, nil, dr.lat[0],
		    dr.lon[0], nil, xplm_Nav_Airport)
		local pos_ecef, arpt_ecef, db_arpt
		local vect3 = raas.vect3
		local outType, outLat, outLon, outHeight, outFreq, outHdg,
		    outID, outName

		raas.dbg.log("altimeter", 2, "XPLMFindNavAid() = " ..
		    tostring(arpt_ref))
		if arpt_ref ~= nil then
			outType, outLat, outLon, outHeight, outFreq, outHdg,
			    outID, outName = XPLMGetNavAidInfo(arpt_ref)
			pos_ecef = raas.conv.sph2ecef({dr.lat[0], dr.lon[0]})
			arpt_ecef = raas.conv.sph2ecef({outLat, outLon})
		end

		if outID ~= nil and raas.TATL_source ~= outID and
		    vect3.abs(vect3.sub(pos_ecef, arpt_ecef)) <
		    const.TATL_REMOTE_ARPT_DIST_LIMIT then
			raas.load_airports_in_tile(outLat, outLon)
			db_arpt = raas.apt_dat[outID]
			if db_arpt == nil then
				-- Grab the first airport in that tile
				local lat_i, lon_i = raas.geo_table_idx(outLat,
				    outLon)
				local tile = raas.geo_table_get_tile(lat_i,
				    lon_i, false)
				if tile ~= nil and not table.isempty(tile) then
					local icao = next(tile)
					db_arpt = raas.apt_dat[icao]
					raas.dbg.log("altimeter", 2,
					    "fallback airport = " ..
					    tostring(icao))
				end
			end
		end

		if db_arpt ~= nil then
			raas.TA = db_arpt["TA"]
			raas.TL = db_arpt["TL"]
			raas.TATL_field_elev = db_arpt["elev"]
			raas.TATL_source = outID
			field_changed = true
			raas.dbg.log("altimeter", 1, "raas.TATL_source: " ..
			    outID .. " TA: " .. raas.TA .. " TL: " ..
			    raas.TL .. " field_elev: " .. raas.TATL_field_elev)
		end
	end

	if raas.TL == 0 then
		if field_changed then
			raas.dbg.log("altimeter", 1, "TL = 0")
		end
		if raas.TA ~= 0 then
			if dr.baro_sl[0] > const.STD_BARO_REF then
				raas.TL = raas.TA
			else
				local qnh = dr.baro_sl[0] * 33.85
				raas.TL = raas.TA + 28 * (1013 - qnh)
			end
			if field_changed then
				raas.dbg.log("altimeter", 1,
				    "TL(auto) = " .. raas.TL)
			end
		end
	end
	if raas.TA == 0 then
		if field_changed then
			raas.dbg.log("altimeter", 1, "TA(auto) = " .. raas.TA)
		end
		raas.TA = raas.TL
	end

	local elev = raas.m2ft(dr.elev[0])

	if raas.TA ~= 0 and elev > raas.TA and raas.TATL_state == "alt" then
		raas.TATL_transition = os.time()
		raas.TATL_state = "fl"
		raas.dbg.log("altimeter", 1, "elev > TA (" .. raas.TA ..
		    ") transitioning TATL_state = fl")
	end
	if raas.TL ~= 0 and elev < raas.TA and dr.baro_alt[0] < raas.TL and
	    -- If there's a gap between the altitudes and flight levels, don't
	    -- transition until we're below the TA
	    (raas.TA == 0 or elev < raas.TA) and raas.TATL_state == "fl" then
		raas.TATL_transition = os.time()
		raas.TATL_state = "alt"
		raas.dbg.log("altimeter", 1, "baro_alt < TL (" .. raas.TL ..
		    ") transitioning TATL_state = alt")
	end

	local now = os.time()
	if raas.TATL_transition ~= -1 then
		if  -- We have transitioned into ALT mode
		    raas.TATL_state == "alt" and
		    -- The fixed timeout has passed, OR
		    (now - raas.TATL_transition > const.ALTM_SETTING_TIMEOUT or
		    -- The field has a known elevation and we are within
		    -- 1500 feet of it
		    (raas.TATL_field_elev ~= nil and (elev < raas.TATL_field_elev +
		    const.ALTM_SETTING_ALT_CHK_LIMIT))) then
			local d_qnh, d_qfe = 0, 0

			if RAAS_qnh_alt_enabled then
				d_qnh = math.abs(elev - dr.baro_alt[0])
			end
			if raas.TATL_field_elev ~= nil and RAAS_qfe_alt_enabled then
				d_qfe = math.abs(dr.baro_alt[0] -
				    (elev - raas.TATL_field_elev))
			end
			raas.dbg.log("altimeter", 1, "alt check; d_qnh: "
			    .. d_qnh .. " d_qfe: " .. tostring(d_qfe))
			if  -- The set baro is out of bounds for QNH, OR
			    d_qnh > const.ALTIMETER_SETTING_QNH_ERR_LIMIT or
			    -- Set baro is out of bounds for QFE
			    d_qfe > const.ALTM_SETTING_QFE_ERR_LIMIT then
				raas.play_msg({"alt_set"}, const.MSG_PRIO_LOW)
				raas.ND_alert(raas.const.ND_ALERT_ALTM_SETTING,
				    raas.const.ND_ALERT_CAUTION)
			end
			raas.TATL_transition = -1
		elseif raas.TATL_state == "fl" and now - raas.TATL_transition >
		    const.ALTM_SETTING_TIMEOUT then
			local d_ref = math.abs(dr.baro_set[0] -
			    const.STD_BARO_REF)
			raas.dbg.log("altimeter", 1, "fl check; d_ref: " ..
			    d_ref)
			if d_ref > const.ALTM_SETTING_BARO_ERR_LIMIT then
				raas.play_msg({"alt_set"}, const.MSG_PRIO_LOW)
				raas.ND_alert(raas.const.ND_ALERT_ALTM_SETTING,
				    raas.const.ND_ALERT_CAUTION)
			end
			raas.TATL_transition = -1
		end
	end
end

-- Transfers our electrical load to bus number `busnr' (numbered from 0)
function raas.xfer_elec_bus(busnr)
	local xbusnr = (busnr + 1) % 2
	if raas.bus_loaded == xbusnr then
		dr.plug_bus_load[xbusnr] = dr.plug_bus_load[xbusnr] -
		    raas.const.BUS_LOAD_AMPS
		raas.bus_loaded = -1
	end
	if raas.bus_loaded == -1 then
		dr.plug_bus_load[busnr] = dr.plug_bus_load[busnr] +
		    raas.const.BUS_LOAD_AMPS
		raas.bus_loaded = busnr
	end
end

-- Returns true if X-RAAS has electrical power from the aircraft.
function raas.is_on()
	local turned_on

	turned_on = ((dr.bus_volt[0] > raas.const.MIN_BUS_VOLT or
	    dr.bus_volt[1] > raas.const.MIN_BUS_VOLT) and
	    dr.avionics_on[0] == 1 and dr.gpws_inop[0] ~= 1)

	if turned_on then
		if dr.bus_volt[0] < raas.const.MIN_BUS_VOLT then
			raas.xfer_elec_bus(1)
		else
			raas.xfer_elec_bus(0)
		end
	elseif raas.bus_loaded ~= -1 then
		dr.plug_bus_load[raas.bus_loaded] = dr.plug_bus_load[raas.bus_loaded] -
		    raas.const.BUS_LOAD_AMPS
		raas.bus_loaded = -1
	end

	return ((turned_on or RAAS_override_electrical) and
	    (dr.replay_mode[0] == 0 or RAAS_override_replay))
end

function raas.exec()
	local now = os.clock()
	local time_s, time_e

	-- Before we start, wait a set delay, because X-Plane's datarefs
	-- needed for proper init are unstable, so we'll give them an
	-- extra second to fix themselves
	if now - raas.start_time < raas.const.STARTUP_DELAY or
	    now - raas.last_exec_time < raas.const.EXEC_INTVAL or
	    not raas.is_on() then
		return
	end
	raas.last_exec_time = now

	if dr.ND_alert[0] > 0 and
	    now - raas.ND_alert_start_time > RAAS_ND_alert_timeout then
		if raas.GPWS_has_priority() then
			-- If GPWS priority has overridden us, keep the
			-- alert displayed until after the priority
			-- has been lifted.
			raas.ND_alert_start_time = now
		else
			dr.ND_alert[0] = 0
		end
	end

	raas.load_nearest_airports(nil)

	if dr.rad_alt[0] > raas.const.RADALT_FLARE_THRESH then
		if not raas.departed then
			raas.departed = true
			raas.dbg.log("flt_state", 1, "raas.departed = true")
		end
		if not raas.arriving then
			raas.arriving = true
			raas.dbg.log("flt_state", 1, "raas.arriving = true")
		end
		if raas.long_landing_ann then
			raas.dbg.log("ann_state", 1,
			    "raas.long_landing_ann = false")
			raas.long_landing_ann = false
		end
	elseif dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH then
		if raas.departed then
			raas.dbg.log("flt_state", 1, "raas.landing = true")
			raas.dbg.log("flt_state", 1, "raas.departed = false")
			raas.landing = true
		end
		raas.departed = false
		if dr.gs[0] < raas.const.SPEED_THRESH then
			raas.arriving = false
		end
	end
	if dr.gs[0] < raas.const.SPEED_THRESH and raas.long_landing_ann then
		raas.dbg.log("ann_state", 1, "raas.long_landing_ann = false")
		raas.long_landing_ann = false
	end

	if RAAS_debug["profile"] ~= nil then
		time_s = os.clock()
	end
	raas.ground_runway_approach()
	raas.ground_on_runway_aligned()
	raas.air_runway_approach()
	raas.altimeter_setting()
	if RAAS_debug["profile"] ~= nil then
		time_e = os.clock()
		raas.dbg.log("profile", 1, string.format("raas.exec: " ..
		    "%.03f ms [Lua: %d kB]", ((time_e - time_s) * 1000),
		    collectgarbage("count")))
	end

	raas.last_elev = dr.elev[0]
	raas.last_gs = dr.gs[0]
end

function raas.shutdown()
	if raas.bus_loaded ~= -1 then
		dr.plug_bus_load[raas.bus_loaded] = dr.plug_bus_load[raas.bus_loaded] -
		    raas.const.BUS_LOAD_AMPS
		raas.bus_loaded = -1
	end
	if raas.cur_msg["snd"] ~= nil then
		stop_sound(raas.cur_msg["snd"])
		raas.cur_msg = {}
	end
end

raas.dbg.draw_scale = 0.1

function raas.dbg.x(coord)
	local offx = SCREEN_WIDTH / 2
	return coord * raas.dbg.draw_scale + offx
end

function raas.dbg.y(coord)
	local offy = SCREEN_HIGHT / 2
	return coord * raas.dbg.draw_scale + offy
end

function raas.dbg.draw_bbox(bbox)
	local graphics = require 'graphics'
	for i = 0, #bbox - 1 do
		graphics.draw_line(
		    raas.dbg.x(bbox[i + 1][1]),
		    raas.dbg.y(bbox[i + 1][2]),
		    raas.dbg.x(bbox[(i + 1) % #bbox + 1][1]),
		    raas.dbg.y(bbox[(i + 1) % #bbox + 1][2]))
	end
end

function raas.dbg.draw()
	if not raas.is_on() then
		return
	end

	local graphics = require 'graphics'
	local cur_arpt = raas.find_nearest_curarpt()

	if not cur_arpt then
		return
	end

	if RAAS_debug_graphical_bg > 0 then
		graphics.set_color(0, 0, 0, RAAS_debug_graphical_bg)
		graphics.draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)
	end

	graphics.set_width(2)

	local pos_v = raas.fpp.sph2fpp({dr.lat[0], dr.lon[0]}, cur_arpt["fpp"])
	local vel_v = raas.acf_vel_vector(raas.const.RWY_PROXIMITY_TIME_FACT)
	local dbg = raas.dbg

	dbg.draw_scale = math.min(SCREEN_HIGHT / (2 * raas.vect2.abs(pos_v)), 1)

	graphics.set_color(1, 0, 0, 1)
	graphics.draw_line(dbg.x(-5), dbg.y(0), dbg.x(5), dbg.y(0))
	graphics.draw_line(dbg.x(0), dbg.y(-5), dbg.x(0), dbg.y(5))

	for rwy_id, rwy in pairs(cur_arpt["rwys"]) do
		graphics.set_color(1, 1, 1, 0.5)
		dbg.draw_bbox(rwy["apch_prox_bbox1"])
		dbg.draw_bbox(rwy["apch_prox_bbox2"])
		graphics.set_color(0, 0, 1, 0.67)
		dbg.draw_bbox(rwy["prox_bbox"])
		graphics.set_color(1, 0, 0, 1)
		dbg.draw_bbox(rwy["asda_bbox"])
		graphics.set_color(1, 1, 0, 1)
		dbg.draw_bbox(rwy["tora_bbox"])
		graphics.set_color(0, 1, 0, 1)
		dbg.draw_bbox(rwy["rwy_bbox"])
	end

	graphics.set_color(1, 1, 1, 1)
	local tgt = raas.vect2.add(pos_v, vel_v)
	graphics.draw_line(dbg.x(pos_v[1]) - 5, dbg.y(pos_v[2]),
	    dbg.x(pos_v[1]) + 5, dbg.y(pos_v[2]))
	graphics.draw_line(dbg.x(pos_v[1]), dbg.y(pos_v[2]) - 5,
	    dbg.x(pos_v[1]), dbg.y(pos_v[2]) + 5)
	graphics.draw_line(dbg.x(pos_v[1]), dbg.y(pos_v[2]),
	    dbg.x(tgt[1]), dbg.y(tgt[2]))

	graphics.set_width(1)
end

function raas.load_msg_table()
	local voice_dir

	if RAAS_voice_female then
		voice_dir = "female"
	else
		voice_dir = "male"
	end

	-- Make sure the gain is set in the regular band
	RAAS_voice_volume = math.max(RAAS_voice_volume, 0.001)
	RAAS_voice_volume = math.min(RAAS_voice_volume, 1.0)

	for msgid, msg in pairs(messages) do
		local fname = SCRIPT_DIRECTORY .. "X-RAAS_msgs" .. DIRSEP ..
		    voice_dir .. DIRSEP .. msgid .. ".wav"
		local snd_f = io.open(fname)
		local sz = snd_f:seek("end")

		snd_f:close()
		msg["snd"] = load_WAV_file(fname)
		assert(msg["snd"] ~= nil)
		set_sound_gain(msg["snd"], RAAS_voice_volume)
		-- all our sound files are mono, 16-bit, 22.05 kHz, so simply
		-- estimate the length based on file size (44 bytes is the
		-- RIFF header)
		msg["dur"] = (sz - 44) / 2 / 22050
	end
end

-- Message priority is one of MSG_PRIO_LOW, MSG_PRIO_MED or MSG_PRIO_HIGH.
-- These determine how conflicts in message playback resolved between
-- the message passed to play_msg and the one being currently played (raas.cur_msg):
-- 1) if raas.cur_msg is higher priority than the play_msg argument, the play_msg
--	argument is silently dropped
-- 2) if raas.cur_msg and the play_msg argument are equal priority, the play_msg
--	argument is appended to raas.cur_msg and is played immediately following it.
-- 3) if raas.cur_msg is lower priority than the play_msg argument, the raas.cur_msg
--	is immediately stopped and the play_msg argument is played instead.
function raas.play_msg(msg, prio)
	assert(prio ~= nil)
	raas.dbg.log("play_msg", 1, "Playing message" .. table.show(msg) ..
	    " at priority " .. prio)
	if not table.isempty(raas.cur_msg) then
		if raas.cur_msg["prio"] > prio then
			raas.dbg.log("play_msg", 2, "msg prio " .. prio ..
			    " lower than raas.cur_msg prio " .. raas.cur_msg["prio"] ..
			    ", suppressing playback")
			return
		end
		if raas.cur_msg["prio"] < prio then
			raas.dbg.log("play_msg", 2, "msg prio " .. prio ..
			    " higher than raas.cur_msg prio " .. raas.cur_msg["prio"] ..
			    ", stopping raas.cur_msg")
			if raas.cur_msg["snd"] ~= nil then
				stop_sound(raas.cur_msg["snd"])
			end
			raas.cur_msg = {}
		end
	end

	if raas.cur_msg["msg"] == nil then
		raas.dbg.log("play_msg", 2, "no raas.cur_msg, playing from idx 0")
		raas.cur_msg["msg"] = msg
	else
		raas.dbg.log("play_msg", 2, "raas.cur_msg playing, " ..
		    "appending our message")
		for i = 1, #msg do
			raas.cur_msg["msg"][#raas.cur_msg["msg"] + 1] = msg[i]
		end
	end
	if raas.cur_msg["playing"] == nil then
		raas.cur_msg["playing"] = 0
	end
	raas.cur_msg["prio"] = prio
end

-- Checks based on aircraft type if we shouldn't display visual ND alerts
-- Some aircraft (such as the B733) didn't have their avionics retrofitted
-- to show RAAS visual alerts.
function raas.ND_alerts_autodisable()
	if AIRCRAFT_FILENAME:find("B733", 1, true) == 1 then
		return true
	end
	return false
end

function raas.ND_alert(msg, level, rwy_ID, dist)
	if not RAAS_ND_alerts_enabled or (not RAAS_ND_alert_overlay_force and
	    raas.ND_alerts_autodisable()) then
		return
	end

	raas.dbg.log("ND_alert", 1, "msg: " .. msg .. " rwy_ID: " ..
	    tostring(rwy_ID) .. " dist: " .. tostring(dist) .. " caution: " ..
	    tostring(caution))

	if level < RAAS_ND_alert_filter then
		raas.dbg.log("ND_alert", 2, "suppressed due to filter setting")
		return
	end

	-- encode any non-routine alerts as amber
	if level > raas.const.ND_ALERT_ROUTINE then
		msg = bit.bor(msg, 0x40)
	end

	-- encode the optional runway ID field
	if rwy_ID ~= nil and rwy_ID ~= "" then
		local num, suffix

		num = tonumber(rwy_ID:sub(1, 2))
		suffix = rwy_ID:sub(3, 3)
		msg = bit.bor(msg, bit.lshift(num, 8))
		if suffix == "R" then
			msg = bit.bor(msg, bit.lshift(1, 14))
		elseif suffix == "L" then
			msg = bit.bor(msg, bit.lshift(2, 14))
		elseif suffix == "C" then
			msg = bit.bor(msg, bit.lshift(3, 14))
		end
	end

	-- encode the optional distance field
	if dist ~= nil then
		if RAAS_use_imperial then
			msg = bit.bor(msg, bit.lshift(bit.band(math.floor(
			    raas.m2ft(dist) / 100), 0xff), 16))
		else
			msg = bit.bor(msg, bit.lshift(bit.band(math.floor(
			    dist / 100), 0xff), 16))
		end
	end

	dr.ND_alert[0] = msg
	raas.ND_alert_start_time = os.clock()
end

function raas.set_sound_on(flag)
	local val
	if flag then
		val = RAAS_voice_volume
	else
		val = 0.0001
	end
	for i, msg in pairs(messages) do
		set_sound_gain(msg["snd"], val)
	end
end

-- This is the sound scheduling loop.
function raas.snd_sched()
	if table.isempty(raas.cur_msg) then
		return
	end

	-- Make sure our messages are only audible when we're inside
	-- the cockpit and AC power is on
	if raas.view_is_ext and (dr.ext_view[0] == 0 or
	    not RAAS_disable_ext_view) then
		raas.set_sound_on(true)
		raas.view_is_ext = false
	elseif not raas.view_is_ext and dr.ext_view[0] == 1 then
		raas.set_sound_on(false)
		raas.view_is_ext = true
	end

	-- stop audio when GPWS is overriding us - we'll restart the
	-- annunciation once it's over
	if raas.GPWS_has_priority() and raas.cur_msg["snd"] ~= nil then
		stop_sound(raas.cur_msg["snd"])
		raas.cur_msg["playing"] = 0
		return
	end

	-- stop audio when power is down
	if not raas.is_on() then
		if raas.cur_msg["snd"] ~= nil then
			stop_sound(raas.cur_msg["snd"])
		end
		raas.cur_msg = {}
		return
	end

	local now = os.clock()
	local started = raas.cur_msg["started"]
	local playing = raas.cur_msg["playing"]

	if started == nil or started < now -
	    messages[raas.cur_msg["msg"][playing]]["dur"] - 0.1 then
		if playing == nil then
			playing = 1
		else
			playing = playing + 1
		end
		if playing > #raas.cur_msg["msg"] then
			raas.cur_msg = {}
			return
		end

		local msg = messages[raas.cur_msg["msg"][playing]]
		raas.cur_msg["started"] = now
		raas.cur_msg["playing"] = playing
		raas.cur_msg["snd"] = msg["snd"]
		play_sound(msg["snd"])
	end
end

function raas.ND_alert_HUD()
	local dr_value = dr.ND_alert[0]
	local msg, color, graphics

	if dr_value == 0 then
		return
	end

	msg, color = XRAAS_ND_msg_decode(dr_value)
	if msg == nil or raas.view_is_ext or not raas.is_on() then
		return
	end

	graphics = require 'graphics'

	local width = graphics.measure_string(msg, "Helvetica_18")
	graphics.set_color(0, 0, 0, 0.67)
	graphics.draw_rectangle((SCREEN_WIDTH - width) / 2 - 8,
	    SCREEN_HIGHT * 0.98 - 27,
	    (SCREEN_WIDTH + width) / 2 + 8, SCREEN_HIGHT * 0.98)
	if color == 0 then
		graphics.set_color(0, 1, 0, 1)
	else
		graphics.set_color(1, 1, 0, 1)
	end
	graphics.draw_string_Helvetica_18((SCREEN_WIDTH - width) / 2,
	    SCREEN_HIGHT * 0.98 - 20, msg)
end

function raas.load_config(cfgname)
	local cfg_f = io.open(cfgname)
	if cfg_f ~= nil then
		cfg_f:close()
		local f, err = loadfile(cfgname)
		if f ~= nil then
			f()
		else
			raas.log_init_msg("X-RAAS startup error: syntax " ..
			    "error in config file:\n" .. tostring(err) ..
			    "\nPlease correct this and then hit Plugins " ..
			    "-> FlyWithLua -> Reload all Lua script files")
			return false
		end
	end
	return true
end

function raas.load_configs()
	-- order is important here, first load the global one
	if not raas.load_config(SCRIPT_DIRECTORY .. "X-RAAS.cfg") then
		return false
	end
	if not raas.load_config(AIRCRAFT_PATH .. "X-RAAS.cfg") then
		return false
	end
	return true
end

function raas.show_init_msg()
	local graphics = require 'graphics'
	if not raas.init_msg then
		return
	end
	if os.clock() - raas.start_time > raas.const.INIT_MSG_TIMEOUT then
		raas.init_msg = nil
		return
	end
	local lines = raas.init_msg:split("\n")
	local width = 0
	local height = #lines * 20
	for i, line in pairs(lines) do
		width = math.max(width, graphics.measure_string(line,
		    "Helvetica_18"))
	end
	graphics.set_color(0, 0, 0, 0.67)
	graphics.draw_rectangle((SCREEN_WIDTH - width) / 2 - 20, 0,
	    (SCREEN_WIDTH + width) / 2 + 20, height + 20)
	graphics.set_color(1, 1, 1, 1)
	for i, line in pairs(lines) do
		graphics.draw_string_Helvetica_18((SCREEN_WIDTH - width) / 2,
		    height - i * 20 + 10, line)
	end
end

-- This is to be called ONCE per X-RAAS startup to log an initial startup
-- message and then exit.
function raas.log_init_msg(msg)
	logMsg(msg)
	if RAAS_auto_disable_notify then
		raas.init_msg = msg
		do_every_draw('raas.show_init_msg()')
	end
end

-- Check if the aircraft is a helicopter (or at least flies like one).
function raas.chk_acf_is_helo()
	for line in io.lines(AIRCRAFT_PATH .. AIRCRAFT_FILENAME) do
		if line:find("P acf/_fly_like_a_helo", 1, true) == 1 then
			return (line:find("P acf/_fly_like_a_helo 1", 1,
			    true) == 1)
		end
	end
	return false
end

function raas.chk_acf_incompat()
	for id, acfname in pairs(raas.const.incompat_acf) do
		if AIRCRAFT_FILENAME:find(acfname, 1, true) ~= nil then
			return true
		end
	end
	return false
end

-- This loads our ND message decoder. This serves both to test the code and
-- to implement the X-RAAS native alert display overlay HUD.
function raas.load_ND_decoder()
	local fname = SCRIPT_DIRECTORY .. "X-RAAS_api" .. DIRSEP .. "lua" ..
	    DIRSEP .. "XRAAS_ND_msg_decode.lua"

	local decoder_f = io.open(fname)
	if decoder_f == nil then
		raas.log_init_msg("X-RAAS: installation error: " ..
		    "couldn't load file:\n" .. fname)
		return false
	end
	decoder_f:close()

	local f, err = loadfile(fname)
	if f ~= nil then
		f()
	else
		raas.log_init_msg("X-RAAS: installation error: " ..
		    "syntax error in file:\n" .. tostring(err))
		return false
	end
	return true
end

if RAAS_ND_alerts_enabled and RAAS_ND_alert_overlay_enabled then
	if not raas.load_ND_decoder() then
		return
	end
end
if not raas.load_configs() then
	return
end
raas.reset()

assert(raas.init_msg == nil)

if not RAAS_enabled then
	logMsg("X-RAAS: DISABLED")
	return
elseif raas.chk_acf_is_helo() and not RAAS_allow_helos then
	raas.log_init_msg(
	    "X-RAAS: auto-disabled (aircraft is a helicopter).\n\n" ..
	    "If you don't know what this means, refer to the user manual " ..
	    "in X-RAAS_docs" .. DIRSEP .. "manual.pdf, Section 3 " ..
	    "\"Activating X-RAAS in the aircraft\".")
	return
elseif dr.num_engines[0] < RAAS_min_engines or dr.mtow[0] < RAAS_min_MTOW then
	raas.log_init_msg(
	    "X-RAAS: auto-disabled due to aircraft parameters:\n" ..
	    "Your aircraft: (" .. dr.ICAO[0] .. ") #engines: " ..
	    dr.num_engines[0] .. "; MTOW: " .. math.floor(dr.mtow[0]) ..
	    " kg\n" ..
	    "X-RAAS configuration: minimum #engines: " .. RAAS_min_engines
	    .. "; minimum MTOW: " ..RAAS_min_MTOW .. " kg\n\n" ..
	    "If you don't know what this means, refer to the user manual " ..
	    "in X-RAAS_docs" .. DIRSEP .. "manual.pdf, Section 3 " ..
	    "\"Activating X-RAAS in the aircraft\".")
	return
elseif raas.chk_acf_incompat() then
	raas.log_init_msg("X-RAAS: auto-disabled, incompatible aircraft " ..
	    "detected.\n\n" ..
	    "If you don't know what this means, refer to the user manual " ..
	    "in X-RAAS_docs" .. DIRSEP .. "manual.pdf, Section 7.1 " ..
	    "\"Wholly incompatible aircraft\".")
	return
else
	logMsg("X-RAAS: ENABLED")
end

raas.load_msg_table()
raas.map_apt_dats()

do_every_frame('raas.exec()')
do_every_draw('raas.snd_sched()')

if RAAS_ND_alerts_enabled and RAAS_ND_alert_overlay_enabled then
	do_every_draw('raas.ND_alert_HUD()')
end

-- FlyWithLua prior to 2.4.1 didn't have do_on_exit
if do_on_exit ~= nil then
	do_on_exit('raas.shutdown()')
end

-- Uncomment the line below to get a nice debug display
if RAAS_debug_graphical then
	do_every_draw('raas.dbg.draw()')
end
