Metrostroi Subway Train Simulator
================================================================================
A prototype of a subway simulator, based on Garry's Mod (Source Engine).
For the licensing information, see at the bottom.

It's a beta version of original Metrostroi Subway Train Simulator

This simulation features fully simulated 81-717 and Ezh3 metro trains - with all
the electric circuits and pneumatic systems. Every relay of the train is modelled.

The following features are incomplete/missing:

- 81-717 train is based on Ezh3 model and lacks some 81-717 specific features
(ventilation, proper BPSN modelling).
- Some 81-717 indicators are based on the manuals and might be connected
to slightly wrong circuits. 
- 81-717 circuit breakers are actually from Ezh3 and don't match up with
what they should really be in real train. 
- Emergency controls are not implemented.
- ARS/ALS system modelling is simplified and based on the manual and not electric circuits.
- While all perfomance data more or less matches real world one, some changes
had to be made for it to work nicely with Garry's Mod maps.


Licensing
================================================================================
### Models and materials
All models and materials belong to their corresponding authors. Mainly used without
permission for purposes of prototyping a subway train simulator.


### Sounds
The sounds are based on audio/video recordings that belong to their corresponding
authors.


### Precompiled simulation files
`/lua/metrostroi/systems/sys_gen_int.lua`
`/lua/metrostroi/systems/sys_gen_res.lua`

Copyright (C) 2013-2016 Black Phoenix. All rights reserved.

These files are provided with the following restrictions:

- These files can only be redistributed for use with the Metrostroi simulator (including derivative versions)
- These files may only be ran under Garry's Mod Lua interpreter within the context of Metrostroi simulator
- It is forbidden to use this code for any commercial purposes
- It is forbidden to use this code for any purposes of professional education
- It is forbidden to make any code changes in these files in any derivative projects without an explicit permission from the author
- Any derivative versions of this simulator that make use of these files must include this restrictions information


### Other source files

Copyright (C) 2013-2016 Black Phoenix, Hunter NL, glebqip

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
