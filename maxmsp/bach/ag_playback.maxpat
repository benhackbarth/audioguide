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
		"rect" : [ 104.0, 79.0, 949.0, 1007.0 ],
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
					"id" : "obj-29",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 187.0, 366.0, 69.0, 25.0 ],
					"text" : "byebye"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 70.0, 368.0, 108.0, 22.0 ],
					"text" : "clear, numvoices 0"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-9",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 647.0, 196.5, 247.0, 40.0 ],
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
					"patching_rect" : [ 570.0, 205.5, 60.0, 22.0 ],
					"text" : "clefs auto"
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
					"patching_rect" : [ 149.0, 241.0, 267.0, 54.0 ],
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
					"patching_rect" : [ 97.0, 272.0, 44.0, 22.0 ],
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
					"patching_rect" : [ 110.0, 241.0, 31.0, 22.0 ],
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
					"patching_rect" : [ 647.0, 108.0, 247.0, 40.0 ],
					"text" : "thinannotations can help make things more readable"
				}

			}
, 			{
				"box" : 				{
					"attr" : "thinannotations",
					"fontsize" : 12.0,
					"id" : "obj-7",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 393.5, 117.0, 234.0, 22.0 ],
					"text_width" : 137.0
				}

			}
, 			{
				"box" : 				{
					"bwcompatibility" : 80100,
					"clefs" : [ "F", "FG", "FG" ],
					"defaultnoteslots" : [ "null" ],
					"enharmonictable" : [ "default", "default", "default" ],
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"hidevoices" : [ 0, 0, 0 ],
					"id" : "obj-17",
					"keys" : [ "CM", "CM", "CM" ],
					"linkannotationtoslot" : 20,
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
					"patching_rect" : [ 42.0, 415.08331298828125, 521.5, 361.375 ],
					"pitcheditrange" : [ "null" ],
					"showarticulations" : 0,
					"stafflines" : [ 5, 5, 5 ],
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"versionnumber" : 80100,
					"voicenames" : [ "target", "lachenmann.aiff", "heat sink.aiff" ],
					"voicespacing" : [ 9.75, 14.0, 17.0, 17.0 ],
					"whole_roll_data_0000000000" : [ "roll", "[", "slotinfo", "[", 1, "[", "name", "fullpath", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 2, "[", "name", "sfskiptime", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1076132577, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089386250, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1080410767, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 3, "[", "name", "sfchannels", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 4, "[", "name", "env", "]", "[", "type", "function", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "grid", "]", "[", "ysnap", "]", "[", "domain", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "domainslope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "duration", "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 5, "[", "name", "transposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 6, "[", "name", "selectionnumber", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1076101120, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1073741824, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 7, "[", "name", "3descriptors", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 2593473052, 1081488125, "_x_x_x_x_bach_float64_x_x_x_x_", 2271041267, 1085095858, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 2593473052, 1081488125, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 8, "[", "name", "12descriptors", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 3252630273, 3222772815, "_x_x_x_x_bach_float64_x_x_x_x_", 4286995837, 1075712884, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080213504, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 9, "[", "name", "power", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 2181431070, 1070471424, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 10, "[", "name", "transposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 11, "[", "name", "selectnumber", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1075970048, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 12, "[", "name", "filehead", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 13, "[", "name", "slot 13", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 14, "[", "name", "slot 14", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 15, "[", "name", "slot 15", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 16, "[", "name", "slot 16", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 17, "[", "name", "slot 17", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 18, "[", "name", "slot 18", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 19, "[", "name", "slot 19", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 20, "[", "name", "dynamics", "]", "[", "type", "dynamics", "]", "[", "key", "d", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 21, "[", "name", "lyrics", "]", "[", "type", "text", "]", "[", "key", "l", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 22, "[", "name", "articulations", "]", "[", "type", "articulations", "]", "[", "key", "a", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 23, "[", "name", "notehead", "]", "[", "type", "notehead", "]", "[", "key", "h", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 24, "[", "name", "annotation", "]", "[", "type", "text", "]", "[", "key", "t", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 25, "[", "name", "technique", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 26, "[", "name", "temporal_mode", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 27, "[", "name", "slot 27", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 28, "[", "name", "slot 28", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 29, "[", "name", "slot 29", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 30, "[", "name", "slot 30", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "]", "[", "commands", "[", 1, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 2, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 3, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 4, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 5, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "]", "[", "groups", "]", "[", "markers", "]", "[", "midichannels", 1, 2, 3, "]", "[", "articulationinfo", "]", "[", "noteheadinfo", "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085583616, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 943380977, 1061723096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 166850890, 1072691673, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086043648, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2233382994, 1081627115, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2555814779, 1061214142, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 274328151, 1072692170, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082339328, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085653248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082003456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993460, 1082340147, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1697096197, 1059799890, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3403263366, 1072692811, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083261952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085647104, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1083262894, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2636903761, 1060294415, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 504126081, 1072692646, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085606912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082507264, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1083629895, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2496441151, 1059250134, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 43430709, 1072692946, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085341696, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085601792, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085341696, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2059110401, 1062017301, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3131134238, 1072691385, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085612800, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085375774, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 913694163, 1060741092, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 58274116, 1072692428, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085443840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085679616, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081372672, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1085443932, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 108576773, 1060371725, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1583296744, 1072692608, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085629440, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993460, 1085551411, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1572576506, 1060195631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511278732, 1072692694, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085576960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1085797826, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 692142570, 1060616538, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3569014744, 1072692488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085683968, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1085871226, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3539053052, 1060135501, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3058016715, 1072692723, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085660160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584303, 1085976084, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 432932703, 1060887121, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3051144767, 1072692356, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086046720, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085592832, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188228, 1086046863, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 943380977, 1061723096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 166850890, 1072691673, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085595392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772530, 1086091427, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2998917965, 1060414674, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1705617413, 1072692587, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 8, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085657344, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082085376, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194768, 1086230364, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4225423186, 1059722580, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2863678035, 1072692830, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085680640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1086343086, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3272971238, 1062207957, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 354317622, 1072691199, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085632256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1086367989, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 589338232, 1060225696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2885393389, 1072692679, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085637120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1086419107, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 913694163, 1060741092, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 58274116, 1072692428, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085611008, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082359808, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1, 1086488576, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2296604913, 1059387573, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1957130697, 1072692912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 10, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086593408, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085645568, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080827904, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980379, 1086593433, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2059110401, 1060968725, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3713050767, 1072692316, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085478400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194768, 1086623580, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2998917965, 1060414674, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1705617413, 1072692587, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 9, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086178048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369912, 1088714833, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085447936, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1088530022, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085700096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087798640, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085980416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1084196126, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081372672, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085939456, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993460, 1087812403, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085108224, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1083525038, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]" ],
					"whole_roll_data_0000000001" : [ "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085981696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1083682324, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085999616, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1088952729, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 8, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086376576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1081752944, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1083189493, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086161664, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1088116490, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086200832, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980377, 1089108377, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088910786, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081835520, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085472000, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369912, 1088477265, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085507072, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1088513638, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086189824, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1089121812, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082339328, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086333952, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1086792663, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082507264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085377280, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1089092976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3400789465, 1067280716, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085966848, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1082864435, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082570752, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086358784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089386250, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2137175726, 1067531737, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082863616, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085884416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1087117721, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086208512, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1087950684, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082927104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1083189493, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083315200, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085721344, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1088969113, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785611, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083345920, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396075, 1088088965, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089066762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083409408, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1089038254, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168605, 1087527976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086255872, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089061847, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083671552, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083681792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085637918, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083734016, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088581795, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083744256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085371392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1089053982, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086137088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194768, 1087835996, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 8, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086349696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089012695, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1067572069, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083881472, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085349376, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085108224, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1083525038, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085420032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088525762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 8, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085421568, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088501186, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085426688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088464158, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085459968, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1088488407, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085472000, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3951369912, 1088477265, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085507072, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1088513638, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085981696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1083682324, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086333952, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1086792663, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085388800, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316288, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1086716641, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085637918, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085409792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085414912, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1089038254, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0 ],
					"whole_roll_data_0000000002" : [ "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085417472, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085505280, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1088484474, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 9, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1088369459, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396075, 1088088965, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085980416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1084196126, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 8, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085443840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086073088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1087914639, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085448960, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168605, 1087527976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086137088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194768, 1087835996, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086213120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1087636766, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2137175726, 1067531737, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086255872, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089061847, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085477888, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785611, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085490944, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085978112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1083860582, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086170880, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1086885724, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086200832, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980377, 1089108377, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085553920, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085556480, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085371392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1089053982, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089345290, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085559040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088581795, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085637918, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085580032, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986919, 1087071846, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2573956721, 1068222220, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086084352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188226, 1089086095, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168605, 1087527976, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085805568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086137088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194768, 1087835996, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086282752, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1089003520, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085837056, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1085637918, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1078071151, 1067615422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085844992, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1089038254, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085951488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088576225, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086084352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188226, 1089086095, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085910528, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1374389535, 1088569016, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085931520, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1083189493, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085934080, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085884416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1087117721, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085936640, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085944576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085108224, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1083525038, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085965568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085981184, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993459, 1088369459, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1088071925, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2698476412, 1067826479, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785611, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085994240, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085700096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087798640, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085980416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1084196126, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 8, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1084028354, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 9, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089345290, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086046720, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085969152, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1086046863, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918 ],
					"whole_roll_data_0000000003" : [ 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086378496, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396075, 1088007045, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086333952, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1086792663, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086099200, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396075, 1088088965, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086084352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188226, 1089086095, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086208512, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1087950684, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086135808, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086336128, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1086821498, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1068040187, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086143744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085683712, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1083367751, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085981696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1083682324, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086215168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1085907927, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089066762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086255872, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089061847, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785611, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086261760, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086086400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1084290498, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086168064, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2233382994, 1084379627, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085981696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1083682324, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086373120, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085937152, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1087874007, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086375808, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085505280, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1088484474, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085841920, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3607772529, 1088721059, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086382336, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085439488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2061584302, 1088507412, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086193920, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993460, 1089139507, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085426688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088464158, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086420352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986919, 1087071846, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2573956721, 1068222220, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089345290, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086426880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085884416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1087117721, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086432128, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085683712, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1083367751, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085700096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087798640, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087962480, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086113536, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 343597384, 1087162286, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086255872, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1089061847, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086495104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089066762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785611, 1085999677, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086500352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1085727047, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1088060129, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504192, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085394176, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986919, 1085040230, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1067077846, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088701726, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086512128, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085977088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1087668224, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3251805639, 1068449786, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086593408, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086333952, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 171798692, 1086792663, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3226791750, 1067962173, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086601216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1089066762, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086602496, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085390080, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980377, 1087543705, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086626176, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986919, 1087071846, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2573956721, 1068222220, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086627456, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1089022525, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2989022360, 1068126422, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085884416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1087117721, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983232, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396076, 1087613829, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[" ],
					"whole_roll_data_0000000004" : [ "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086631424, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 515396075, 1088088965, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1487089477, 1068329326, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086640512, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085700096, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2748779069, 1087798640, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086648448, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085421568, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181686, 1088501186, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086651008, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085426688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3092376453, 1088464158, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085546240, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1085810933, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082486784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085026816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1085968220, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082843136, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086374272, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1086446632, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083251712, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086093056, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1086821498, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083273216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085664768, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2920577762, 1086808391, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083283456, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085726976, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1086872616, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086221568, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181685, 1086846402, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085341696, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085867008, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571220, 1085412474, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085349376, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085053440, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1086592122, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 9, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086221568, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 2405181685, 1086846402, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085960192, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086213888, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1085103144, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3972260633, 1068620645, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 4, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085962752, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086372352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1202590843, 1076132577, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3738614412, 1068542631, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086213632, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1086754652, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085981184, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086221056, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1086740234, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086046720, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085533696, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085931520, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086221056, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1086740234, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 1, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086240768, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086222592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3435973837, 1086246092, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2001111163, 1068710672, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085546240, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1085810933, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085697024, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 687194767, 1086361436, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086374528, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085810944, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3264175145, 1081878773, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086381056, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086226688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1082507919, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086382336, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085053440, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571221, 1086592122, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 5, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086385024, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085019648, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1030792151, 1086936842, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2929373854, 1068939815, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 7, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415104, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1717986919, 1086023270, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1617106727, 1069270813, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086420352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085873408, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 1889785610, 1086622269, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 2, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086430848, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085027840, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 3779571220, 1086952570, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3460437971, 1069088763, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 6, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086605184, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085052928, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 858993460, 1086501683, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 3, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085726976, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat sink.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 4123168604, 1086872616, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3599526191, 1068815697, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 5, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 6, 0, "]", "]", 0, "]", 0, "]", 0, "]" ],
					"whole_roll_data_count" : [ 5 ]
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
					"patching_rect" : [ 570.0, 467.75, 325.0, 40.0 ],
					"text" : "you can remove the target soundfile from the roll by setting BACH_INCLUDE_TARGET=False"
				}

			}
, 			{
				"box" : 				{
					"bubble" : 1,
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-42",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 647.0, 30.0, 247.0, 69.0 ],
					"text" : "visualize data placed into bach slots. you can change what data is put into which slots with the audioguide option BACH_SLOTS_MAPPING"
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
					"patching_rect" : [ 592.0, 554.0, 195.0, 40.0 ],
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
					"patching_rect" : [ 570.0, 625.0, 327.0, 98.0 ],
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
						"rect" : [ 891.0, 452.0, 867.0, 580.0 ],
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
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 338.0, 229.0, 47.0, 22.0 ],
									"text" : "bgslots"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 273.0, 162.0, 84.0, 22.0 ],
									"text" : "route 4"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-21",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 273.0, 195.0, 183.0, 22.0 ],
									"text" : "bgslots 4, linkannotationtoslot 20"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 124.571426391601562, 363.0, 121.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 6,
									"presentation_rect" : [ 1331.0, 582.0, 29.5, 89.0 ],
									"text" : "linkannotationtoslot 6"
								}

							}
, 							{
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
									"patching_rect" : [ 112.142860412597656, 330.0, 121.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 6,
									"presentation_rect" : [ 1316.0, 567.0, 29.5, 89.0 ],
									"text" : "linkannotationtoslot 5"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 87.285713195800781, 302.0, 121.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 6,
									"presentation_rect" : [ 1271.0, 567.0, 29.5, 89.0 ],
									"text" : "linkannotationtoslot 3"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 74.857139587402344, 274.0, 121.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 6,
									"presentation_rect" : [ 1316.0, 567.0, 29.5, 89.0 ],
									"text" : "linkannotationtoslot 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 62.428569793701172, 243.0, 121.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 6,
									"presentation_rect" : [ 1301.0, 552.0, 29.5, 89.0 ],
									"text" : "linkannotationtoslot 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 213.0, 128.0, 22.0 ],
									"presentation" : 1,
									"presentation_linecount" : 7,
									"presentation_rect" : [ 1256.0, 552.0, 29.5, 102.0 ],
									"text" : "linkannotationtoslot 20"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "newobj",
									"numinlets" : 8,
									"numoutlets" : 8,
									"outlettype" : [ "", "", "", "", "", "", "", "" ],
									"patching_rect" : [ 50.0, 158.0, 106.0, 22.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 1256.0, 491.0, 156.0, 22.0 ],
									"text" : "route 0 1 2 3 4 5 6"
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
									"text" : "0"
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
									"patching_rect" : [ 50.0, 359.0, 30.0, 30.0 ]
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
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-12", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"source" : [ "obj-12", 5 ]
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
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 1 ],
									"order" : 1,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"order" : 2,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"order" : 0,
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
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"source" : [ "obj-5", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 442.5, 78.0, 185.0, 22.0 ],
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
					"fontsize" : 20.0,
					"id" : "obj-12",
					"items" : [ "--", ",", "fullpath", ",", "sfskiptime", ",", "sfchannels", ",", "env", ",", "transposition", ",", "selectionnumber" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 442.5, 41.0, 185.0, 31.0 ]
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
					"patching_rect" : [ 566.0, 564.25, 20.0, 20.0 ],
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
					"midpoints" : [ 106.5, 314.0, 51.5, 314.0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"midpoints" : [ 482.214285714285722, 909.749979654947879, 584.035714285714221, 909.749979654947879, 584.035714285714221, 808.0, 607.0, 808.0 ],
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
					"destination" : [ "obj-19", 0 ],
					"source" : [ "obj-20", 0 ]
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
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 452.0, 313.0, 51.5, 313.0 ],
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
					"destination" : [ "obj-17", 0 ],
					"midpoints" : [ 79.5, 402.041656494140625, 51.5, 402.041656494140625 ],
					"source" : [ "obj-27", 0 ]
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
					"midpoints" : [ 579.5, 314.0, 51.5, 314.0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 119.5, 315.5, 51.5, 315.5 ],
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"midpoints" : [ 403.0, 313.791656494140625, 51.5, 313.791656494140625 ],
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
