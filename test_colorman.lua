local colorman = require("colorman")

local function printColorValue(cv)
	--print(cv.name)
	print(string.format("%10s %-20s%4d %4d %4d", cv.dbname, cv.name, cv.color[1], cv.color[2], cv.color[3]));
end

local function printColors(name)

	local colors = colorman.getColorByName(name);
	for _, value in ipairs(colors) do
		print(string.format("%-20s%4d %4d %4d", name, value[1], value[2], value[3]));
	end
end

-- lookup some colors by name
--printColors("cottoncandy");
local function testColorNameMatch(pattern)
	local found = getColorLikeName(pattern)

	--local found = colorman.matchColorByName(pattern, colorman.colordb.sgi, "sgi")

	for _, value in ipairs(found) do
		printColorValue(value)
	end
end

local function testNameMatch(pattern, dbname)
	local found = colorman.matchColorByName(pattern, colorman.colordb[dbname], dbname)

	for _, value in ipairs(found) do
		printColorValue(value)
	end
end

local function testColorByValue()
	--local found = colorman.matchColorByValue({255,255,255}, colorman.colordb.sgi, "sgi")
	--local found = colorman.matchColorByValue({127,70,80}, colorman.colordb.sgi, "sgi")
	local found = colorman.getColorByValue({255,255,255})

	for _, value in ipairs(found) do
		printColorValue(value)
	end
end

--testColorNameMatch("gray")
--testColorNameMatch("white")
--testColorNameMatch("vio")
--testColorNameMatch("yellow")
--testNameMatch("yellow", "crayola")
testColorByValue()

