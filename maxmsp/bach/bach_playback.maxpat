{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 0,
			"revision" : 2,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 378.0, 79.0, 1011.0, 1007.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-31",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 588.5, 232.0, 279.0, 20.0 ],
					"text" : "thin annotations to make the score more readable"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 679.5, 412.0, 279.0, 33.0 ],
					"text" : "<- select a note (or notes) and press 'v' to listen to individual sounds!"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-20",
					"linecount" : 2,
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 867.0, 656.0, 115.0, 35.0 ],
					"text" : "sprintf set %i active instances"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 867.0, 701.5, 119.0, 20.0 ],
					"text" : "0 active instances"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 790.0, 611.75, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-32",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 790.0, 670.75, 67.0, 22.0 ],
					"text" : "busymap 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-28",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 790.0, 641.75, 63.0, 22.0 ],
					"text" : "metro 100"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-37",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 867.0, 626.75, 43.0, 22.0 ],
					"text" : "zl sum"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 688.5, 667.0, 79.0, 22.0 ],
					"text" : "prepend note"
				}

			}
, 			{
				"box" : 				{
					"bgslots" : [ 4 ],
					"bwcompatibility" : 80100,
					"clefs" : [ "F", "FG", "FG" ],
					"defaultnoteslots" : [ "null" ],
					"enharmonictable" : [ "default", "default", "default" ],
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"hidevoices" : [ 0, 0, 0 ],
					"id" : "obj-7",
					"keys" : [ "CM", "CM", "CM" ],
					"linkannotationtoslot" : 2,
					"loop" : [ 0.0, 1000.0 ],
					"maxclass" : "bach.roll",
					"midichannels" : [ 1, 2, 3 ],
					"numinlets" : 6,
					"numoutlets" : 8,
					"numparts" : [ 1, 1, 1 ],
					"numvoices" : 3,
					"out" : "nnnnnnn",
					"outlettype" : [ "", "", "", "", "", "", "", "bang" ],
					"patching_rect" : [ 140.0, 358.0, 526.0, 353.5 ],
					"pitcheditrange" : [ "null" ],
					"stafflines" : [ 5, 5, 5 ],
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"versionnumber" : 80100,
					"voicenames" : [ "target", "cps_vc1", "cps_vc0" ],
					"voicespacing" : [ 0.0, 17.0, 17.0, 17.0 ],
					"whole_roll_data_0000000000" : [ "roll", "[", "slotinfo", "[", 1, "[", "name", "fullpath", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 2, "[", "name", "sfskiptime", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1090021888, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 3, "[", "name", "sfchannels", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083129856, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 4, "[", "name", "env", "]", "[", "type", "function", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "grid", "]", "[", "ysnap", "]", "[", "domain", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "domainslope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "duration", "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 5, "[", "name", "slot int", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080016896, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 6, "[", "name", "slot float", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 7, "[", "name", "slot text", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 8, "[", "name", "slot filelist", "]", "[", "type", "filelist", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080213504, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 9, "[", "name", "slot spat", "]", "[", "type", "spat", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1076101120, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "auto", "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 10, "[", "name", "cps_transposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 3230613504, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083129856, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 11, "[", "name", "cps_selectnumber", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1090021888, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 12, "[", "name", "cps_filehead", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 13, "[", "name", "power-seg", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1090021888, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 14, "[", "name", "slot 14", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 15, "[", "name", "slot 15", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 16, "[", "name", "slot 16", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 17, "[", "name", "slot 17", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 18, "[", "name", "slot 18", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 19, "[", "name", "slot 19", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 20, "[", "name", "dynamics", "]", "[", "type", "dynamics", "]", "[", "key", "d", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 21, "[", "name", "lyrics", "]", "[", "type", "text", "]", "[", "key", "l", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 22, "[", "name", "articulations", "]", "[", "type", "articulations", "]", "[", "key", "a", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 23, "[", "name", "notehead", "]", "[", "type", "notehead", "]", "[", "key", "h", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 24, "[", "name", "annotation", "]", "[", "type", "text", "]", "[", "key", "t", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 25, "[", "name", "slot 25", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 26, "[", "name", "slot 26", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 27, "[", "name", "slot 27", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 28, "[", "name", "slot 28", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 29, "[", "name", "slot 29", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 30, "[", "name", "slot 30", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "]", "[", "commands", "[", 1, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 2, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 3, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 4, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 5, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "]", "[", "groups", "]", "[", "markers", "]", "[", "midichannels", 1, 2, 3, "]", "[", "articulationinfo", "]", "[", "noteheadinfo", "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085781248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082464256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085652224, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1082465976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083261952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085647104, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1083262894, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085606912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082507264, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1083629895, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085338880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085605120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1085339074, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085612800, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085375774, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085443840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085679616, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081413632, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1085443932, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085629440, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1085551411, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085576960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1085797826, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085683968, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571220, 1085871226, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085660160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1085976084, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085559296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1086038999, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085595392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1086091427, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085350912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1086177935, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085657344, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082085376, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1086230364, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085634560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1086343086, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085632256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1086367989, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085637120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1086419107, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085611008, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082359808, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086592000, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085650432, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571220, 1086592122, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085451264, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082296320, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1086623580, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, 5, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086349696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089012695, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2906833866, 1067572841, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1087854346, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085951488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088576225, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086084352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1089086095, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082464256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086336128, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571220, 1086821498, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082486784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088581795, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082548224, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086282752, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1089003520, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083251712, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083261952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083283456, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1088088965, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085977088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1087668224, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023 ],
					"whole_roll_data_0000000001" : [ 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088581795, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083639808, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1087527976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083650048, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1087854346, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083744256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085371392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1089053982, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085338880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085999616, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1088952729, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3958241860, 1068710336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086178048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369912, 1088714833, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4020089389, 1069270695, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085344256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086073088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1087914639, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3353510465, 1068940184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085394176, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1085040230, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1067077913, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085383424, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086137088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1087835996, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086358784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089386250, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1539316279, 1067532576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085414912, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086168064, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2233382994, 1084379627, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086060032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1088987136, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4033833284, 1066715525, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085443840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1089161461, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1067030937, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085446400, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085377280, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1089092976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1067279240, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086213120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1087636766, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1539316279, 1067532576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086334464, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081413632, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1089375109, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1608035756, 1067339638, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1088569016, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085559040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086406912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1086138613, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085593344, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085371392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1089053982, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085595904, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085603840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085800448, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088910786, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085803008, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1089161461, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1067030937, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085805568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085637918, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085810688, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316288, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1086716641, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088581795, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081794560, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1089071349, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2281486628, 1066916852, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085876224, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1083189493, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085913088, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085966848, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1082864435, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085918208, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089345290, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1087527976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086258432, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081290752, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1088555909, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2075328197, 1067495666, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085637918, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086349696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089012695, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2906833866, 1067572841, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086052096, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085700096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087798640, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085966848, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1082864435, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086093824, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1083189493, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0 ],
					"whole_roll_data_0000000002" : [ "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086099200, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086189824, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1089121812, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085550336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1088919961, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4020089389, 1069270695, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086198784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086339200, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1089310228, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2906833866, 1068621417, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086232832, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088910786, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086235392, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983232, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1087613829, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089066762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3958241860, 1068710336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085394176, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1085040230, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1067077913, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086373120, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1089161461, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1067030937, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086374528, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086213120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1087636766, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1539316279, 1067532576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086358784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089386250, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1539316279, 1067532576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1083189493, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086420352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1087071846, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2824370494, 1068223797, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089345290, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086489856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088910786, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1087854346, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086501632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086592000, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1088369459, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1088088965, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086595968, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086599936, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983232, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1087613829, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086626176, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1087071846, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2824370494, 1068223797, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "lachenmann", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086208512, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1087950684, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086627456, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086168064, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2233382994, 1084379627, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "lachenmann", "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085344256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085024256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1085837148, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2556364535, 1071781196, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085994240, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085641472, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1084264284, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2439541424, 1071742189, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086216192, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1080410767, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 494780232, 1071802168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086049280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086374272, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1086446632, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4260607558, 1071872212, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086065152, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086225920, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1086534451, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4260607558, 1071872212, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085931520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1083933982, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 419188808, 1071830899, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 2, "]", "[", 12, "heat sink", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086218496, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083179008, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3222943459, 1071849563, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 1, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086374528, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085984000, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2233382994, 1084510699, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1518700436, 1071758547, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085676544, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1087039078, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1518700436, 1071758547, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 0, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086420352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086426240, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1085548789, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1518700436, 1071758547, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 3, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086601216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085024256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1085837148, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2556364535, 1071781196, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, 4, "]", "[", 12, "heat sink", "]", "]", 0, "]", 0, "]", 0, "]" ],
					"whole_roll_data_count" : [ 3 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-30",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 0,
							"revision" : 2,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 59.0, 104.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-24",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 193.0, 80.0, 22.0 ],
									"text" : "prepend read"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 139.0, 169.0, 393.0, 22.0 ],
									"text" : "/Users/ben/Documents/audioguide/output/bachroll.txt"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"patching_rect" : [ 117.0, 100.0, 41.0, 22.0 ],
									"text" : "t s s 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 139.0, 138.0, 55.0, 22.0 ],
									"text" : "filewatch"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-28",
									"index" : 1,
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 117.0, 40.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-29",
									"index" : 1,
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 275.0, 30.0, 30.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 1 ],
									"source" : [ "obj-20", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-20", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"source" : [ "obj-24", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"source" : [ "obj-7", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 140.0, 148.0, 157.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p watch this file for changes"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 279.0, 286.0, 35.0, 22.0 ],
					"text" : "clear"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 140.0, 318.0, 29.0, 22.0 ],
					"text" : "thru"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"linecount" : 7,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 526.0, 39.0, 543.0, 114.0 ],
					"text" : "BACH_SLOTS_MAPPING = {\n'filepath': 1, 'sfskiptime': 2, 'sfchannels': 3, 'env': 4, \n# csf() only\n'sftransposition': 10, 'selectnumber': 11, 'filehead': 12, \n# csf(instrTag) only\n'dynamic': 20, 'articulation': 22, 'notehead': 23, 'annotation': 24, 'technique': 25, 'temporal_mode': 26,\n}\n"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 0,
							"revision" : 2,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 0.0, 0.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 138.0, 161.0, 22.0 ],
									"text" : "loadmess symbol annotation"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 8,
											"minor" : 0,
											"revision" : 2,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"classnamespace" : "box",
										"rect" : [ 59.0, 95.0, 867.0, 580.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-16",
													"linecount" : 3,
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 135.0, 40.0, 593.0, 60.0 ],
													"text" : "INSTRUMENTS_BACH_SLOTS_DICT = {1: 'technique', 2: 'temporal_mode', 3: 'selectnumber', 10: 'fullpath', 11: 'filename', 12: 'sfskiptime', 13: 'db_scale', 14: 'sftransposition', 15: 'sfchannels', 20: 'dynamic', 22: 'articulation', 23: 'notehead', 24: 'annotation'}\n"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-13",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 590.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1361.0, 612.0, 29.5, 22.0 ],
													"text" : "24"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 545.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1346.0, 597.0, 29.5, 22.0 ],
													"text" : "23"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-6",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 500.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1331.0, 582.0, 29.5, 22.0 ],
													"text" : "22"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 455.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1286.0, 582.0, 29.5, 22.0 ],
													"text" : "20"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-8",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 410.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1331.0, 582.0, 29.5, 22.0 ],
													"text" : "15"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-9",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 365.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1316.0, 567.0, 29.5, 22.0 ],
													"text" : "14"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-10",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 320.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1271.0, 567.0, 29.5, 22.0 ],
													"text" : "13"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 275.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1331.0, 582.0, 29.5, 22.0 ],
													"text" : "12"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 230.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1316.0, 567.0, 29.5, 22.0 ],
													"text" : "11"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 185.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1271.0, 567.0, 29.5, 22.0 ],
													"text" : "10"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 140.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1316.0, 567.0, 29.5, 22.0 ],
													"text" : "3"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-18",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 95.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1301.0, 552.0, 29.5, 22.0 ],
													"text" : "2"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 50.0, 219.0, 29.5, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1256.0, 552.0, 29.5, 22.0 ],
													"text" : "1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-12",
													"maxclass" : "newobj",
													"numinlets" : 14,
													"numoutlets" : 14,
													"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
													"patching_rect" : [ 50.0, 158.0, 604.0, 22.0 ],
													"presentation" : 1,
													"presentation_linecount" : 2,
													"presentation_rect" : [ 1256.0, 491.0, 156.0, 35.0 ],
													"text" : "route 0 1 2 3 4 5 6 7 8 9 10 11 12"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-11",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 64.0, 100.0, 50.0, 22.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1270.0, 433.0, 50.0, 22.0 ],
													"text" : "11"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-23",
													"index" : 1,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 51.0, 40.0, 30.0, 30.0 ]
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-24",
													"index" : 1,
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 50.0, 301.0, 30.0, 30.0 ]
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-10", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 0 ],
													"source" : [ "obj-12", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"source" : [ "obj-12", 6 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"source" : [ "obj-12", 12 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"source" : [ "obj-12", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-18", 0 ],
													"source" : [ "obj-12", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 0 ],
													"source" : [ "obj-12", 5 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"source" : [ "obj-12", 4 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"source" : [ "obj-12", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"source" : [ "obj-12", 11 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"source" : [ "obj-12", 10 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"source" : [ "obj-12", 9 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-8", 0 ],
													"source" : [ "obj-12", 8 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"source" : [ "obj-12", 7 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-13", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-14", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-18", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-11", 1 ],
													"order" : 0,
													"source" : [ "obj-23", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-12", 0 ],
													"order" : 1,
													"source" : [ "obj-23", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-5", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-6", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-8", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"source" : [ "obj-9", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 50.0, 203.0, 161.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"tags" : ""
									}
,
									"text" : "p key to slot default mapping"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 233.0, 128.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 7,
									"presentation_rect" : [ 1346.0, 552.0, 29.5, 102.0 ],
									"text" : "linkannotationtoslot $1"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 20.0,
									"id" : "obj-2",
									"items" : [ "technique", ",", "temporal_mode", ",", "selectnumber", ",", "fullpath", ",", "filename", ",", "sfskiptime", ",", "sftransposition", ",", "sfchannels", ",", "dynamic", ",", "articulation", ",", "notehead", ",", "annotation" ],
									"maxclass" : "umenu",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 50.0, 166.0, 163.0, 31.0 ]
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 18.0,
									"id" : "obj-44",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 100.0, 253.0, 27.0 ],
									"text" : "Changing What is Displayed"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"source" : [ "obj-25", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 932.0, 11.0, 49.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p menu"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.5, 231.0, 63.0, 22.0 ],
					"text" : "bgslots 4"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.5, 197.0, 128.0, 22.0 ],
					"presentation" : 1,
					"presentation_linecount" : 6,
					"presentation_rect" : [ 1361.0, 567.0, 29.5, 89.0 ],
					"text" : "linkannotationtoslot 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 688.5, 738.0, 53.0, 53.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "signal", "signal", "", "" ],
					"patching_rect" : [ 688.5, 700.5, 122.0, 22.0 ],
					"text" : "poly~ bach_sfplay 20"
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.827450980392157, 0.156862745098039, 0.156862745098039, 1.0 ],
					"bgcolor2" : [ 0.2, 0.2, 0.2, 1.0 ],
					"bgfillcolor_angle" : 270.0,
					"bgfillcolor_autogradient" : 0.0,
					"bgfillcolor_color" : [ 0.2, 0.2, 0.2, 1.0 ],
					"bgfillcolor_color1" : [ 0.827450980392157, 0.156862745098039, 0.156862745098039, 1.0 ],
					"bgfillcolor_color2" : [ 0.2, 0.2, 0.2, 1.0 ],
					"bgfillcolor_proportion" : 0.5,
					"bgfillcolor_type" : "gradient",
					"gradient" : 1,
					"id" : "obj-10",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 207.0, 221.0, 31.0, 22.0 ],
					"text" : "stop"
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.647058823529412, 0.996078431372549, 0.576470588235294, 1.0 ],
					"bgcolor2" : [ 0.2, 0.2, 0.2, 1.0 ],
					"bgfillcolor_angle" : 270.0,
					"bgfillcolor_autogradient" : 0.0,
					"bgfillcolor_color" : [ 0.2, 0.2, 0.2, 1.0 ],
					"bgfillcolor_color1" : [ 0.647058823529412, 0.996078431372549, 0.576470588235294, 1.0 ],
					"bgfillcolor_color2" : [ 0.2, 0.2, 0.2, 1.0 ],
					"bgfillcolor_proportion" : 0.5,
					"bgfillcolor_type" : "gradient",
					"gradient" : 1,
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 167.0, 221.0, 31.0, 22.0 ],
					"text" : "play"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-42",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 632.3333740234375, 266.0, 279.0, 20.0 ],
					"text" : "thin annotations to make the score more readable"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 520.5, 264.0, 100.0, 22.0 ],
					"text" : "thinannotations 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 140.0, 119.0, 291.0, 22.0 ],
					"text" : "/Users/ben/Documents/audioguide/output/bachroll.txt"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-37", 0 ],
					"source" : [ "obj-18", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 1 ],
					"source" : [ "obj-18", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 0 ],
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"source" : [ "obj-28", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-28", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-30", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-32", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"source" : [ "obj-7", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "bach_sfplay.maxpat",
				"bootpath" : "~/Documents/audioguide/maxmsp/bach",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "bach.slot2curve.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/bach/patchers",
				"patcherrelativepath" : "../../../Max 8/Packages/bach/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "bach.times.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/bach/patchers",
				"patcherrelativepath" : "../../../Max 8/Packages/bach/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "bach.x2dx.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/bach/patchers",
				"patcherrelativepath" : "../../../Max 8/Packages/bach/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "bach.filternull.maxpat",
				"bootpath" : "~/Documents/Max 8/Packages/bach/patchers",
				"patcherrelativepath" : "../../../Max 8/Packages/bach/patchers",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "thru.maxpat",
				"bootpath" : "C74:/patchers/m4l/Pluggo for Live resources/patches",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "bach.playkeys.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.trans.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.pick.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.expr.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.portal.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.args.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.iter.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.collect.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.flat.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.slice.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.lace.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.reg.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.eq.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.gt.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.join.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.keys.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.roll.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
