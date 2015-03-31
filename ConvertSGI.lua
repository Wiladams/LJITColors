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
	Get raw data from here:
	http://paulbourke.net/texture_colour/colourspace/sgi.html

	Strip off the first couple of lines that look like this:

SGI X colours

 R   G   B              Name
===========             ===================

Run what's left through this program

--]]



local function parseline(line)
	local starting, ending, n1, n2, n3, name = line:find("%s*(%d*)%s*(%d*)%s*(%d*)%s*([%a%d%s]*)")
	return tonumber(n1), tonumber(n2), tonumber(n3), name
end

convertFile = function(filename)
	for line in io.lines(filename) do
		local red,green,blue,name = parseline(line)
		name = name:lower()
		if name:find("%s") == nil then
			io.write(string.format("\t%s = {%d, %d, %d},\n",name:gsub(' ',''):lower(), red, green, blue))
		end
	end
end

convertFile("./data/SGIColors.txt")

