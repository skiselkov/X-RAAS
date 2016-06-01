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
		*) Not alinged with runway
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
		*) Calls supressed during go-around
		    +) Above 100 feet AGL
		    +) Climb rate 450 FPM or greater
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
		*) Supressed between 520-480 feet AGL, 420-380 feet AGL and
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
raas.const.STOPPED_THRESH = 1.55		-- m/s, 3 knots
raas.const.EARTH_MSL = 6371000			-- meters
raas.const.RWY_PROXIMITY_LAT_FRACT = 3
raas.const.RWY_PROXIMITY_LON_DISPL = 609.57	-- meters, 2000 ft
raas.const.RWY_PROXIMITY_TIME_FACT = 2		-- seconds
raas.const.LANDING_ROLLOUT_TIME_FACT = 1	-- seconds
raas.const.RADALT_GRD_THRESH = 5		-- feet
raas.const.RADALT_FLARE_THRESH = 50		-- feet
raas.const.STARTUP_DELAY = 3			-- seconds
raas.const.INIT_MSG_TIMEOUT = 25		-- seconds
raas.const.ARPT_RELOAD_INTVAL = 10		-- seconds
raas.const.ARPT_LOAD_LIMIT = 8 * 1852		-- meters, 8nm distance
raas.const.ACCEL_STOP_SPD_THRESH = 2.6		-- m/s, 5 knots
raas.const.STOP_INIT_DELAY = 300
raas.const.BOGUS_THR_ELEV_LIMIT = 500		-- feet
raas.const.STD_BARO_REF = 29.92			-- inches of mercury
raas.const.ALTM_SETTING_TIMEOUT = 30		-- seconds
raas.const.ALTM_SETTING_ALT_CHK_LIMIT = 1500	-- feet
raas.const.ALTIMETER_SETTING_QNH_ERR_LIMIT = 60	-- feet
raas.const.ALTM_SETTING_QFE_ERR_LIMIT = 60	-- feet
raas.const.ALTM_SETTING_BARO_ERR_LIMIT = 0.02	-- inches of mercury
raas.const.IMMEDIATE_STOP_DIST = 50		-- meters
raas.const.GOAROUND_CLB_RATE_THRESH = 450	-- feet per minute
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
raas.const.RWY_APCH_ALT_MAX = 700		-- feet
raas.const.RWY_APCH_ALT_MIN = 320		-- feet
raas.const.RWY_APCH_SUPP_WINDOWS = {		-- suppress 'approaching'
    {["max"] = 520, ["min"] = 480},		-- annunciations in these
    {["max"] = 420, ["min"] = 380},		-- altitude windows
}
raas.const.TATL_REMOTE_ARPT_DIST_LIMIT = 500000	-- meters
raas.const.MIN_BUS_VOLT = 11			-- Volts
raas.const.BUS_LOAD_AMPS = 2			-- Amps
local XRAAS_apt_dat_cache_version = 2

raas.const.MSG_PRIO_LOW = 1
raas.const.MSG_PRIO_MED = 2
raas.const.MSG_PRIO_HIGH = 3

-- config stuff (to be overridden by acf)
RAAS_enabled = true
RAAS_min_engines = 2				-- count
RAAS_min_MTOW = 5700				-- kg
RAAS_auto_disable_notify = true
RAAS_override_electrical = false

RAAS_use_imperial = true
RAAS_min_takeoff_dist = 1000			-- meters
RAAS_min_landing_dist = 800			-- meters
RAAS_min_rotation_dist = 400			-- meters
RAAS_min_rotation_angle = 3			-- degrees
RAAS_accel_stop_dist_cutoff = 3000		-- meters
RAAS_voice_female = true
RAAS_voice_volume = 1.0
RAAS_disable_ext_view = true
RAAS_min_landing_flap = 0.5			-- ratio
RAAS_min_takeoff_flap = 0.1			-- ratio
RAAS_max_takeoff_flap = 0.75			-- ratio

RAAS_on_rwy_warn_initial = 60			-- seconds
RAAS_on_rwy_warn_repeat = 120			-- seconds
RAAS_on_rwy_warn_max_n = 3

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
local RAAS_gpa_limit_mult = 1.5			-- multiplier
local RAAS_gpa_limit_max = 8			-- degrees

RAAS_alt_setting_enabled = true
RAAS_qnh_alt_enabled = true
RAAS_qfe_alt_enabled = false

-- Debug settings. These aren't documented, as they're rather advanced.
RAAS_debug = {}
RAAS_debug_graphical = false
RAAS_debug_graphical_bg = 0

-- DO NOT CHANGE THIS!
raas.const.xpdir = SCRIPT_DIRECTORY .. ".." .. DIRSEP .. ".." .. DIRSEP ..
    ".." .. DIRSEP .. ".." .. DIRSEP

local dr = {}
local cur_arpts = {}
local raas_start_time = nil
local raas_last_exec_time = nil
local last_airport_reload = 0

local airport_geo_table = {}
local apt_dat = {}

local dbg_enabled = false

local on_rwy_ann = {}
local apch_rwy_ann = {}
local air_apch_rwy_ann = {}
local air_apch_flap1_ann = {}
local air_apch_flap2_ann = {}
local air_apch_flap3_ann = {}
local on_twy_ann = false
local long_landing_ann = false
local short_rwy_takeoff_chk = false
local on_rwy_timer = -1
local on_rwy_warnings = 0
local off_rwy_ann = false

local accel_stop_max_spd = {}
local accel_stop_ann_initial = 0
local departed = false
local arriving = false
local landing = false

local TA = 0
local TL = 0
local TATL_field_elev = nil
local TATL_state = "alt"
local TATL_transition = -1
local TATL_source = nil

