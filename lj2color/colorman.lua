--[[
Copyright 2015 William A Adams
--]]

local colordb = require("lj2color.allcolors");
local math = require("math")
local acos = math.acos
local abs = math.abs

-- convert color with components ranging from 0-255 
-- to components with range 0.0 - 1.0
function normrgba(c,a)
	return {c[1]/255, c[2]/255, c[3]/255, a};
end

-- Createa a normalized vector
local function normalize(A)
	local mag = math.sqrt(A[1]*A[1] + A[2]*A[2] + A[3]*A[3])
	return {A[1]/mag, A[2]/mag, A[3]/mag}
end

-- linear algebra dot product
local function dot(A,B)
	return A[1]*B[1]+A[2]*B[2]+A[3]*B[3];
end

--[[
	If we assume color can be represented as vectors,
	then taking an angle between two of them is an indicator
	as to how close they are to each other.

	This is useful in the case where you're trying to do color
	matching.  Just run through a number of possible colors, and
	the one with the smallest angle from your sample is the
	closest match.

	Θ = acos(A · B)
	where 	normalize A
			normalize B
]]
local function angleBetweenColors(A, B)

	local a = normalize(A)
	local b = normalize(B)
	local angle = acos(dot(a,b))

	return angle
end

--[[
	Convert to luminance using ITU-R Recommendation BT.709 (CCIR Rec. 709)
	This is the one that matches modern HDTV and LCD monitors
	This is a simple 'grayscale' conversion
--]]

local function lumaBT709(c)
	local gray = 0.2125 * c[1] + 0.7154 * c[2] + 0.0721 * c[3]

	return gray;
end


function insertdictionary(tbl, dict)
	if #dict < 1 then
		return;
	end

	for _, entry in ipairs(dict) do
		table.insert(tbl, entry)
	end
end


-- return a list of colors that have the same
-- name from all the different color tables
function getColorByName(name)

	local colors = {}
	
	table.insert(colors, colordb.resene[name])
	table.insert(colors, colordb.crayola[name])
	table.insert(colors, colordb.hollasch[name])
	table.insert(colors, colordb.sgi[name])

	return colors;
end

--[[
	To find a matching color, we use two techniques.
	First, we use the angleBetweenColors, as this will
	tell us whether the colors are close in hue.
	Second, we use the luma, because it will tell us 
	whether they are close in brightness.

	You could of course just compare using one or the other,
	depending on what kind of matching you want to do, but
	this is generically what we do here.
--]]
local function matchColorByValue(color, db, dbname)
	local colors = {}
	local colorluma = lumaBT709(color)


	for name, candidate in pairs(db) do
		local angle = angleBetweenColors(color, candidate)
		local candidateluma = lumaBT709(candidate)
		if (angle < 0.05) and (abs(candidateluma - colorluma) < 5) then
			table.insert(colors, {dbname=dbname, name=name, color = candidate})
		end
	end

	return colors;
end

function getColorByValue(color)
	local colors = {}

	insertdictionary(colors, matchColorByValue(color, colordb.resene, "resene"))
	insertdictionary(colors, matchColorByValue(color, colordb.crayola, "crayola"))
	insertdictionary(colors, matchColorByValue(color, colordb.hollasch, "hollasch"))
	insertdictionary(colors, matchColorByValue(color, colordb.sgi, "sgi"))

	return colors;
end


-- return a list of colors which contain the specified pattern
--
function matchColorByName(pattern, db, dbname)
	local colors = {}

	for name, color in pairs(db) do
		if name:lower():find(pattern) then
			table.insert(colors, {dbname=dbname, name=name, color=color})
		end
	end

	return colors;
end



function getColorLikeName(pattern)
	local colors = {}


	insertdictionary(colors, matchColorByName(pattern, colordb.resene, "resene"))
	insertdictionary(colors, matchColorByName(pattern, colordb.crayola, "crayola"))
	insertdictionary(colors, matchColorByName(pattern, colordb.hollasch, "hollasch"))
	insertdictionary(colors, matchColorByName(pattern, colordb.sgi, "sgi"))

	return colors;
end

return {
	colordb = colordb,

	normrgba = normrgba,
	luma = lumaBT709,

	getColorByName = getColorByName,
	matchColorByName = matchColorByName,

	matchColorByValue = matchColorByValue,
	getColorByValue = getColorByValue,
}