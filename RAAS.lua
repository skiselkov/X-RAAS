--[[

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
		*) Height above field is less than 5000 feet
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
	    Message: "XXXX THOUSAND [METERS|FEET] REMAINING"
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
		*) Decelerated 7 knots below max ground speed
		*) Aircraft on last half of runway
		*) Ground speed above 40 knots

	16) Too fast on approach
	    Message: "TOO FAST! TOO FAST!" or "UNSTABLE! UNSTABLE!"
	    Conditions:
		*) TBD

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

local HDG_ALIGN_THRESH = 25			-- degrees
local SPEED_THRESH = 20.5			-- m/s, 40 knots
local STOPPED_THRESH = 1.55			-- m/s, 3 knots
local EARTH_MSL = 6371000			-- meters
local RAAS_PROXIMITY_LAT_FRACT = 3
local RAAS_PROXIMITY_LON_DISPL = 305		-- meters, 1000 ft
local RAAS_PROXIMITY_TIME_FACT = 2
local RADALT_GRD_THRESH = 5
local RADALT_FLARE_THRESH = 50
local RAAS_STARTUP_DELAY = 3			-- seconds
local RWY_DISPLACED_THR_MARGIN = 10
local ARPT_RELOAD_INTVAL = 10			-- seconds
local ARPT_LOAD_THRESH = 7 * 1852		-- 7nm
local ACCEL_STOP_SPD_THRESH = 2.6		-- m/s, 5 knots
local STOP_INIT_DELAY = 300

local RAAS_APCH_PROXIMITY_LAT_ANGLE = 4		-- degrees
local RAAS_APCH_PROXIMITY_LON_DISPL = 5500	-- meters
local RAAS_APCH_FLAP1_THRESH = 950		-- feet
local RAAS_APCH_FLAP2_THRESH = 600		-- feet
local RAAS_APCH_ALT_THRESH = 470		-- feet
local RAAS_APCH_ALT_WINDOW = 270		-- feet

-- config stuff (to be overridden by acf)
local use_imperial = true
local min_takeoff_dist = 1000			-- meters
local min_landing_dist = 900			-- meters
local accel_stop_dist_cutoff = 3000		-- meters
local voice_gender = "female"
local min_landing_flap = 0.5			-- ratio
local min_takeoff_flap = 0.1			-- ratio
local max_takeoff_flap = 0.75			-- ratio

local on_rwy_warn_initial = 60			-- seconds
local on_rwy_warn_repeat = 60			-- seconds
local on_rwy_warn_max_n = 5

-- precomputed, since it doesn't change
local RAAS_APCH_PROXIMITY_LAT_DISPL = RAAS_APCH_PROXIMITY_LON_DISPL *
    math.tan(math.rad(RAAS_APCH_PROXIMITY_LAT_ANGLE))

local dr_gs, dr_baro_alt, dr_rad_alt, dr_lat, dr_lon, dr_hdg, dr_magvar,
    dr_nw_offset, dr_flaprqst
local cur_arpts = {}
local raas_start_time = nil
local last_airport_reload = 0

local airport_geo_table = {}
local apt_dat = {}

local dbg_enabled = false

local raas_on_rwy_ann = {}
local raas_apch_rwy_ann = {}
local raas_air_apch_rwy_ann = {}
local raas_air_apch_flap1_ann = {}
local raas_air_apch_flap2_ann = {}
local on_twy_ann = false
local long_landing_ann = false
local short_rwy_takeoff_chk = false
local on_rwy_timer = -1
local on_rwy_warnings = 0

local raas_accel_stop_max_spd = {}
local raas_accel_stop_ann_initial = 0
local raas_accel_stop_distances = {
	-- Because we examine these ranges in 1 second intervals, there is
	-- a maximum speed at which we are guaranteed to announce the distance
	-- remaining. The ranges are configured so as to allow for a healthy
	-- maximum speed margin over anything that could be reasonably attained
	-- over that portion of the runway.
	{["max"] = 2864, ["min"] = 2743},	-- 9400-9000 ft, maxspd 235 KT
	{["max"] = 2560, ["min"] = 2439},	-- 8400-8000 ft, maxspd 235 KT
	{["max"] = 2255, ["min"] = 2134},	-- 7400-7000 ft, maxspd 235 KT
	{["max"] = 1950, ["min"] = 1828},	-- 6400-6000 ft, maxspd 235 KT
	{["max"] = 1645, ["min"] = 1524},	-- 5400-5000 ft, maxspd 235 KT
	{["max"] = 1341, ["min"] = 1220},	-- 4400-4000 ft, maxspd 235 KT
	{["max"] = 1036, ["min"] = 915},	-- 3400-3000 ft, maxspd 235 KT
	{["max"] = 731, ["min"] = 610},		-- 2400-2000 ft, maxspd 235 KT
	{["max"] = 426, ["min"] = 305},		-- 1400-1000 ft, maxspd 235 KT
	{["max"] = 213, ["min"] = 153},		-- 700-500 ft, maxspd 118 KT
	{["max"] = 60, ["min"] = 31}		-- 200-100 ft, maxspd 59 KT
}
local airborne = false
local departed = false

local messages = {
	["0"] = {}, ["1"] = {}, ["2"] = {}, ["3"] = {}, ["4"] = {},
	["5"] = {}, ["6"] = {}, ["7"] = {}, ["8"] = {}, ["9"] = {},
	["alt_set"] = {}, ["apch"] = {}, ["caution"] = {}, ["flaps"] = {},
	["hundred"] = {}, ["left"] = {}, ["long_land"] = {}, ["on_rwy"] = {},
	["on_twy"] = {}, ["right"] = {}, ["rmng"] = {}, ["short_rwy"] = {},
	["thousand"] = {}, ["too_fast"] = {}, ["too_high"] = {}, ["twy"] = {},
	["unstable"] = {}
}
local cur_msg = {}