local messages = {
	["0"] = {}, ["1"] = {}, ["2"] = {}, ["3"] = {}, ["4"] = {},
	["5"] = {}, ["6"] = {}, ["7"] = {}, ["8"] = {}, ["9"] = {}, ["30"] = {},
	["alt_set"] = {}, ["apch"] = {}, ["caution"] = {}, ["flaps"] = {},
	["hundred"] = {}, ["left"] = {}, ["long_land"] = {}, ["on_rwy"] = {},
	["on_twy"] = {}, ["right"] = {}, ["rmng"] = {}, ["short_rwy"] = {},
	["thousand"] = {}, ["too_fast"] = {}, ["too_high"] = {}, ["twy"] = {},
	["unstable"] = {}
}
local cur_msg = {}
local view_is_ext = false
local bus_loaded = -1
local last_elev = 0

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

   The string returned is "Lua code", which can be procesed
   (in the case in which indent is composed by spaces or "--").
   Userdata and function keys and values are shown as strings,
   which logically are exactly not equivalent to the original code.

   This routine can serve for pretty formating tables with
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
-- airport_geo_table to retrieve the tile for a given latitude & longitude.
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

	lat_tbl = airport_geo_table[lat]
	if lat_tbl == nil then
		if not create then
			return nil, false
		end
		created = true
		lat_tbl = {}
		airport_geo_table[lat] = lat_tbl
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
-- array containings tables of this format:
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
	dr.gpws_warn = dataref_table("sim/cockpit/warnings/annunciators/GPWS")
	dr.gpws_ann = dataref_table("sim/cockpit2/annunciators/GPWS")

	-- Unfortunately at this moment electrical loading is broken,
	-- because X-Plane resets plugin_bus_load_amps when the aircraft
	-- is repositioned, making it impossible for us to track our
	-- electrical laod appropriately. So it's better to disable it,
	-- than to have it be broken.
	--dr.plug_bus_load = dataref_table("sim/cockpit2/electrical/" ..
	--    "plugin_bus_load_amps")
	dr.plug_bus_load = {[0] = 0, [1] = 0}

	raas_start_time = os.clock()
	raas_last_exec_time = raas_start_time
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

-- Checks if the aircraft has a terrain override mode on the GPWS and if it
-- does, returns true if it GPWS terrain warnings are overridden, otherwise
-- returns false.
function raas.gpws_terr_ovrd()
	if AIRCRAFT_FILENAME:find("757RR", 1, true) == 1 or
	    AIRCRAFT_FILENAME:find("757PW", 1, true) == 1 then
		local dr = dataref_table("anim/75/button")
		return dr[0] == 1
	end
	return false
end

-- Checks if the aircraft has a flaps override mode on the GPWS and if it
-- does, returns true if it GPWS flaps warnings are overridden, otherwise
-- returns false. If the aircraft doesn't have a flaps override GPWS mode,
-- we attempt to also examine if the aircraft has a terrain override mode.
function raas.gpws_flaps_ovrd()
	if AIRCRAFT_FILENAME:find("757RR", 1, true) == 1 or
	    AIRCRAFT_FILENAME:find("757PW", 1, true) == 1 then
		local dr = dataref_table("anim/72/button")
		return dr[0] == 1
	end
	return raas.gpws_terr_ovrd()
end

-- Given a runway ID, returns the reciprical runway ID.
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

