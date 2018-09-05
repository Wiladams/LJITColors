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
	Whites
	antique_white     250   235   215   0.9804   0.9216   0.8431

--]]
ConvertHollaschFile = function(filename)
	parseline = function(line)
		-- get name, strip whitespace
		-- make lowercase
		local name = line:sub(1,18)
		name = string.gsub(name, "%s",'')

		-- get the numeric strings, convert to numbers
		local r = tonumber(line:sub(19,21))
		local g = tonumber(line:sub(25,27))
		local b = tonumber(line:sub(31,33))

		if r and g and b then
			name = name:lower();
		end

		return name, r, g, b
	end

	io.write("local HollaschColors = {\n");
	for line in io.lines(filename) do
		local name, red,green,blue = parseline(line)
		--print(name, red, green,blue)
		if name ~= "" then
			if red and green and blue then
				io.write(string.format("\t%s = {%d, %d, %d},\n",name, red, green, blue))
			else
				io.write(string.format("\n-- %s\n", name))
			end
		end
	end
	io.write("}\n");
end

ConvertHollaschFile("./data/HollaschColors.txt")

--print(tonumber(nil))