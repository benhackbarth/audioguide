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
		"rect" : [ 448.0, 80.0, 949.0, 1007.0 ],
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
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-9",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.0, 347.0, 260.0, 40.0 ],
					"text" : "automatically adjust clefs to adapt to the registral content of each voice"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 503.5, 356.0, 60.0, 22.0 ],
					"text" : "clefs auto"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 503.5, 228.0, 47.0, 22.0 ],
					"text" : "bgslots"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-24",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.0, 269.0, 329.0, 54.0 ],
					"text" : "click on the clef of a stave to highlight the whole voice, then press solo, and play to only hear one voice. unsolo turns this off"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 511.0, 300.0, 44.0, 22.0 ],
					"text" : "unsolo"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 524.0, 269.0, 31.0, 22.0 ],
					"text" : "solo"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-13",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.0, 132.0, 247.0, 40.0 ],
					"text" : "thinannotation can help make things more readable"
				}

			}
, 			{
				"box" : 				{
					"attr" : "thinannotations",
					"fontsize" : 13.0,
					"id" : "obj-7",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 315.5, 140.5, 235.0, 23.0 ],
					"text_width" : 137.0
				}

			}
, 			{
				"box" : 				{
					"bwcompatibility" : 80100,
					"clefs" : [ "FG", "FG", "FG" ],
					"defaultnoteslots" : [ "null" ],
					"enharmonictable" : [ "default", "default", "default" ],
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"hidevoices" : [ 0, 0, 0 ],
					"id" : "obj-17",
					"keys" : [ "CM", "CM", "CM" ],
					"linkannotationtoslot" : 6,
					"linkdynamicstoslot" : 0,
					"loop" : [ 0.0, 1000.0 ],
					"maxclass" : "bach.roll",
					"midichannels" : [ 1, 2, 3 ],
					"numinlets" : 6,
					"numoutlets" : 8,
					"numparts" : [ 1, 1, 1 ],
					"numvoices" : 3,
					"out" : "nnnnnnn",
					"outlettype" : [ "", "", "", "", "", "", "", "bang" ],
					"patching_rect" : [ 42.0, 415.08331298828125, 521.5, 440.375 ],
					"pitcheditrange" : [ "null" ],
					"showarticulations" : 0,
					"stafflines" : [ 5, 5, 5 ],
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"versionnumber" : 80100,
					"voicenames" : [ "heat sink.aiff", "lachenmann.aiff", "mutedpizz" ],
					"voicespacing" : [ 9.75, 14.0, -1.75, 41.75 ],
					"whole_roll_data_0000000000" : [ "roll", "[", "slotinfo", "[", 1, "[", "name", "fullpath", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 2, "[", "name", "sfskiptime", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1089161461, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1080410767, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 3, "[", "name", "sfchannels", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 4, "[", "name", "env", "]", "[", "type", "function", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "grid", "]", "[", "ysnap", "]", "[", "domain", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "domainslope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "duration", "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 5, "[", "name", "transposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 6, "[", "name", "selectionnumber", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1073741824, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1074266112, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 7, "[", "name", "3descriptors", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "_x_x_x_x_bach_float64_x_x_x_x_", 2757850040, 1084946271, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 2178957168, 1080958977, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 8, "[", "name", "12descriptors", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 2534374302, 3222607644, "_x_x_x_x_bach_float64_x_x_x_x_", 1601988442, 1075864156, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080213504, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 9, "[", "name", "power", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 2517056994, 1070228515, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 10, "[", "name", "transposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 11, "[", "name", "selectnumber", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1075970048, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 12, "[", "name", "filehead", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 13, "[", "name", "slot 13", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 14, "[", "name", "slot 14", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 15, "[", "name", "slot 15", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 16, "[", "name", "slot 16", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 17, "[", "name", "slot 17", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 18, "[", "name", "slot 18", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 19, "[", "name", "slot 19", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 20, "[", "name", "dynamics", "]", "[", "type", "dynamics", "]", "[", "key", "d", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 21, "[", "name", "lyrics", "]", "[", "type", "text", "]", "[", "key", "l", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 22, "[", "name", "articulations", "]", "[", "type", "articulations", "]", "[", "key", "a", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 23, "[", "name", "notehead", "]", "[", "type", "notehead", "]", "[", "key", "h", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 24, "[", "name", "annotation", "]", "[", "type", "text", "]", "[", "key", "t", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 25, "[", "name", "technique", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 26, "[", "name", "temporal_mode", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 27, "[", "name", "slot 27", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 28, "[", "name", "slot 28", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 29, "[", "name", "slot 29", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 30, "[", "name", "slot 30", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "]", "[", "commands", "[", 1, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 2, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 3, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 4, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 5, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "]", "[", "groups", "]", "[", "markers", "]", "[", "midichannels", 1, 2, 3, "]", "[", "articulationinfo", "]", "[", "noteheadinfo", "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3067833792, 1081924461, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086173184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1086821498, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2886492901, 1071872227, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086220288, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597383, 1086834606, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1071644672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2886492901, 1071872227, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086178048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369912, 1088714833, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086149888, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3435973836, 1086868684, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086358528, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1088388464, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082339328, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086208256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1087922503, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082843136, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1088569016, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083251712, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086264064, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081122816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1088901939, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1067662096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083273216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086258432, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081290752, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396075, 1088555909, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1067494055, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085686784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1087489966, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085338880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086149888, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3435973836, 1086868684, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086113536, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1087162286, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086205952, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188226, 1089127055, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085417472, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085726464, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1087483412, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086275072, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369913, 1088895057, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1089161461, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4099803982, 1067033621, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086161664, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1088116490, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085915648, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1088569016, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086275072, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369913, 1088895057, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085951488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088576225, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824 ],
					"whole_roll_data_0000000001" : [ 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085969152, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1086046863, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086113536, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1087162286, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086149888, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3435973836, 1086868684, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089066762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086266880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085686784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1087489966, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086290432, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1088569016, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085951488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088576225, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088581795, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086264064, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081122816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1088901939, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1067662096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085386496, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590842, 1084783329, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1066718545, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086592000, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086208256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577761, 1087922503, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086607744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085951488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088576225, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1088569016, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086647168, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-F6-mp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3868356784, 1067280783, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086121984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-D5-mf_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1066718545, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082339328, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082296320, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/I-G7-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4050875715, 1066483127, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082570752, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082191872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/I-G7-ff_2.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3986004529, 1066589763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082843136, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086773760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081794560, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/I-A8-f_4.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 845524442, 1066913564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083251712, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086684160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082191872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-D8-f_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3986004529, 1066589763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086684160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-D8-mp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3868356784, 1067280783, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083650048, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086070784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082402816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-C5-f_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 7421703, 1066385149, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085351936, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086198784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082402816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-F5-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 7421703, 1066385149, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082191872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-G7-ff_2.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3986004529, 1066589763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085417472, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085865984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-E4-p_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086121984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-D5-pp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1590993325, 1068620612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082443776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-C7-f_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 624797482, 1066321127, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085469952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082423296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-F6-ff_2.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1338105651, 1066352668, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085865984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082085376, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-E4-mf_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2832616831, 1066690695, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085865984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082275840, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-E4-f_3.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 716881581, 1066502992, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085800448, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086198784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082402816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-F5-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 7421703, 1066385149, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086338560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082359808, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-B5-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3452191633, 1066427561, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085763584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-C4-mp_2.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1067077846, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086338560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-B5-mp_3.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1530795064, 1067124487, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085915648, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085993984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081835520, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-A4-mp_3.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1762242261, 1066877325, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085936640, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086070784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082402816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-C5-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 7421703, 1066385149, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086121984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-D5-pp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1590993325, 1068620612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248 ],
					"whole_roll_data_0000000002" : [ "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081708544, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-F6-mp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1066991611, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086773760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081794560, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/I-A8-f_4.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 845524442, 1066913564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086198784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082402816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-F5-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 7421703, 1066385149, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082318848, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-C7-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3938175773, 1066464001, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081413632, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-F6-mp_3.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2630031814, 1067339168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086243328, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086338560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-B5-mf_2.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1066718545, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086266880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086351360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-C6-mp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3868356784, 1067280783, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086290432, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082085376, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-F6-mf_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2832616831, 1066690695, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086314240, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086338560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082003456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-B5-mp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4192712715, 1066747603, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086373120, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085942784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082359808, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-G4-f_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3452191633, 1066427561, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082171392, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-G7-mf_2.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1066613520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086428160, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086070784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082402816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-C5-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 7421703, 1066385149, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082359808, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/II-C7-ff_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3452191633, 1066427561, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086489856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-F6-pp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086592000, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/III-C7-mf_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1066718545, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086649728, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085942784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081876480, 127, "[", "slots", "[", 1, "/Users/ben/Documents/sfdb/violin/mutedpizz/IV-G4-mp_1.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 3, 2, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 548106546, 1066842630, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "[", 7, "_x_x_x_x_bach_float64_x_x_x_x_", 153931628, 1081383952, "]", "[", 8, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 9, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", 0, "]" ],
					"whole_roll_data_count" : [ 3 ]
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-43",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.0, 489.0, 324.0, 40.0 ],
					"text" : "you can remove the target soundfile data from the roll by setting BACH_INCLUDE_TARGET=False"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-42",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 575.0, 24.5, 336.0, 54.0 ],
					"text" : "visualize data placed into bach slots. you can change what data is put into which slots with the audioguide option BACH_SLOTS_MAPPING"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-41",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.0, 197.0, 247.0, 54.0 ],
					"text" : "visualize each corpus sound's envelope data taken from csf(onsetLen) and csf(offsetLen)"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-38",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 726.0, 837.5, 153.0, 40.0 ],
					"text" : "a hacky sfplay-based player"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-37",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 596.0, 432.75, 195.0, 40.0 ],
					"text" : "select a note and press 'v' to listen to individual sounds!"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-36",
					"linecount" : 6,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 570.0, 561.0, 324.0, 98.0 ],
					"text" : "Target and Corpus pitches are taken from tsf(midiPitchMethod) and csf(midiPitchMethod). by default, this will look for a pitch written into each soundfile name. if none is found it will use averaged f0. you can specify other methods -- see the audioguide documentation."
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-35",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 149.0, 170.0, 146.0, 25.0 ],
					"text" : "\"play\" the output file "
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-15",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 70.0, 47.0, 242.0, 25.0 ],
					"text" : "open audioguide's bachroll.txt output"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-30",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 41.0, 113.0, 80.0, 22.0 ],
					"text" : "prepend read"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-28",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 41.0, 47.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"patching_rect" : [ 41.0, 81.0, 67.0, 22.0 ],
					"text" : "opendialog"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-23",
					"maxclass" : "newobj",
					"numinlets" : 0,
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
									"id" : "obj-3",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 50.0, 100.0, 58.0, 22.0 ],
									"text" : "loadbang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-32",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 159.0, 67.0, 22.0 ],
									"text" : "busymap 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 50.0, 130.0, 63.0, 22.0 ],
									"text" : "metro 100"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-22",
									"index" : 1,
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 241.0, 30.0, 30.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-32", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"source" : [ "obj-32", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 693.0, 813.0, 73.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p busy code"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-20",
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
									"id" : "obj-20",
									"linecount" : 2,
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 129.25, 115.0, 35.0 ],
									"text" : "sprintf set %i active instances"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 50.0, 100.0, 43.0, 22.0 ],
									"text" : "zl sum"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-15",
									"index" : 1,
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 40.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-16",
									"index" : 1,
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 224.25, 30.0, 30.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"source" : [ "obj-15", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 0 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-37", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 665.5, 881.75, 48.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p count"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
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
						"rect" : [ 921.0, 452.0, 867.0, 580.0 ],
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
									"id" : "obj-16",
									"linecount" : 3,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 135.0, 40.0, 593.0, 60.0 ],
									"text" : "BACH_SLOTS_MAPPING = {1: 'fullpath', 2: 'sfskiptime', 3: 'sfchannels', 4: 'env', 5: 'transposition', 6: 'selectionnumber', 20: 'instr_dynamic', 22: 'instr_articulation', 23: 'instr_notehead', 24: 'instr_annotation', 25: 'instr_technique', 26: 'instr_temporal_mode'}\n"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 230.0, 219.0, 29.5, 22.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 1316.0, 567.0, 29.5, 22.0 ],
									"text" : "6"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 185.0, 219.0, 29.5, 22.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 1271.0, 567.0, 29.5, 22.0 ],
									"text" : "5"
								}

							}
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "newobj",
									"numinlets" : 6,
									"numoutlets" : 6,
									"outlettype" : [ "", "", "", "", "", "" ],
									"patching_rect" : [ 50.0, 158.0, 86.0, 22.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 1256.0, 491.0, 156.0, 22.0 ],
									"text" : "route 0 1 2 3 4"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 64.0, 100.0, 50.0, 22.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 1270.0, 433.0, 50.0, 22.0 ],
									"text" : "4"
								}

							}
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-12", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-12", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"source" : [ "obj-12", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"source" : [ "obj-12", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-18", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 1 ],
									"order" : 0,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"order" : 1,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-4", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 387.5, 73.0, 161.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p key to slot default mapping"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 387.5, 103.0, 128.0, 22.0 ],
					"presentation" : 1,
					"presentation_linecount" : 7,
					"presentation_rect" : [ 1346.0, 552.0, 29.5, 102.0 ],
					"text" : "linkannotationtoslot $1"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 20.0,
					"id" : "obj-12",
					"items" : [ "fullpath", ",", "sfskiptime", ",", "sfchannels", ",", "transposition", ",", "selectionnumber" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 387.5, 36.0, 163.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 665.5, 912.5, 119.0, 20.0 ],
					"text" : "0 active instances"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 597.5, 813.0, 79.0, 22.0 ],
					"text" : "prepend note"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 42.0, 336.0, 29.0, 22.0 ],
					"text" : "thru"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 493.5, 197.0, 57.0, 22.0 ],
					"text" : "bgslots 4"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 597.5, 884.0, 53.0, 53.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "signal", "signal", "", "" ],
					"patching_rect" : [ 597.5, 846.5, 122.0, 22.0 ],
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
					"fontsize" : 18.0,
					"gradient" : 1,
					"id" : "obj-10",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 99.0, 202.0, 43.0, 29.0 ],
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
					"fontsize" : 18.0,
					"gradient" : 1,
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 99.0, 170.0, 42.0, 29.0 ],
					"text" : "play"
				}

			}