--[[
   Author: Julio ]Manuel Fernandez-Diaz
   Date:   January 12, 2007
   (For Lua 5.1)

   Modified slightly by RiciLake to avoid the unnecessary table traversal in tablecount()

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
local function isemptytable(t)
	return next(t) == nil
end

function geo_table_idx(latlon)
	return math.floor(latlon)
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
				if isemptytable(value) then
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

function matrix_mul(x, y, xrows, ycols, sz)
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

function split(str, sep)
	local res = {}
	local s = 1
	while true do
		local e = str:find(sep, s)
		if e == nil then
			break
		end
		res[#res + 1] = str:sub(s, e - #sep)
		s = e + #sep
	end
	res[#res + 1] = str:sub(s)
	return res
end

function rel_hdg(hdg1, hdg2)
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

local function m2ft(m)
	return m * 3.281
end

local function ft2m(ft)
	return m / 3.281
end

function vect2_abs(a)
	return math.sqrt((a[1] * a[1]) + (a[2] * a[2]))
end

function vect2_dist(a, b)
	return vect2_abs(vect2_sub(a, b))
end

function vect2_set_abs(a, abs)
	local oldval = vect2_abs(a)
	if oldval ~= 0 then
		return vect2_scmul(a, abs / oldval), oldval
	else
		return a, 0
	end
end

function vect2_unit(a)
	local len = vect2_abs(a)
	if len == 0 then
		return a, 0
	else
		return {a[1] / len, a[2] / len}
	end
end

function vect2_add(a, b)
	return {a[1] + b[1], a[2] + b[2]}
end

function vect2_sub(a, b)
	return {a[1] - b[1], a[2] - b[2]}
end

function vect2_scmul(a, x)
	return {a[1] * x, a[2] * x}
end

function vect2_dotprod(a, b)
	return a[1] * b[1] + a[2] * b[2]
end

function vect2_norm(v, right)
	if right then
		return {v[2], -v[1]}
	else
		return {-v[2], v[1]}
	end
end

local function vect2_rot(v, angle)
	local sin_angle = math.sin(math.rad(angle))
	local cos_angle = math.cos(math.rad(angle))
	return {v[1] * cos_angle - v[2] * sin_angle,
	    v[1] * sin_angle + v[2] * cos_angle}
end

local function vect2_neg(v)
	return {-v[1], -v[2]}
end

local function hdg2dir(hdg)
	return {math.sin(math.rad(hdg)), math.cos(math.rad(hdg))}
end

local function dir2hdg(dir)
	if dir[1] >= 0 and dir[2] >= 0 then
		return math.deg(math.asin(dir[1] / vect2_abs(dir)))
	elseif dir[1] < 0 and dir[2] >= 0 then
		return 360 + math.deg(math.asin(dir[1] / vect2_abs(dir)))
	else
		return 180 - math.deg(math.asin(dir[1] / vect2_abs(dir)))
	end
end

local function vect2_parallel(a, b)
	return (a[2] == 0 and b[2] == 0) or ((a[1] / a[2]) == (b[1] / b[2]))
end

local function vect2_eq(a, b)
	return a[1] == b[1] and a[2] == b[2]
end

local function vect2vect_isect(a, oa, b, ob, confined)
	if vect2_parallel(a, b) then
		return nil
	end
	if vect2_eq(oa, ob) then
		return oa
	end
	local p1 = oa
	local p2 = vect2_add(oa, a)
	local p3 = ob
	local p4 = vect2_add(ob, b)

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

local function vect2poly_isect(a, oa, poly)
	local res = {}

	for i = 0, #poly - 1 do
		local pt1 = poly[i + 1]
		local pt2 = poly[((i + 1) % #poly) + 1]
		local v = vect2_sub(pt2, pt1)
		local isect = vect2vect_isect(a, oa, v, pt1, true)
		if isect ~= nil then
			res[#res + 1] = isect
		end
	end

	return res
end

local function point_in_poly(pt, poly)
	-- Simplest approach is ray casting. Construct a vector from `pt' to
	-- a point very far away and count how many edges of the bbox polygon
	-- we hit. If we hit an even number, we're outside, otherwise we're
	-- inside.
	local v = vect2_sub({1000000, 1000000}, pt)
	local isects = vect2poly_isect(v, pt, poly)
	return (#isects % 2) ~= 0
end

local function vect3_unit(v)
	local len = vect3_abs(v)
	if len == 0 then
		return nil
	else
		return {v[1] / len, v[2] / len, v[3] / len}, len
	end
end

local function vect3_add(a, b)
	return {a[1] + b[1], a[2] + b[2] , a[3] + b[3]}
end

local function vect3_sub(a, b)
	return {a[1] - b[1], a[2] - b[2] , a[3] - b[3]}
end

local function vect3_abs(a)
	return math.sqrt(a[1] * a[1] + a[2] * a[2] + a[3] * a[3])
end

local function vect3_scmul(a, b)
	return {a[1] * b, a[2] * b, a[3] * b}
end

local function vect3_dotprod(a, b)
	return a[1] * b[1] + a[2] * b[2] + a[3] * b[3]
end

local function vect2sph_isect(v, o, c, r, confined)
	local l, d = vect3_unit(v)
	local o_min_c = vect3_sub(o, c)
	local l_dot_o_min_c = vect3_dotprod(l, o_min_c)
	local o_min_c_abs = vect3_abs(o_min_c)
	local sqrt_tmp = (l_dot_o_min_c * l_dot_o_min_c) -
	    (o_min_c_abs * o_min_c_abs) + (r * r)
	local i = {}

	if sqrt_tmp > 0 then
		-- Two solutions
		local i_d
		sqrt_tmp = math.sqrt(sqrt_tmp)
		i_d = -l_dot_o_min_c - sqrt_tmp
		if not confined or (i_d >= 0 and i_d <= d) then
			i[#i + 1] = vect3_add(vect3_scmul(l, i_d), o)
		end
		i_d = -l_dot_o_min_c + sqrt_tmp
		if not confined or (i_d >= 0 and i_d <= d) then
			i[#i + 1] = vect3_add(vect3_scmul(l, i_d), o)
		end
		return i
	elseif sqrt_tmp == 0 then
		-- One solution
		local i_d = -l_dot_o_min_c
		if not confined or (i_d >= 0 and i_d <= d) then
			i[#i + 1] = vect3_add(vect3_scmul(l, i_d), o)
		end
		return i
	else
		-- No solutions
		return {}
	end
end

local function sph_xlate_init(displac, rot, inv)
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
		xlate[1] = matrix_mul(R_a, R_b, 3, 3, 3)
	else
		xlate[1] = matrix_mul(R_b, R_a, 3, 3, 3)
	end

	-- The rotation matrix
	xlate[2] = {
	    cos_theta, -sin_theta,
	    sin_theta, cos_theta
	}

	return xlate
end

local function sph_xlate_vect(p, xlate)
	local q = matrix_mul(xlate[1], p, 3, 1, 3)
	local r = {q[2], q[3]}
	local s = matrix_mul(xlate[2], r, 2, 1, 2)
	q[2] = s[1]
	q[3] = s[2]
	return q
end

local function sph2ecef(pos)
	local lat_rad = math.rad(pos[1])
	local lon_rad = math.rad(pos[2])
	local R0 = EARTH_MSL * math.cos(lat_rad)
	return {R0 * math.cos(lon_rad), R0 * math.sin(lon_rad),
	    EARTH_MSL * math.sin(lat_rad)}
end

local function ortho_fpp_init(center)
	local fpp = {}

	fpp[1] = sph_xlate_init(center, 0, false)
	fpp[2] = sph_xlate_init(center, 0, true)

	return fpp
end

local function sph2fpp(pos, fpp)
	local pos_v = sph_xlate_vect(sph2ecef(pos), fpp[1])
	return {pos_v[2], pos_v[3]}
end

local function fpp2sph(pos, fpp)
	local v = {-1000000000, pos[1], pos[2]}
	local o = {1000000000, 0, 0}
	local i = vect2sph_isect(v, o, {0, 0, 0}, EARTH_MSL, false)

	if n == 0 then
		return nil
	end
	r = sph_xlate_vect(i[1], fpp[2])

	return ecef2sph(r)
end

local function raas_reset()
	dr_baro_alt = dataref_table("sim/flightmodel/misc/h_ind")
	dr_rad_alt = dataref_table("sim/cockpit2/gauges/indicators/" ..
	    "radio_altimeter_height_ft_pilot")
	dr_gs = dataref_table("sim/flightmodel/position/groundspeed")
	dr_lat = dataref_table("sim/flightmodel/position/latitude")
	dr_lon = dataref_table("sim/flightmodel/position/longitude")
	dr_hdg = dataref_table("sim/flightmodel/position/true_psi")
	dr_magvar = dataref_table("sim/flightmodel/position/magnetic_variation")
	dr_nw_offset = dataref_table("sim/flightmodel/parts/" ..
	    "tire_z_no_deflection")
	dr_flaprqst = dataref_table("sim/flightmodel/controls/flaprqst")

	raas_start_time = os.time()
end

local function recip_rwy_id(rwy_id)
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

local function make_rwy_bbox(thresh_v, dir_v, width, len, long_displ)
	local a, b, c, d, len_displ_v

	-- displace the 'a' point from the runway threshold laterally
	-- by 1/2 width to the right
	a = vect2_add(thresh_v, vect2_set_abs(vect2_norm(dir_v,
	    true), width / 2))
	-- pull it back by `long_displ'
	a = vect2_add(a, vect2_set_abs(vect2_neg(dir_v), long_displ))

	-- do the same for the `d' point, but displace to the left
	d = vect2_add(thresh_v, vect2_set_abs(vect2_norm(dir_v,
	    false), width / 2))
	-- pull it back by `long_displ'
	d = vect2_add(d, vect2_set_abs(vect2_neg(dir_v), long_displ))

	-- points `b' and `c' are along the runway simply as runway len +
	-- long_displ
	len_displ_v = vect2_set_abs(dir_v, len + long_displ)
	b = vect2_add(a, len_displ_v)
	c = vect2_add(d, len_displ_v)

	return {a, b, c, d}
end

local function map_apt_dat(apt_dat_fname, apt_dats)
	apt_dat_f = io.open(apt_dat_fname)
	if apt_dat_f == nil then
		return 0
	end

	local arpt_cnt = 0
	local apt = nil
	local icao = nil

	while true do
		local line = apt_dat_f:read()
		if line == nil then
			break
		end
		if line:find("1 ") == 1 then
			local comps = split(line, " ")
			local new_icao = comps[5]

			if icao ~= nil and isemptytable(apt["rwys"]) then
				-- if the previous airport contained
				-- no runways, discard it
				apt_dat[icao] = nil
				arpt_cnt = arpt_cnt - 1
			end

			icao = nil
			apt = nil

			if apt_dat[new_icao] == nil then
				arpt_cnt = arpt_cnt + 1
				apt = {
				    ["elev"] = tonumber(comps[2]),
				    ["rwys"] = {}
				}
				icao = new_icao
				apt_dat[icao] = apt
			end
		elseif line:find("100 ") == 1 and icao ~= nil then
			local comps = split(line, " ")
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

			rwys[#rwys + 1] = {
				width,
				id1, lat1, lon1, displ1, blast1,
				id2, lat2, lon2, displ2, blast2
			}
		end
	end

	io.close(apt_dat_f)

	return arpt_cnt
end

local function find_all_apt_dats(xpdir)
	local apt_dats = {}

	local scenery_packs_ini = io.open(xpdir ..
	    "Custom Scenery/scenery_packs.ini")

	if scenery_packs_ini ~= nil then
		for line in scenery_packs_ini:lines() do
			if line:find("SCENERY_PACK ") == 1 then
				local scn_name = line:sub(13)
				apt_dats[#apt_dats + 1] = xpdir .. scn_name ..
				    "/Earth nav data/apt.dat"
			end
		end
		io.close(scenery_packs_ini)
	end

	apt_dats[#apt_dats + 1] = xpdir .. "Resources/default scenery/" ..
	    "default apt dat/Earth nav data/apt.dat", apt_dats

	return apt_dats
end

local function get_mtime(files)
	local mtimes = {}
	local cmd = "python '" .. SCRIPT_DIRECTORY .. "mtime.py' "

	for i, file in pairs(files) do
		cmd = cmd .. "'" .. file .. "'"
	end
	local cmd_f = io.popen(cmd)
	if cmd_f == nil then
		return nil
	end
	while true do
		local line = cmd_f:read()
		if line == nil then
			break
		end
		mtimes[#mtimes + 1] = tonumber(line)
	end
	cmd_f:close()

	return mtimes
end

local function recreate_apt_dat_cache(xpdir, apt_dats)
	for i, apt_dat_fname in pairs(apt_dats) do
		map_apt_dat(apt_dat_fname, apt_dat)
	end

	local apt_dat_cache_f = io.open(SCRIPT_DIRECTORY .. "apt_dat.cache",
	    "w")
	for icao, arpt in pairs(apt_dat) do
		local rwys = arpt["rwys"]
		apt_dat_cache_f:write("1 " .. arpt["elev"] ..
		    " 0 0 " .. icao .. "\n")
		for i, rwy in pairs(rwys) do
			apt_dat_cache_f:write("100 " .. rwy[1] ..
			    " 0 0 0 0 0 0 " ..
			    rwy[2] .. " " ..
			    rwy[3] .. " " ..
			    rwy[4] .. " " ..
			    rwy[5] .. " " ..
			    rwy[6] .. " 0 0 0 0 " ..
			    rwy[7] .. " " ..
			    rwy[8] .. " " ..
			    rwy[9] .. " " ..
			    rwy[10] .. " " ..
			    rwy[11] .. "\n")
		end
	end
	apt_dat_cache_f:close()
end

local function is_on_windows()
	return package.config:sub(1,1) == '\\'
end

local function map_apt_dats(xpdir)
	local apt_dats = find_all_apt_dats(xpdir)
	local cache_outdated = false
	local apt_dat_list_f = io.open(SCRIPT_DIRECTORY .. "apt_dat.list")

	if is_on_windows() then
		logMsg("on windows")
		if map_apt_dat(SCRIPT_DIRECTORY .. "apt_dat.cache",
		    apt_dat) == 0 then
			recreate_apt_dat_cache(xpdir, apt_dats)
		end
		return
	else
		logMsg("not on windows")
	end

	if apt_dat_list_f ~= nil then
		local entries_in_cache = 0
		for line in apt_dat_list_f:lines() do
			entries_in_cache = entries_in_cache + 1
			if line ~= apt_dats[entries_in_cache] then
				cache_outdated = true
				break
			end
		end
		if entries_in_cache ~= #apt_dats then
			cache_outdated = true
		end
		apt_dat_list_f:close()
	else
		cache_outdated = true
	end

	-- update the apt_dat.list file
	if cache_outdated then
		apt_dat_list_f = io.open(SCRIPT_DIRECTORY .. "apt_dat.list",
		    "w")
		for i, line in pairs(apt_dats) do
			apt_dat_list_f:write(line .. "\n")
		end
		apt_dat_list_f:close()
	end

	local apt_dat_cache_f = io.open(SCRIPT_DIRECTORY .. "apt_dat.cache")
	if apt_dat_cache_f ~= nil then
		apt_dat_cache_f:close()

		local apt_dat_cache_mtime = next(get_mtime({SCRIPT_DIRECTORY ..
		    "apt_dat.cache"}))
		local apt_dat_mtimes = get_mtime(apt_dats)

		for i, mtime in pairs(apt_dat_mtimes) do
			if apt_dat_cache_mtime < mtime then
				cache_outdated = true
				break
			end
		end 
	else
		cache_outdated = true
	end

	if cache_outdated or map_apt_dat(SCRIPT_DIRECTORY .. "apt_dat.cache",
	    apt_dat) == 0 then
		recreate_apt_dat_cache(xpdir, apt_dats)
	end
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
  don't overlap.
--]]
local function make_apch_prox_bbox(db_rwys, rwy_id, thr_v, width, dir_v, fpp)
	local x, a, b, b1, c, c1, d
	local bbox = {}
	local limit_left, limit_right = 1000000, 1000000

	x = vect2_add(thr_v, vect2_set_abs(vect2_neg(dir_v),
	    RAAS_APCH_PROXIMITY_LON_DISPL))
	a = vect2_add(x, vect2_set_abs(vect2_norm(dir_v, true),
	    width / 2 + RAAS_APCH_PROXIMITY_LAT_DISPL))
	b = vect2_add(thr_v, vect2_set_abs(vect2_norm(dir_v, true), width / 2))
	c = vect2_add(thr_v, vect2_set_abs(vect2_norm(dir_v, false), width / 2))
	d = vect2_add(x, vect2_set_abs(vect2_norm(dir_v, false),
	    width / 2 + RAAS_APCH_PROXIMITY_LAT_DISPL))

	-- If our rwy_id designator contains a L/C/R, then we need to
	-- look for another parallel runway
	if #rwy_id >= 3 then
		local num_id = rwy_id:sub(1, 2)
		local myhdg = dir2hdg(dir_v)

		for i, orwy in pairs(db_rwys) do
			if (orwy[2]:sub(1, 2) == num_id and
			    orwy[2] ~= rwy_id) or
			    (orwy[7]:sub(1, 2) == num_id and
			    orwy[7] ~= rwy_id) then
				-- this is a parallel runway, measure the
				-- distance to it from us
				local othr_v = sph2fpp({orwy[3], orwy[4]}, fpp)
				local v = vect2_sub(othr_v, thr_v)
				local a = rel_hdg(dir2hdg(dir_v), dir2hdg(v))
				local dist = math.abs(math.sin(math.rad(a)) *
				    vect2_abs(v))

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

	if limit_left < RAAS_APCH_PROXIMITY_LAT_DISPL then
		c1 = vect2vect_isect(vect2_sub(d, c), c, vect2_neg(dir_v),
		    vect2_add(thr_v, vect2_set_abs(vect2_norm(dir_v, false),
		    limit_left)), false)
		d = vect2_add(x, vect2_set_abs(vect2_norm(dir_v, false),
		    limit_left))
	end
	if limit_right < RAAS_APCH_PROXIMITY_LAT_DISPL then
		b1 = vect2vect_isect(vect2_sub(b, a), a, vect2_neg(dir_v),
		    vect2_add(thr_v, vect2_set_abs(vect2_norm(dir_v, true),
		    limit_right)), false)
		a = vect2_add(x, vect2_set_abs(vect2_norm(dir_v, true),
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

local function load_rwy_info(arpt_id, fpp)
	local rwys = {}
	local db_arpt = apt_dat[arpt_id]
	local db_rwys = db_arpt["rwys"]

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
		local width = db_rwy[1]

		local id1 = db_rwy[2]
		local lat1 = db_rwy[3]
		local lon1 = db_rwy[4]
		local thr1_v = sph2fpp({lat1, lon1}, fpp)
		local displ1 = db_rwy[5]
		local blast1 = db_rwy[6]

		local id2 = db_rwy[7]
		local lat2 = db_rwy[8]
		local lon2 = db_rwy[9]
		local thr2_v = sph2fpp({lat2, lon2}, fpp)
		local displ2 = db_rwy[10]
		local blast2 = db_rwy[11]

		local dir_v = vect2_sub(thr2_v, thr1_v)
		local hdg1 = dir2hdg(dir_v)
		local hdg2 = dir2hdg(vect2_neg(dir_v))

		local rwy = {
		    ["id1"] = id1,
		    ["id2"] = id2,
		    ["t1x"] = thr1_v[1],
		    ["t1y"] = thr1_v[2],
		    ["t2x"] = thr2_v[1],
		    ["t2y"] = thr2_v[2],
		    ["hdg1"] = hdg1,
		    ["hdg2"] = hdg2,
		    ["width"] = width,
		    ["len"] = vect2_abs(vect2_sub(thr2_v, thr1_v))
		}

		local len = vect2_abs(dir_v)

		rwy["tora_bbox"] = make_rwy_bbox(thr1_v, dir_v, width, len, 0)
		rwy["asda_bbox"] = make_rwy_bbox(thr1_v, dir_v, width,
		    len + blast2, blast1)
		rwy["prox_bbox"] = make_rwy_bbox(thr1_v, dir_v,
		    RAAS_PROXIMITY_LAT_FRACT * width,
		    len + RAAS_PROXIMITY_LON_DISPL, RAAS_PROXIMITY_LON_DISPL)
		rwy["apch_prox_bbox1"] = make_apch_prox_bbox(db_rwys, id1,
		    thr1_v, width, dir_v, fpp)
		rwy["apch_prox_bbox2"] = make_apch_prox_bbox(db_rwys, id1,
		    thr2_v, width, vect2_neg(dir_v), fpp)

		rwys[#rwys + 1] = rwy
	end

	return rwys
end

local function load_airport(arpt_id)
	local db_arpt = apt_dat[arpt_id]
	local lat = db_arpt["lat"]
	local lon = db_arpt["lon"]
	local fpp = ortho_fpp_init({lat, lon})
	local ecef = sph2ecef({lat, lon})
	local arpt = {
	    ["arpt_id"] = arpt_id,
	    ["fpp"] = fpp,
	    ["rwys"] = load_rwy_info(arpt_id, fpp),
	    ["lat"] = lat,
	    ["lon"] = lon,
	    ["ecef"] = ecef,
	    ["elev"] = db_arpt["elev"]
	}
	return arpt
end

local function find_nearest_airports_idx(pos, lat_idx, lon_idx, arpt_list)
	local lat_tbl, lon_tbl

	if lat_idx < -80 or lat_idx > 80 then
		return
	end
	if lon_idx <= -180 then
		lon_idx = lon_idx + 360
	end
	if lon_idx >= 180 then
		lon_idx = lon_idx - 360
	end

	lat_tbl = airport_geo_table[lat_idx]
	if lat_tbl == nil then
		return
	end
	lon_tbl = lat_tbl[lon_idx]
	if lon_tbl == nil then
		return
	end

	for arpt_id, coords in pairs(lon_tbl) do
		local arpt_pos = sph2ecef(coords)
		if vect3_abs(vect3_sub(pos, arpt_pos)) < ARPT_LOAD_THRESH then
			arpt_list[arpt_id] = coords
		end
	end
end

local function find_nearest_airports(reflat, reflon)
	local pos = sph2ecef({reflat, reflon})
	local ref_lat_idx = geo_table_idx(reflat)
	local ref_lon_idx = geo_table_idx(reflon)
	local arpt_list = {}

	for i = -1, 1 do
		for j = -1, 1 do
			local lat_idx = ref_lat_idx + i
			local lon_idx = ref_lon_idx + j

			find_nearest_airports_idx(pos, lat_idx, lon_idx,
			    arpt_list)
		end
	end

	return arpt_list
end

local function load_nearest_airports()
	local now = os.time()
	if now - last_airport_reload < ARPT_RELOAD_INTVAL then
		return
	end
	last_airport_reload = now

	local new_arpts = find_nearest_airports(dr_lat[0], dr_lon[0])

	for arpt_id, arpt in pairs(cur_arpts) do
		if new_arpts[arpt_id] == nil then
			cur_arpts[arpt_id] = nil
		end
	end
	for arpt_id, coords in pairs(new_arpts) do
		if cur_arpts[arpt_id] == nil then
			cur_arpts[arpt_id] = load_airport(arpt_id)
		end
	end
end

local function acf_vel_vector()
	return vect2_set_abs(hdg2dir(dr_hdg[0]),
	    RAAS_PROXIMITY_TIME_FACT * dr_gs[0] - dr_nw_offset[0])
end

local function closest_rwy_end(pos, rwy)
	if vect2_abs(vect2_sub(pos, {rwy["t1x"], rwy["t1y"]})) <
	    vect2_abs(vect2_sub(pos, {rwy["t2x"], rwy["t2y"]})) then
		return rwy["id1"]
	else
		return rwy["id2"]
	end
end

local function rwy_lcr_msg(str)
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

local function rwy_id_to_msg(rwy_id, msg)
	msg[#msg + 1] = rwy_id:sub(1, 1)
	msg[#msg + 1] = rwy_id:sub(2, 2)
	msg[#msg + 1] = rwy_lcr_msg(rwy_id)
end

local function dist_to_msg(dist, msg)
	if use_imperial then
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
			return false
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
		else
			return false
		end
	end

	return true
end

local function raas_ground_runway_approach_arpt_rwy(arpt, rwy_id, rwy, pos_v,
    vel_v)
	local prox_bbox = rwy["prox_bbox"]
	local arpt_id = arpt["arpt_id"]

	if point_in_poly(pos_v, prox_bbox) or
	    not isemptytable(vect2poly_isect(vel_v, pos_v, prox_bbox)) then
		if raas_apch_rwy_ann[arpt_id .. rwy_id] == nil then
			if dr_gs[0] < SPEED_THRESH then
				local rwy_name = closest_rwy_end(pos_v, rwy)
				local msg = {"apch"}
				rwy_id_to_msg(rwy_name, msg)
				raas_play_msg(msg)
			end
			raas_apch_rwy_ann[arpt_id .. rwy_id] = true
		end
	else
		raas_apch_rwy_ann[arpt_id .. rwy_id] = nil
	end
end

local function raas_ground_runway_approach_arpt(arpt, vel_v)
	local fpp = arpt["fpp"]
	local pos_v = sph2fpp({dr_lat[0], dr_lon[0]}, arpt["fpp"])

	for i, rwy in pairs(arpt["rwys"]) do
		local rwy_id = rwy["id1"]
		raas_ground_runway_approach_arpt_rwy(arpt, rwy_id, rwy, pos_v,
		    vel_v)
	end
end

local function raas_ground_runway_approach()
	local lat, lon = dr_lat[0], dr_lon[0]
	local vel_v = acf_vel_vector()

	for arpt_id, arpt in pairs(cur_arpts) do
		raas_ground_runway_approach_arpt(arpt, vel_v)
	end
end

local function perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v)
	local msg = {"on_rwy"}
	local dist = vect2_abs(vect2_sub(opp_thr_v, pos_v))
	local flaprqst = dr_flaprqst[0]

	rwy_id_to_msg(rwy_id, msg)
	if dist < min_takeoff_dist and dist_to_msg(dist, msg) then
		msg[#msg + 1] = "rmng"
	end

	if flaprqst < min_takeoff_flap or flaprqst > max_takeoff_flap then
		msg[#msg + 1] = "flaps"
		msg[#msg + 1] = "flaps"
	end

	raas_play_msg(msg)
end

local function on_rwy_check(arpt_id, rwy_id, hdg, rwy_hdg, pos_v, opp_thr_v)
	if math.abs(rel_hdg(hdg, rwy_hdg)) > HDG_ALIGN_THRESH then
		raas_on_rwy_ann[arpt_id .. rwy_id] = nil
		return
	end

	local now = os.time()
	if on_rwy_timer ~= -1 and ((now - on_rwy_timer > on_rwy_warn_initial and
	    on_rwy_warnings == 0) or (now - on_rwy_timer - on_rwy_warn_initial >
	    on_rwy_warnings * on_rwy_warn_repeat)) and
	    on_rwy_warnings < on_rwy_warn_max_n then
		on_rwy_warnings = on_rwy_warnings + 1
		perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v)
	end

	if raas_on_rwy_ann[arpt_id .. rwy_id] == nil then
		if dr_gs[0] < SPEED_THRESH then
			perform_on_rwy_ann(rwy_id, pos_v, opp_thr_v)
		end
		raas_on_rwy_ann[arpt_id .. rwy_id] = true
	end
end

local function stop_check_reset(arpt_id, rwy_id)
	short_rwy_takeoff_chk = false
	if raas_accel_stop_max_spd[arpt_id .. rwy_id] ~= nil then
		raas_accel_stop_max_spd[arpt_id .. rwy_id] = nil
		raas_accel_stop_ann_initial = 0
		for i, info in pairs(raas_accel_stop_distances) do
			info["ann"] = false
		end
	end
end

local function stop_check(arpt_id, rwy_id, hdg, rwy_hdg, pos_v, opp_thr_v, len)
	local gs = dr_gs[0]
	local maxspd
	if gs < SPEED_THRESH then
		stop_check_reset(arpt_id, rwy_id)
		return
	end
	if math.abs(rel_hdg(hdg, rwy_hdg)) > HDG_ALIGN_THRESH then
		return
	end
	if dr_rad_alt[0] > RADALT_GRD_THRESH then
		stop_check_reset(arpt_id, rwy_id)
		if departed and dr_rad_alt[0] <= RADALT_FLARE_THRESH then
			local dist = vect2_abs(vect2_sub(opp_thr_v, pos_v))

			if (dist < len / 2 or (dist <= min_landing_dist and
			    len >= min_landing_dist)) and
			    not long_landing_ann then
				long_landing_ann = true
				raas_play_msg({"long_land", "long_land"})
			end
		end
		return
	end

	if short_rwy_takeoff_chk == false then
		local dist = vect2_abs(vect2_sub(opp_thr_v, pos_v))
		short_rwy_takeoff_chk = true
		if dist < min_takeoff_dist then
			raas_play_msg({"short_rwy", "short_rwy"})
		end
	end

	maxspd = raas_accel_stop_max_spd[arpt_id .. rwy_id]
	if maxspd == nil or gs > maxspd then
		raas_accel_stop_max_spd[arpt_id .. rwy_id] = gs
		maxspd = gs
	end
	if gs < maxspd - ACCEL_STOP_SPD_THRESH then
		local dist = vect2_abs(vect2_sub(opp_thr_v, pos_v))

		if raas_accel_stop_ann_initial == 0 then
			local msg = {}
			raas_accel_stop_ann_initial = dist
			if dist_to_msg(dist, msg) then
				msg[#msg + 1] = "rmng"
				raas_play_msg(msg)
			end
		elseif dist < raas_accel_stop_ann_initial - STOP_INIT_DELAY
		    then
			for i, info in pairs(raas_accel_stop_distances) do
				local min = info["min"]
				local max = info["max"]
				local ann = info["ann"]

				if dist < accel_stop_dist_cutoff and
				    dist > min and dist < max and not ann then
					local msg = {}
					dist_to_msg(dist, msg)
					msg[#msg + 1] = "rmng"
					raas_play_msg(msg)
					info["ann"] = true
				end
			end
		end
	end
end

local function raas_ground_on_runway_aligned_arpt(arpt)
	local on_rwy = false
	local pos_v = sph2fpp({dr_lat[0], dr_lon[0]}, arpt["fpp"])
	local arpt_id = arpt["arpt_id"]
	local hdg = dr_hdg[0]

	for i, rwy in pairs(arpt["rwys"]) do
		local rwy_id = rwy["id1"]
		if point_in_poly(pos_v, rwy["tora_bbox"]) then
			on_rwy = true
			on_rwy_check(arpt_id, rwy["id1"], hdg, rwy["hdg1"],
			    pos_v, {rwy["t2x"], rwy["t2y"]})
			on_rwy_check(arpt_id, rwy["id2"], hdg, rwy["hdg2"],
			    pos_v, {rwy["t1x"], rwy["t1y"]})
		end
		if point_in_poly(pos_v, rwy["asda_bbox"]) then
			stop_check(arpt_id, rwy["id1"], hdg, rwy["hdg1"],
			    pos_v, {rwy["t2x"], rwy["t2y"]}, rwy["len"])
			stop_check(arpt_id, rwy["id2"], hdg, rwy["hdg2"],
			    pos_v, {rwy["t1x"], rwy["t1y"]}, rwy["len"])
		else
			stop_check_reset(arpt_id, rwy["id1"])
			stop_check_reset(arpt_id, rwy["id2"])
		end
	end

	return on_rwy
end

local function raas_ground_on_runway_aligned()
	local on_rwy = false

	for arpt_id, arpt in pairs(cur_arpts) do
		if raas_ground_on_runway_aligned_arpt(arpt) then
			on_rwy = true
		end
	end

	if on_rwy and dr_gs[0] < STOPPED_THRESH then
		if on_rwy_timer == -1 then
			logMsg("on_rwy_timer started")
			on_rwy_timer = os.time()
		end
	else
		on_rwy_timer = -1
		on_rwy_warnings = 0
	end

	-- Taxiway takeoff check
	if not on_rwy and dr_gs[0] >= SPEED_THRESH and
	    dr_rad_alt[0] < RADALT_GRD_THRESH then
		if not on_twy_ann then
			on_twy_ann = true
			raas_play_msg({"caution", "on_twy", "on_twy"})
		end
	elseif dr_gs[0] < SPEED_THRESH or
	    dr_rad_alt[0] >= RADALT_GRD_THRESH then
		on_twy_ann = false
	end
end

local function raas_air_runway_approach_arpt_rwy(arpt, rwy, suffix, pos_v, hdg,
    alt)
	local rwy_id = rwy["id" .. suffix]
	local arpt_id = arpt["arpt_id"]
	local elev = arpt["elev"]

	if point_in_poly(pos_v, rwy["apch_prox_bbox" .. suffix]) and
	    math.abs(rel_hdg(hdg, rwy["hdg" .. suffix])) < HDG_ALIGN_THRESH then
		local msg = {}

		-- If we're below 950 ft AFE and haven't annunciated yet
		if alt < elev + RAAS_APCH_FLAP1_THRESH and
		    alt > elev + RAAS_APCH_FLAP1_THRESH - RAAS_APCH_ALT_WINDOW
		    and not raas_air_apch_flap1_ann[arpt_id .. rwy_id] and
		    dr_flaprqst[0] < min_landing_flap then
			msg[#msg + 1] = "flaps"
			msg[#msg + 1] = "flaps"
			raas_air_apch_flap1_ann[arpt_id .. rwy_id] = true
		end
		if alt < elev + RAAS_APCH_FLAP2_THRESH and
		    alt > elev + RAAS_APCH_FLAP2_THRESH - RAAS_APCH_ALT_WINDOW
		    and not raas_air_apch_flap2_ann[arpt_id .. rwy_id] and
		    dr_flaprqst[0] < min_landing_flap then
			msg[#msg + 1] = "flaps"
			msg[#msg + 1] = "flaps"
			raas_air_apch_flap2_ann[arpt_id .. rwy_id] = true
		end

		-- If we are below 470 ft AFE and we haven't annunciated yet
		if alt < elev + RAAS_APCH_ALT_THRESH and
		    raas_air_apch_rwy_ann[arpt_id .. rwy_id] == nil then
			-- Don't annunciate if we are too low
			if alt > elev + RAAS_APCH_ALT_THRESH -
			    RAAS_APCH_ALT_WINDOW then
				if dr_flaprqst[0] >= min_landing_flap then
					msg[#msg + 1] = "apch"

					rwy_id_to_msg(rwy_id, msg)
					if rwy["len"] < min_landing_dist then
						msg[#msg + 1] = "caution"
						msg[#msg + 1] = "short_rwy"
						msg[#msg + 1] = "short_rwy"
					end
				else
					msg[#msg + 1] = "unstable"
					msg[#msg + 1] = "unstable"
				end
				raas_air_apch_rwy_ann[arpt_id .. rwy_id] = true
			end
		end

		if not isemptytable(msg) then
			raas_play_msg(msg)
		end
	elseif raas_air_apch_rwy_ann[arpt_id .. rwy_id] ~= nil and
	    not point_in_poly(pos_v, rwy["apch_prox_bbox" .. suffix]) then
		raas_air_apch_rwy_ann[arpt_id .. rwy_id] = nil
	end
end

local function reset_airport_approach_table(tbl, arpt_id)
	for id, val in pairs(tbl) do
		if id:find(arpt_id) == 1 then
			tbl[id] = nil
		end
	end
end

local function raas_air_runway_approach_arpt(arpt)
	local alt = dr_baro_alt[0]
	local hdg = dr_hdg[0]
	local arpt_id = arpt["arpt_id"]
	local elev = arpt["elev"]
	if alt > elev + RAAS_APCH_FLAP1_THRESH + RAAS_APCH_ALT_WINDOW or
	    alt < elev - RAAS_APCH_ALT_THRESH - RAAS_APCH_ALT_WINDOW then
		reset_airport_approach_table(raas_air_apch_flap1_ann, arpt_id)
		reset_airport_approach_table(raas_air_apch_flap2_ann, arpt_id)
		reset_airport_approach_table(raas_air_apch_rwy_ann, arpt_id)
		return
	end

	local pos_v = sph2fpp({dr_lat[0], dr_lon[0]}, arpt["fpp"])
	local hdg = dr_hdg[0]

	for i, rwy in pairs(arpt["rwys"]) do
		raas_air_runway_approach_arpt_rwy(arpt, rwy, "1", pos_v, hdg,
		    alt)
		raas_air_runway_approach_arpt_rwy(arpt, rwy, "2", pos_v, hdg,
		    alt)
	end
end

local function raas_air_runway_approach()
	if not airborne and departed then
		raas_air_apch_rwy_ann = {}
		return
	end

	for arpt_id, arpt in pairs(cur_arpts) do
		raas_air_runway_approach_arpt(arpt)
	end
end

function raas_exec()
	-- Before we start, wait a set delay, because X-Plane's datarefs
	-- needed for proper init are unstable, so we'll give them an
	-- extra second to fix themselves
	if os.time() - raas_start_time < RAAS_STARTUP_DELAY then
		return
	end

	load_nearest_airports(nil)

	-- the '10' addition here is for hysteresis
	if not on_rwy and dr_rad_alt[0] > RADALT_FLARE_THRESH + 10 then
		departed = true
		airborne = true
		long_landing_ann = false
	elseif dr_rad_alt[0] < RADALT_GRD_THRESH then
		departed = false
		airborne = false
	end

	raas_ground_runway_approach()
	raas_ground_on_runway_aligned()
	raas_air_runway_approach()
end

local draw_scale = 0.1

local function make_x(coord)
	local offx = 1280
	return coord * draw_scale + offx
end

local function make_y(coord)
	local offy = 768
	return coord * draw_scale + offy
end

local function draw_bbox(bbox)
	local graphics = require 'graphics'
	for i = 0, #bbox - 1 do
		graphics.draw_line(
		    make_x(bbox[i + 1][1]),
		    make_y(bbox[i + 1][2]),
		    make_x(bbox[(i + 1) % #bbox + 1][1]),
		    make_y(bbox[(i + 1) % #bbox + 1][2]))
	end
end

function raas_dbg_draw()
	local graphics = require 'graphics'
	local nearest_arpt_id = nil
	local nearest_arpt_dist = ARPT_LOAD_THRESH

	graphics.set_width(2)

	-- locate the nearest airport to us
	local pos_ecef = sph2ecef({dr_lat[0], dr_lon[0]})
	for arpt_id, arpt in pairs(cur_arpts) do
		local dist = vect3_abs(vect3_sub(arpt["ecef"], pos_ecef))
		if dist < nearest_arpt_dist then
			nearest_arpt_dist = dist
			nearest_arpt_id = arpt_id
		end
	end

	if nearest_arpt_id == nil then
		return
	end

	local cur_arpt = cur_arpts[nearest_arpt_id]
	local pos_v = sph2fpp({dr_lat[0], dr_lon[0]}, cur_arpt["fpp"])
	local vel_v = acf_vel_vector()

	draw_scale = math.min(650 / vect2_abs(pos_v), 1)

	graphics.set_color(1, 0, 0, 1)
	graphics.draw_line(make_x(-5), make_y(0), make_x(5), make_y(0))
	graphics.draw_line(make_x(0), make_y(-5), make_x(0), make_y(5))

	for rwy_id, rwy in pairs(cur_arpt["rwys"]) do
		graphics.set_color(1, 1, 1, 0.5)
		draw_bbox(rwy["apch_prox_bbox1"])
		draw_bbox(rwy["apch_prox_bbox2"])
		graphics.set_color(0, 0, 1, 0.67)
		draw_bbox(rwy["prox_bbox"])
		graphics.set_color(1, 0, 0, 1)
		draw_bbox(rwy["asda_bbox"])
		graphics.set_color(0, 1, 0, 1)
		draw_bbox(rwy["tora_bbox"])
	end

	graphics.set_color(1, 1, 1, 1)
	local tgt = vect2_add(pos_v, vel_v)
	graphics.draw_line(make_x(pos_v[1]) - 5, make_y(pos_v[2]),
	    make_x(pos_v[1]) + 5, make_y(pos_v[2]))
	graphics.draw_line(make_x(pos_v[1]), make_y(pos_v[2]) - 5,
	    make_x(pos_v[1]), make_y(pos_v[2]) + 5)
	graphics.draw_line(make_x(pos_v[1]), make_y(pos_v[2]),
	    make_x(tgt[1]), make_y(tgt[2]))
end

local function load_msg_table()
	for msgid, msg in pairs(messages) do
		local fname = SCRIPT_DIRECTORY .. "RAAS" ..
		    DIRECTORY_SEPARATOR .. voice_gender ..
		    DIRECTORY_SEPARATOR .. msgid .. ".wav"
		local snd_f = io.open(fname)
		local sz = snd_f:seek("end")

		snd_f:close()
		msg["snd"] = load_WAV_file(fname)
		-- all our sound files are mono, 16-bit, 44.1 kHz, so simply
		-- estimate the length based on file size
		msg["dur"] = (sz - 44) / 2 / 44100
	end
end

function raas_play_msg(msg)
	logMsg("play_msg: " .. table.show(msg, "msg"))

	if not isemptytable(cur_msg) then
		if cur_msg["snd"] ~= nil then
			stop_sound(cur_msg["snd"])
		end
		cur_msg = {}
	end

	cur_msg["msg" ] = msg
	cur_msg["playing"] = 0
end

function raas_snd_sched()
	if isemptytable(cur_msg) then
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

local function load_acf_config()
	local acf_cfg_f = io.open(AIRCRAFT_PATH .. "RAAS.cfg")

	if acf_cfg_f ~= nil then
		local cfg = acf_cfg_f:read("*all")
		lua.execute(cfg)
		acf_cfg_f:close()
	end
end

raas_reset()

map_apt_dats(SCRIPT_DIRECTORY .. "../../../../")

local nav_ref = XPLMGetFirstNavAid()
while nav_ref ~= XPLM_NAV_NOT_FOUND do
	local outType, lat, lon, elev, freq, hdg, arpt_id, outName =
	    XPLMGetNavAidInfo(nav_ref)
	if outType == xplm_Nav_Airport and apt_dat[arpt_id] ~= nil then
		local arpt = apt_dat[arpt_id]
		arpt["lat"] = lat
		arpt["lon"] = lon

		local lat_idx = geo_table_idx(lat)
		local lon_idx = geo_table_idx(lon)

		local lat_tbl = airport_geo_table[lat_idx]
		if lat_tbl == nil then
			lat_tbl = {}
			airport_geo_table[lat_idx] = lat_tbl
		end
		local lon_tbl = lat_tbl[lon_idx]
		if lon_tbl == nil then
			lon_tbl = {}
			lat_tbl[lon_idx] = lon_tbl
		end

		lon_tbl[arpt_id] = {lat, lon}
	end
	nav_ref = XPLMGetNextNavAid(nav_ref)
end

load_acf_config()
load_msg_table()

do_often('raas_exec()')
do_every_draw('raas_snd_sched()')

-- Uncomment the line below to get a nice debug display
--do_every_draw('raas_dbg_draw()')
