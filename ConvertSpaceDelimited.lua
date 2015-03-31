--[[
Copyright 2015 William A Adams

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http ://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]

--[[
Resene RGB Values List

Copyright Resene Paints Ltd 2001

Columnar data

Colour name(1)            r-27 g-32 b-37
===========               ===  ===  ===


--]]


local function ConvertSpaceDelimeted (filename)
	function parseline(line)
		-- get name, strip whitespace
		-- make lowercase
		local name = line:sub(1,26)
		name = string.gsub(name, "%s",'')
		name = name:lower();

		-- get the numeric strings, convert to numbers
		local r = tonumber(line:sub(27,29))
		local g = tonumber(line:sub(32,34))
		local b = tonumber(line:sub(37,39))

		return name, r, g, b
	end

	io.write("local Colors = {\n");
	for line in io.lines(filename) do
		local name, red,green,blue = parseline(line)
		--print(name, ' ', red, green,blue)
		io.write(string.format("\t%s = {%d, %d, %d},\n",name, red, green, blue))
	end
	io.write("}\n");
end

local filename = arg[1] or "./data/ReseneRGB.txt";

if not filename then
	print("Usage: ConvertSpaceDelimited <filename>");
	return;
end

ConvertSpaceDelimeted(filename);