-- Parses an apt.dat (or X-RAAS_apt_dat.cache) file, parses its contents
-- and reconstructs our apt_dat table. This is called at the start of
-- X-RAAS to populate the airport and runway database. The 
function raas.map_apt_dat(apt_dat_fname)
	assert(apt_dat_fname ~= nil)

	raas.dbg.log("tile", 1, "raas.map_apt_dat(\"" .. apt_dat_fname .. "\")")

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

			if icao ~= nil and table.isempty(apt["rwys"]) then
				-- if the previous airport contained
				-- no runways, discard it
				apt_dat[icao] = nil
				arpt_cnt = arpt_cnt - 1
			end

			icao = nil
			apt = nil

			if apt_dat[new_icao] == nil then
				if new_icao == "KSBA" then
					logMsg("found KSBA in " .. apt_dat_fname)
				end
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
				apt_dat[icao] = apt
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
			    ["id1"] = id1, ["lat1"] = lat1, ["lon1"] = lon1,
			    ["dis1"] = displ1, ["bla1"] = blast1,
			    ["gpa1"] = gpa1, ["tch1"] = tch1, ["te1"] = telev1,
			    ["id2"] = id2, ["lat2"] = lat2, ["lon2"] = lon2,
			    ["dis2"] = displ2, ["bla2"] = blast2,
			    ["gpa2"] = gpa2, ["tch2"] = tch2, ["te2"] = telev2
			}

			rwys[#rwys + 1] = rwy
		end
	end

	io.close(apt_dat_f)

	return arpt_cnt
end

-- Locates all apt.dat files used by X-Plane to display scenery. It consults
-- scenery_packs.ini to determine which scenery packs are currently enabled
-- and together with the default apt.dat returns them in a list sorted
-- numerically in preference order (lowest index for highest priority).
function raas.find_all_apt_dats()
	local apt_dats = {}

	local scenery_packs_ini = io.open(raas.const.xpdir ..
	    "Custom Scenery" .. DIRSEP .. "scenery_packs.ini")

	if scenery_packs_ini ~= nil then
		for line in scenery_packs_ini:lines() do
			if line:find("SCENERY_PACK ", 1, true) == 1 then
				local scn_name = line:sub(14)
				apt_dats[#apt_dats + 1] = raas.const.xpdir ..
				    scn_name .. DIRSEP .. "Earth nav data" ..
				    DIRSEP .. "apt.dat"
			end
		end
		io.close(scenery_packs_ini)
	end

	apt_dats[#apt_dats + 1] = raas.const.xpdir .. "Resources" ..
	    DIRSEP .. "default scenery" .. DIRSEP .. "default apt dat" ..
	    DIRSEP .. "Earth nav data" .. DIRSEP .. "apt.dat"

	return apt_dats
end

-- Reloads the Custom Data/GNS430/navdata/Airports.txt and populates our
-- apt_dat airports with the latest info in it, notably:
-- *) transition altitudes & transition levels for the airports
-- *) runway threshold elevation, glide path angle & threshold crossing height
function raas.load_airports_txt()
	local airports_fname = raas.const.xpdir .. "Custom Data" .. DIRSEP ..
	    "GNS430" .. DIRSEP .. "navdata" .. DIRSEP .. "Airports.txt"
	local fp = io.open(airports_fname)
	local last_arpt = nil

	if fp == nil then
		logMsg("X-RAAS: missing Airports.txt, please check your " ..
		    "navdata and recreate the cache")
		return
	end

	for line in fp:lines() do
		if line:find("A,", 1, true) == 1 then
			local comps = string.split(line, ",")
			local icao = comps[2]
			local lat = tonumber(comps[4])
			local lon = tonumber(comps[5])
			local TA = tonumber(comps[7])
			local TL = tonumber(comps[8])
			local db_arpt = apt_dat[icao]

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
		-- because NOBODY would ever need more than 8191 characters on
		-- a line, right?
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

	fp:write("1 " .. elev .. " 0 0 " .. icao ..
	    " TA:" .. TA .. " TL:" .. TL .. " LAT:" .. lat ..
	    " LON:" .. lon .. "\n")
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
		    " 0 0 0 0 0 0 " ..
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

-- Takes the current state of the apt_dat table and writes all the airports
-- in it to the X-RAAS_apt_dat.cache so that a subsequent run of X-RAAS can
-- pick this info up.
function raas.recreate_apt_dat_cache()
	local version_filename = SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache" ..
	    DIRSEP .. "version"
	local version_file = io.open(version_filename)
	if version_file ~= nil then
		local version = tonumber(version_file:read("*all"))
		version_file:close()
		if version == XRAAS_apt_dat_cache_version then
			-- cache version current, no need to rebuild it
			return
		end
	end

	local apt_dat_files = raas.find_all_apt_dats()
	assert(apt_dat_files ~= nil)

	-- First scan all the provided apt.dat files
	for i = 1, #apt_dat_files do
		raas.map_apt_dat(apt_dat_files[i])
	end
	raas.load_airports_txt()

	raas.remove_directory(SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache")
	raas.create_directories({SCRIPT_DIRECTORY .. "X-RAAS_apt_dat_cache"})
	version_file = io.open(version_filename, "w")
	version_file:write(tostring(XRAAS_apt_dat_cache_version))
	version_file:close()

	local dirs = {}
	local dir_set = {}
	for icao, arpt in pairs(apt_dat) do
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

	for icao, arpt in pairs(apt_dat) do
		if arpt["lat"] ~= nil then
			raas.write_apt_dat(icao, arpt)
		end
	end

	apt_dat = {}
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
-- runway info stored in the apt_dat database into a more easily workable
-- (but more verbose in terms of used memory) format. This function also
-- constructs the transformed threshold coordinates and bounding boxes.
function raas.load_rwy_info(arpt_id, fpp)
	assert(arpt_id ~= nil)
	assert(fpp ~= nil)

	local rwys = {}
	local db_arpt = apt_dat[arpt_id]
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
	local db_arpt = apt_dat[arpt_id]
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
-- search in a specified airport_geo_table square. Position is a 3-space
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
-- for in the apt_dat database and this function returns a table of airport
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
	assert(airport_geo_table[lat] ~= nil)
	local tile = airport_geo_table[lat][lon]

	for icao, coords in pairs(tile) do
		apt_dat[icao] = nil
	end
	airport_geo_table[lat][lon] = nil
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

	for lat_i, lat_tbl in pairs(airport_geo_table) do
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
			airport_geo_table[lat_i] = nil
		end
	end
end

-- Locates any airports within a 8 nm radius of the aircraft and loads
-- their RAAS data from the apt_dat database. The function then updates
-- cur_arpts with the new information and expunges airports that are no
-- longer in range.
function raas.load_nearest_airports()
	local now = os.time()
	if now - last_airport_reload < raas.const.ARPT_RELOAD_INTVAL then
		return
	end
	last_airport_reload = now

	raas.load_nearest_airport_tiles()
	raas.unload_distant_airport_tiles()
	local new_arpts = raas.find_nearest_airports(dr.lat[0], dr.lon[0])

	for arpt_id, arpt in pairs(cur_arpts) do
		if new_arpts[arpt_id] == nil then
			cur_arpts[arpt_id] = nil
		end
	end
	for arpt_id, coords in pairs(new_arpts) do
		if cur_arpts[arpt_id] == nil then
			cur_arpts[arpt_id] = raas.load_airport(arpt_id)
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
-- raas_play_msg for announcing whether the runway is left, center or right.
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

-- Given a runway ID, appends appropriate messages suitable for raas_play_msg
-- to say it out loud.
function raas.rwy_id_to_msg(rwy_id, msg)
	assert(rwy_id ~= nil)
	assert(msg ~= nil)

	msg[#msg + 1] = rwy_id:sub(1, 1)
	msg[#msg + 1] = rwy_id:sub(2, 2)
	msg[#msg + 1] = raas.rwy_lcr_msg(rwy_id)
end

-- Given a distance in meters, converts it into a message suitable for
-- raas_play_msg based on the user's current imperial/metric settings.
function raas.dist_to_msg(dist, msg)
	assert(dist ~= nil)
	assert(msg ~= nil)

	if RAAS_use_imperial then
		local dist_ft = dist * 3.281
		if dist_ft >= 1000 then
			local thousands = math.floor(dist_ft / 1000)
			if thousands > 9 then
				-- we don't have a '10' message
				return false
			end
			msg[#msg + 1] = tostring(thousands)
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
			msg[#msg + 1] = tostring(dist_thousands)
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

	return true
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
		if apch_rwy_ann[arpt_id .. rwy_id] == nil then
			if dr.gs[0] < raas.const.SPEED_THRESH then
				local rwy_name = raas.closest_rwy_end(pos_v,
				    rwy)
				local msg = {"apch"}
				raas.rwy_id_to_msg(rwy_name, msg)
				raas.play_msg(msg, raas.const.MSG_PRIO_LOW)
			end
			apch_rwy_ann[arpt_id .. rwy_id] = true
		end
		return true
	else
		apch_rwy_ann[arpt_id .. rwy_id] = nil
		return false
	end
end

function raas.ground_runway_approach_arpt(arpt, vel_v)
	assert(arpt ~= nil)
	assert(vel_v ~= nil)

	local fpp = arpt["fpp"]
	local pos_v = raas.fpp.sph2fpp({dr.lat[0], dr.lon[0]}, arpt["fpp"])
	local in_prox = false

	for i, rwy in pairs(arpt["rwys"]) do
		local rwy_id = rwy["id1"]
		if raas.ground_runway_approach_arpt_rwy(arpt, rwy_id, rwy,
		    pos_v, vel_v) then
			in_prox = true
		end
	end

	return in_prox
end

function raas.ground_runway_approach()
	local in_prox = false

	if dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH then
		local vel_v = raas.acf_vel_vector(
		    raas.const.RWY_PROXIMITY_TIME_FACT)
		for arpt_id, arpt in pairs(cur_arpts) do
			if raas.ground_runway_approach_arpt(arpt, vel_v) then
				in_prox = true
			end
		end
	end

	if not in_prox then
		if landing then
			raas.dbg.log("flt_state", 1, "landing = false")
		end
		landing = false
	end
end

function raas.perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v)
	assert(rwy_id ~= nil)
	assert(pos_v ~= nil)
	assert(opp_thr_v ~= nil)

	local msg = {"on_rwy"}
	local dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	local flaprqst = dr.flaprqst[0]

	raas.rwy_id_to_msg(rwy_id, msg)
	if dist < RAAS_min_takeoff_dist and not landing and
	    raas.dist_to_msg(dist, msg) then
		msg[#msg + 1] = "rmng"
	end

	if (flaprqst < RAAS_min_takeoff_flap or
	    flaprqst > RAAS_max_takeoff_flap) and not landing and
	    not raas.gpws_flaps_ovrd() then
		msg[#msg + 1] = "flaps"
		msg[#msg + 1] = "flaps"
	end

	raas.play_msg(msg, raas.const.MSG_PRIO_MED)
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
		return
	end

	if on_rwy_timer ~= -1 and
	    ((now - on_rwy_timer > RAAS_on_rwy_warn_initial and
	    on_rwy_warnings == 0) or
	    (now - on_rwy_timer - RAAS_on_rwy_warn_initial >
	    on_rwy_warnings * RAAS_on_rwy_warn_repeat)) and
	    on_rwy_warnings < RAAS_on_rwy_warn_max_n then
		on_rwy_warnings = on_rwy_warnings + 1
		raas.perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v)
	end

	if rhdg > raas.const.HDG_ALIGN_THRESH then
		on_rwy_ann[arpt_id .. rwy_id] = nil
		return
	end

	if on_rwy_ann[arpt_id .. rwy_id] == nil then
		if dr.gs[0] < raas.const.SPEED_THRESH then
			raas.perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v)
		end
		on_rwy_ann[arpt_id .. rwy_id] = true
	end
end

function raas.stop_check_reset(arpt_id, rwy_id)
	assert(arpt_id ~= nil)
	assert(rwy_id ~= nil)

	if accel_stop_max_spd[arpt_id .. rwy_id] ~= nil then
		accel_stop_max_spd[arpt_id .. rwy_id] = nil
		accel_stop_ann_initial = 0
		for i, info in pairs(RAAS_accel_stop_distances) do
			info["ann"] = false
		end
	end
end

function raas.takeoff_rwy_dist_check(opp_thr_v, pos_v)
	assert(opp_thr_v ~= nil)
	assert(pos_v ~= nil)

	if short_rwy_takeoff_chk then
		return
	end

	local dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	short_rwy_takeoff_chk = true
	if dist < RAAS_min_takeoff_dist then
		raas.play_msg({"caution", "short_rwy", "short_rwy"},
		    raas.const.MSG_PRIO_HIGH)
	end
end

function raas.perform_rwy_dist_remaining_callouts(opp_thr_v, pos_v)
	assert(opp_thr_v ~= nil)
	assert(pos_v ~= nil)

	local dist = raas.vect2.abs(raas.vect2.sub(opp_thr_v, pos_v))
	local msg = {}

	if accel_stop_ann_initial == 0 then
		accel_stop_ann_initial = dist
		if raas.dist_to_msg(dist, msg) then
			msg[#msg + 1] = "rmng"
			raas.play_msg(msg, raas.const.MSG_PRIO_MED)
		end
	elseif dist < accel_stop_ann_initial - raas.const.STOP_INIT_DELAY
	    then
		for i, info in pairs(RAAS_accel_stop_distances) do
			local min = info["min"]
			local max = info["max"]
			local ann = info["ann"]

			if dist < RAAS_accel_stop_dist_cutoff and
			    dist > min and dist < max and not ann then
				local msg = {}
				raas.dist_to_msg(dist, msg)
				msg[#msg + 1] = "rmng"
				info["ann"] = true
				raas.play_msg(msg, raas.const.MSG_PRIO_MED)
				break
			end
		end
	end
end

function raas.acf_rwy_rel_pitch(te, ote, len)
	assert(te ~= nil)
	assert(ote ~= nil)
	assert(len ~= nil)

	local rwy_angle = math.deg(math.asin((ote - te) / len))
	return dr.pitch[0] - rwy_angle
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
			    pos_v, msg)
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
		if departed and
		    dr.rad_alt[0] <= raas.const.RADALT_FLARE_THRESH and
		    raas.conv_per_min(raas.m2ft(dr.elev[0] - last_elev)) <
		    raas.const.GOAROUND_CLB_RATE_THRESH then
			if (dist < len / 2 or (dist <= RAAS_min_landing_dist and
			    len >= RAAS_min_landing_dist)) then
				if not long_landing_ann then
					local msg = {"long_land", "long_land"}
					long_landing_ann = true
					if raas.dist_to_msg(dist, msg) then
						msg[#msg + 1] = "rmng"
					end
					raas.play_msg(msg,
					    raas.const.MSG_PRIO_HIGH)
				else
					raas.
					    perform_rwy_dist_remaining_callouts(
					    opp_thr_v, pos_v)
				end
			end
		end
		return
	end

	if not arriving then
		raas.takeoff_rwy_dist_check(opp_thr_v, pos_v)
	end

	maxspd = accel_stop_max_spd[arpt_id .. rwy_id]
	if maxspd == nil or gs > maxspd then
		accel_stop_max_spd[arpt_id .. rwy_id] = gs
		maxspd = gs
	end
	local rpitch = raas.acf_rwy_rel_pitch(te, ote, rwy["len"])
	if gs < maxspd - raas.const.ACCEL_STOP_SPD_THRESH or landing or
	    (dist < RAAS_min_rotation_dist and
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

	for arpt_id, arpt in pairs(cur_arpts) do
		if raas.ground_on_runway_aligned_arpt(arpt) then
			on_rwy = true
		end
	end

	if on_rwy and dr.gs[0] < raas.const.STOPPED_THRESH then
		if on_rwy_timer == -1 then
			on_rwy_timer = os.time()
		end
	else
		on_rwy_timer = -1
		on_rwy_warnings = 0
	end

	if not on_rwy then
		short_rwy_takeoff_chk = false
	end

	-- Taxiway takeoff check
	if not on_rwy and dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH and
	    ((not landing and dr.gs[0] >= raas.const.SPEED_THRESH) or
	    (landing and dr.gs[0] >= raas.const.HIGH_SPEED_THRESH)) then
		if not on_twy_ann then
			on_twy_ann = true
			raas.play_msg({"caution", "on_twy", "on_twy"},
			    raas.const.MSG_PRIO_HIGH)
		end
	elseif dr.gs[0] < raas.const.SPEED_THRESH or
	    dr.rad_alt[0] >= raas.const.RADALT_GRD_THRESH then
		on_twy_ann = false
	end

	return on_rwy
end

function raas.gpa_limit(gpa)
	assert(gpa ~= nil)
	return math.min(gpa * RAAS_gpa_limit_mult, RAAS_gpa_limit_max)
end

function raas.apch_config_chk(arpt_id, rwy_id, alt, elev, gpa_act, rwy_gpa,
    ceil, floor, msg, ann_table, critical)
	assert(arpt_id ~= nil)
	assert(rwy_id ~= nil)
	assert(alt ~= nil)
	assert(elev ~= nil)
	assert(gpa_act ~= nil)
	assert(rwy_gpa ~= nil)
	assert(ceil ~= nil)
	assert(floor ~= nil)
	assert(msg ~= nil)
	assert(ann_table ~= nil)
	assert(critical ~= nil)

	if not ann_table[arpt_id .. rwy_id] and
	    alt - elev < ceil and alt - elev > floor then
		raas.dbg.log("apch_conf_chk", 2, "check at " .. ceil .. "/" ..
		    floor)
		raas.dbg.log("apch_conf_chk", 2, "gpa_act = " .. gpa_act ..
		    " rwy_gpa = " .. rwy_gpa)
		if dr.flaprqst[0] < RAAS_min_landing_flap then
			raas.dbg.log("apch_conf_chk", 1, "FLAPS: " ..
			    "flaprqst = " .. dr.flaprqst[0] ..
			    " min_flap = " .. RAAS_min_landing_flap)
			if not raas.gpws_flaps_ovrd() then
				if not critical then
					msg[#msg + 1] = "flaps"
					msg[#msg + 1] = "flaps"
				else
					msg[#msg + 1] = "unstable"
					msg[#msg + 1] = "unstable"
				end
			else
				raas.dbg.log("apch_conf_chk", 1, "FLAPS: " ..
				    "flaps ovrd active")
			end
			ann_table[arpt_id .. rwy_id] = true
			return true
		elseif rwy_gpa ~= 0 and not raas.gear_is_up() and
		    gpa_act > raas.gpa_limit(rwy_gpa) then
			raas.dbg.log("apch_conf_chk", 1, "TOO HIGH: " ..
			    "gpa_limit = " .. raas.gpa_limit(rwy_gpa))
			if not raas.gpws_terr_ovrd() then
				if not critical then
					msg[#msg + 1] = "too_high"
					msg[#msg + 1] = "too_high"
				else
					msg[#msg + 1] = "unstable"
					msg[#msg + 1] = "unstable"
				end
			else
				raas.dbg.log("apch_conf_chk", 1,
				    "TOO HIGH: " .. "terr ovrd active")
			end
			ann_table[arpt_id .. rwy_id] = true
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

		if raas.apch_config_chk(arpt_id, rwy_id, alt, telev + tch,
		    gpa_act, rwy_gpa, raas.const.RWY_APCH_FLAP1_THRESH,
		    raas.const.RWY_APCH_FLAP2_THRESH, msg, air_apch_flap1_ann,
		    false) or
		    raas.apch_config_chk(arpt_id, rwy_id, alt, telev + tch,
		    gpa_act, rwy_gpa, raas.const.RWY_APCH_FLAP2_THRESH,
		    raas.const.RWY_APCH_FLAP3_THRESH, msg, air_apch_flap2_ann,
		    false) or
		    raas.apch_config_chk(arpt_id, rwy_id, alt, telev + tch,
		    gpa_act, rwy_gpa, raas.const.RWY_APCH_FLAP3_THRESH,
		    raas.const.RWY_APCH_FLAP4_THRESH, msg, air_apch_flap3_ann,
		    true) then
			msg_prio = raas.const.MSG_PRIO_HIGH
		end

		-- If we are below 700 ft AFE and we haven't annunciated yet
		if alt - telev < raas.const.RWY_APCH_ALT_MAX and
		    air_apch_rwy_ann[arpt_id .. rwy_id] == nil and
		    not raas.number_in_rngs(alt - telev,
		    raas.const.RWY_APCH_SUPP_WINDOWS) then
			-- Don't annunciate if we are too low
			if alt - telev > raas.const.RWY_APCH_ALT_MIN then
				msg[#msg + 1] = "apch"
				raas.rwy_id_to_msg(rwy_id, msg)
				if rwy["llen" .. suffix] <
				    RAAS_min_landing_dist then
					msg[#msg + 1] = "caution"
					msg[#msg + 1] = "short_rwy"
					msg[#msg + 1] = "short_rwy"
					msg_prio = raas.const.MSG_PRIO_HIGH
				end
			end
			air_apch_rwy_ann[arpt_id .. rwy_id] = true
		end

		if not table.isempty(msg) then
			raas.play_msg(msg, msg_prio)
		end

		return true
	elseif air_apch_rwy_ann[arpt_id .. rwy_id] ~= nil and
	    not in_prox_bbox then
		air_apch_rwy_ann[arpt_id .. rwy_id] = nil
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

	local in_apch_bbox = false
	local alt = raas.m2ft(dr.elev[0])
	local hdg = dr.hdg[0]
	local arpt_id = arpt["arpt_id"]
	local elev = arpt["elev"]
	if alt > elev + raas.const.RWY_APCH_FLAP1_THRESH or alt < elev then
		raas.reset_airport_approach_table(air_apch_flap1_ann, arpt_id)
		raas.reset_airport_approach_table(air_apch_flap2_ann, arpt_id)
		raas.reset_airport_approach_table(air_apch_rwy_ann, arpt_id)
		return false
	end

	local pos_v = raas.fpp.sph2fpp({dr.lat[0], dr.lon[0]}, arpt["fpp"])
	local hdg = dr.hdg[0]

	for i, rwy in pairs(arpt["rwys"]) do
		if raas.air_runway_approach_arpt_rwy(arpt, rwy, "1", pos_v,
		    hdg, alt) or raas.air_runway_approach_arpt_rwy(arpt, rwy,
		    "2", pos_v, hdg, alt) or
		    raas.vect2.in_poly(pos_v, rwy["rwy_bbox"]) then
			in_apch_bbox = true
		end
	end

	return in_apch_bbox
end

function raas.air_runway_approach()
	if dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH then
		return
	end

	local in_apch_bbox = false
	local clb_rate = raas.conv_per_min(raas.m2ft(dr.elev[0] - last_elev))

	for arpt_id, arpt in pairs(cur_arpts) do
		if raas.air_runway_approach_arpt(arpt) then
			in_apch_bbox = true
			break
		end
	end

	-- If we are neither over an approach bbox nor a runway, and we're
	-- not climbing and we're in a landing configuration, we're most
	-- likely trying to land onto something that's not a runway
	if not in_apch_bbox and clb_rate < 0 and not raas.gear_is_up() and
	    dr.flaprqst[0] >= RAAS_min_landing_flap then
		if dr.rad_alt[0] <= raas.const.OFF_RWY_HEIGHT_MAX then
			-- only annunciate if we're above the minimum height
			if dr.rad_alt[0] >= raas.const.OFF_RWY_HEIGHT_MIN and
			    not off_rwy_ann and not raas.gpws_terr_ovrd() then
				raas.play_msg({"caution", "twy", "caution",
				    "twy"}, raas.const.MSG_PRIO_HIGH)
			end
			off_rwy_ann = true
		else
			-- Annunciation gets reset once we climb through
			-- the maximum annunciation altitude.
			off_rwy_ann = false
		end
	end
end

function raas.find_nearest_curarpt()
	local min_dist = raas.const.ARPT_LOAD_LIMIT
	local pos_ecef = raas.conv.sph2ecef({dr.lat[0], dr.lon[0]})
	local cur_arpt

	for arpt_id, arpt in pairs(cur_arpts) do
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
		TA = cur_arpt["TA"]
		TL = cur_arpt["TL"]
		TATL_field_elev = cur_arpt["elev"]
		if arpt_id ~= TATL_source then
			TATL_source = arpt_id
			field_changed = true
			raas.dbg.log("altimeter", 1, "TATL_source: " ..
			    arpt_id .. " TA: " .. TA .. " TL: " .. TL ..
			    " field_elev: " .. TATL_field_elev)
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

		if outID ~= nil and TATL_source ~= outID and
		    vect3.abs(vect3.sub(pos_ecef, arpt_ecef)) <
		    const.TATL_REMOTE_ARPT_DIST_LIMIT then
			raas.load_airports_in_tile(outLat, outLon)
			db_arpt = apt_dat[outID]
			if db_arpt == nil then
				-- Grab the first airport in that tile
				local lat_i, lon_i = raas.geo_table_idx(outLat,
				    outLon)
				local tile = raas.geo_table_get_tile(lat_i,
				    lon_i, false)
				if tile ~= nil and not table.isempty(tile) then
					local icao = next(tile)
					db_arpt = apt_dat[icao]
					raas.dbg.log("altimeter", 2,
					    "fallback airport = " ..
					    tostring(icao))
				end
			end
		end

		if db_arpt ~= nil then
			TA = db_arpt["TA"]
			TL = db_arpt["TL"]
			TATL_field_elev = db_arpt["elev"]
			TATL_source = outID
			field_changed = true
			raas.dbg.log("altimeter", 1, "TATL_source: " ..
			    outID .. " TA: " .. TA .. " TL: " .. TL ..
			    " field_elev: " .. TATL_field_elev)
		end
	end

	if TL == 0 then
		if field_changed then
			raas.dbg.log("altimeter", 3, "TL = 0")
		end
		if TA ~= 0 then
			if dr.baro_sl[0] > const.STD_BARO_REF then
				TL = TA
			else
				local qnh = dr.baro_sl[0] * 33.85
				TL = TA + 28 * (1013 - qnh)
			end
			if field_changed then
				raas.dbg.log("altimeter", 1,
				    "TL(auto) = " .. TL)
			end
		end
	end
	if TA == 0 then
		if field_changed then
			raas.dbg.log("altimeter", 1, "TA(auto) = " .. TA)
		end
		TA = TL
	end

	local elev = raas.m2ft(dr.elev[0])

	if TA ~= 0 and elev > TA and TATL_state == "alt" then
		TATL_transition = os.time()
		TATL_state = "fl"
		raas.dbg.log("altimeter", 1, "elev > TA (" .. TA ..
		    ") transitioning TATL_state = fl")
	end
	if TL ~= 0 and elev < TA and dr.baro_alt[0] < TL and
	    -- If there's a gap between the altitudes and flight levels, don't
	    -- transition until we're below the TA
	    (TA == 0 or elev < TA) and TATL_state == "fl" then
		TATL_transition = os.time()
		TATL_state = "alt"
		raas.dbg.log("altimeter", 1, "baro_alt < TL (" .. TL ..
		    ") transitioning TATL_state = alt")
	end

	local now = os.time()
	if TATL_transition ~= -1 then
		if  -- We have transitioned into ALT mode
		    TATL_state == "alt" and
		    -- The fixed timeout has passed, OR
		    (now - TATL_transition > const.ALTM_SETTING_TIMEOUT or
		    -- The field has a known elevation and we are within
		    -- 1500 feet of it
		    (TATL_field_elev ~= nil and (elev < TATL_field_elev +
		    const.ALTM_SETTING_ALT_CHK_LIMIT))) then
			local d_qnh, d_qfe = 0, 0

			if RAAS_qnh_alt_enabled then
				d_qnh = math.abs(elev - dr.baro_alt[0])
			end
			if TATL_field_elev ~= nil and RAAS_qfe_alt_enabled then
				d_qfe = math.abs(dr.baro_alt[0] -
				    (elev - TATL_field_elev))
			end
			raas.dbg.log("altimeter", 1, "alt check; d_qnh: "
			    .. d_qnh .. " d_qfe: " .. tostring(d_qfe))
			if  -- The set baro is out of bounds for QNH, OR
			    d_qnh > const.ALTIMETER_SETTING_QNH_ERR_LIMIT or
			    -- Set baro is out of bounds for QFE
			    d_qfe > const.ALTM_SETTING_QFE_ERR_LIMIT then
				raas.play_msg({"alt_set"}, const.MSG_PRIO_LOW)
			end
			TATL_transition = -1
		elseif TATL_state == "fl" and now - TATL_transition >
		    const.ALTM_SETTING_TIMEOUT then
			local d_ref = math.abs(dr.baro_set[0] -
			    const.STD_BARO_REF)
			raas.dbg.log("altimeter", 1, "fl check; d_ref: " ..
			    d_ref)
			if d_ref > const.ALTM_SETTING_BARO_ERR_LIMIT then
				raas.play_msg({"alt_set"}, const.MSG_PRIO_LOW)
			end
			TATL_transition = -1
		end
	end
end

-- Transfers our electrical load to bus number `busnr' (numbered from 0)
function raas_xfer_elec_bus(busnr)
	local xbusnr = (busnr + 1) % 2
	if bus_loaded == xbusnr then
		dr.plug_bus_load[xbusnr] = dr.plug_bus_load[xbusnr] -
		    raas.const.BUS_LOAD_AMPS
		bus_loaded = -1
	end
	if bus_loaded == -1 then
		dr.plug_bus_load[busnr] = dr.plug_bus_load[busnr] +
		    raas.const.BUS_LOAD_AMPS
		bus_loaded = busnr
	end
end

-- Returns true if X-RAAS has electrical power from the aircraft.
function raas_is_on()
	if RAAS_override_electrical then
		return true
	end

	local turned_on

	turned_on = ((dr.bus_volt[0] > raas.const.MIN_BUS_VOLT or
	    dr.bus_volt[1] > raas.const.MIN_BUS_VOLT) and
	    dr.avionics_on[0] == 1 and dr.gpws_warn[0] ~= 1)

	if turned_on then
		if dr.bus_volt[0] < raas.const.MIN_BUS_VOLT then
			raas_xfer_elec_bus(1)
		else
			raas_xfer_elec_bus(0)
		end
	elseif bus_loaded ~= -1 then
		dr.plug_bus_load[bus_loaded] = dr.plug_bus_load[bus_loaded] -
		    raas.const.BUS_LOAD_AMPS
		bus_loaded = -1
	end

	return turned_on
end

function raas.exec()
	local now = os.clock()
	local time_s, time_e

	-- Before we start, wait a set delay, because X-Plane's datarefs
	-- needed for proper init are unstable, so we'll give them an
	-- extra second to fix themselves
	if now - raas_start_time < raas.const.STARTUP_DELAY or
	    now - raas_last_exec_time < raas.const.EXEC_INTVAL or
	    not raas_is_on() then
		return
	end
	raas_last_exec_time = now

	raas.load_nearest_airports(nil)

	if dr.rad_alt[0] > raas.const.RADALT_FLARE_THRESH then
		if not departed then
			departed = true
			raas.dbg.log("flt_state", 1, "departed = true")
		end
		if not arriving then
			arriving = true
			raas.dbg.log("flt_state", 1, "arriving = true")
		end
		long_landing_ann = false
	elseif dr.rad_alt[0] < raas.const.RADALT_GRD_THRESH then
		if departed then
			raas.dbg.log("flt_state", 1, "landing = true")
			raas.dbg.log("flt_state", 1, "departed = false")
			landing = true
		end
		departed = false
		if dr.gs[0] < raas.const.SPEED_THRESH then
			arriving = false
		end
	end
	if dr.gs[0] < raas.const.SPEED_THRESH then
		long_landing_ann = false
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

	last_elev = dr.elev[0]
end

function raas.shutdown()
	if bus_loaded ~= -1 then
		dr.plug_bus_load[bus_loaded] = dr.plug_bus_load[bus_loaded] -
		    raas.const.BUS_LOAD_AMPS
		bus_loaded = -1
	end
	if cur_msg["snd"] ~= nil then
		stop_sound(cur_msg["snd"])
		cur_msg = {}
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
	if not raas_is_on() then
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

function raas.play_msg(msg, prio)
	assert(prio ~= nil)
	-- suppress message if GPWS is blaring an alert
	if dr.gpws_ann[0] ~= 0 then
		return
	end
	if not table.isempty(cur_msg) then
		if cur_msg["prio"] > prio then
			return
		end
		if cur_msg["snd"] ~= nil then
			stop_sound(cur_msg["snd"])
		end
		cur_msg = {}
	end

	cur_msg["msg" ] = msg
	cur_msg["playing"] = 0
	cur_msg["prio"] = prio
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
	if table.isempty(cur_msg) then
		return
	end

	-- Make sure our messages are only audible when we're inside
	-- the cockpit and AC power is on
	if view_is_ext and (dr.ext_view[0] == 0 or
	    not RAAS_disable_ext_view) then
		raas.set_sound_on(true)
		view_is_ext = false
	elseif not view_is_ext and dr.ext_view[0] == 1 then
		raas.set_sound_on(false)
		view_is_ext = true
	end

	-- stop audio when power is down or if the GPWS is sounding an alert
	if not raas_is_on() or dr.gpws_ann[0] ~= 0 then
		if cur_msg["snd"] ~= nil then
			stop_sound(cur_msg["snd"])
		end
		cur_msg = {}
		return
	end

	local now = os.clock()
	local started = cur_msg["started"]
	local playing = cur_msg["playing"]

	if started == nil or started < now -
	    messages[cur_msg["msg"][playing]]["dur"] - 0.1 then
		if playing == nil then
			playing = 1
		else
			playing = playing + 1
		end
		if playing > #cur_msg["msg"] then
			cur_msg = {}
			return
		end

		local msg = messages[cur_msg["msg"][playing]]
		cur_msg["started"] = now
		cur_msg["playing"] = playing
		cur_msg["snd"] = msg["snd"]
		play_sound(msg["snd"])
	end
end

function load_config(cfgname)
	local cfg_f = io.open(cfgname)
	if cfg_f ~= nil then
		cfg_f:close()
		--local cfg = cfg_f:read("*all")
		local f, err = loadfile(cfgname)
		if f ~= nil then
			f()
		else
			raas.init_msg = "X-RAAS: syntax error in config " ..
			    "file: " .. tostring(err)
			logMsg(raas.init_msg)
		end
	end
end

function raas.load_configs()
	load_config(SCRIPT_DIRECTORY .. "X-RAAS.cfg")
	load_config(AIRCRAFT_PATH .. "X-RAAS.cfg")
end

function raas.show_init_msg()
	local graphics = require 'graphics'
	if not raas.init_msg then
		return
	end
	if os.clock() - raas_start_time > raas.const.INIT_MSG_TIMEOUT then
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

raas.load_configs()
raas.reset()

if raas.init_msg then
	do_every_draw('raas.show_init_msg()')
	return
end

if not RAAS_enabled then
	logMsg("X-RAAS: DISABLED")
	return
elseif dr.num_engines[0] < RAAS_min_engines or dr.mtow[0] < RAAS_min_MTOW then
	local msg = "X-RAAS: auto-disabled due to aircraft parameters:\n" ..
	    "  Your aircraft: (" .. dr.ICAO[0] .. ") #engines: " ..
	    dr.num_engines[0] .. "; MTOW: " .. math.floor(dr.mtow[0]) ..
	    " kg\n" ..
	    "  X-RAAS configuration: minimum #engines: " .. RAAS_min_engines
	    .. "; minimum MTOW: " ..RAAS_min_MTOW .. " kg\n" ..
	    "  If you don't know what this means, refer to the user manual " ..
	    "in X-RAAS_docs" .. DIRSEP .. "manual.pdf, Section 2 " ..
	    "\"Activating X-RAAS in the aircraft\"."
	logMsg(msg)
	if RAAS_auto_disable_notify then
		raas.init_msg = msg
		do_every_draw('raas.show_init_msg()')
	end
	return
else
	logMsg("X-RAAS: ENABLED")
end

raas.load_msg_table()
raas.map_apt_dats()

do_every_frame('raas.exec()')
do_every_draw('raas.snd_sched()')

-- FlyWithLua prior to 2.4.1 didn't have do_on_exit
if do_on_exit ~= nil then
	do_on_exit('raas.shutdown()')
end

-- Uncomment the line below to get a nice debug display
if RAAS_debug_graphical then
	do_every_draw('raas.dbg.draw()')
end