, 			{
				"box" : 				{
					"background" : 1,
					"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
					"hint" : "",
					"id" : "obj-3",
					"ignoreclick" : 1,
					"legacytextcolor" : 1,
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 570.0, 443.0, 20.0, 20.0 ],
					"rounded" : 60.0,
					"text" : "3",
					"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"background" : 1,
					"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
					"hint" : "",
					"id" : "obj-39",
					"ignoreclick" : 1,
					"legacytextcolor" : 1,
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 70.0, 175.0, 20.0, 20.0 ],
					"rounded" : 60.0,
					"text" : "2",
					"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"background" : 1,
					"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
					"hint" : "",
					"id" : "obj-93",
					"ignoreclick" : 1,
					"legacytextcolor" : 1,
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 14.0, 49.0, 20.0, 20.0 ],
					"rounded" : 60.0,
					"text" : "1",
					"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
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
					"midpoints" : [ 108.5, 313.0, 51.5, 313.0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 108.5, 313.0, 51.5, 313.0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 520.5, 324.0, 286.0, 324.0, 286.0, 325.0, 51.5, 325.0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"midpoints" : [ 482.214285714285722, 956.749979654947879, 584.035714285714221, 956.749979654947879, 584.035714285714221, 808.0, 607.0, 808.0 ],
					"source" : [ "obj-17", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
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
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 513.0, 314.5, 51.5, 314.5 ],
					"source" : [ "obj-2", 0 ]
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
					"midpoints" : [ 503.0, 314.0, 51.5, 314.0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-26", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"source" : [ "obj-28", 0 ]
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
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 513.0, 395.0, 282.25, 395.0, 282.25, 325.0, 51.5, 325.0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 533.5, 325.0, 51.5, 325.0 ],
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 397.0, 313.0, 51.5, 313.0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"midpoints" : [ 325.0, 313.791656494140625, 51.5, 313.791656494140625 ],
					"source" : [ "obj-7", 0 ]
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
