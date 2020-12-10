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
		"rect" : [ 418.0, 79.0, 981.0, 880.0 ],
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
					"id" : "obj-8",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 67.0, 683.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 250.0, 815.0, 112.0, 22.0 ],
					"text" : "poly~ playsound 20"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 250.0, 781.0, 79.0, 22.0 ],
					"text" : "prepend note"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 385.0, 781.0, 574.0, 22.0 ],
					"text" : "0. 317. /Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_A#5.wav 0. 0. 1 1. 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 8,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 250.0, 745.0, 92.5, 22.0 ],
					"text" : "pack f f s f f i f f"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 129.0, 247.0, 31.0, 22.0 ],
					"text" : "stop"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 285.0, 449.0, 34.0 ],
					"text" : "10: 'fullpath', 12: 'sfskiptime', 13: 'db_scale', 14: 'sftransposition', 15: 'sfchannels',\n"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-49",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 8,
					"outlettype" : [ "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 250.0, 702.0, 372.0, 23.0 ],
					"saved_object_attributes" : 					{
						"versionnumber" : 80100
					}
,
					"text" : "bach.playkeys [slot 12] duration [slot 10 13 14 15 16 17] @out t"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 88.0, 247.0, 31.0, 22.0 ],
					"text" : "play"
				}

			}
, 			{
				"box" : 				{
					"bwcompatibility" : 80100,
					"clefs" : [ "G", "G" ],
					"defaultnoteslots" : [ "null" ],
					"enharmonictable" : [ "default", "default" ],
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"hidevoices" : [ 0, 0 ],
					"id" : "obj-3",
					"keys" : [ "CM", "CM" ],
					"loop" : [ 0.0, 1000.0 ],
					"maxclass" : "bach.roll",
					"midichannels" : [ 1, 2 ],
					"numinlets" : 6,
					"numoutlets" : 8,
					"numparts" : [ 1, 1 ],
					"numvoices" : 2,
					"out" : "nnnnnnn",
					"outlettype" : [ "", "", "", "", "", "", "", "bang" ],
					"patching_rect" : [ 60.0, 337.0, 526.0, 186.666666666666686 ],
					"pitcheditrange" : [ "null" ],
					"stafflines" : [ 5, 5 ],
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"versionnumber" : 80100,
					"voicenames" : [ "violin", "violin" ],
					"voicespacing" : [ 0.0, 17.0, 17.0 ],
					"whole_roll_data_0000000000" : [ "roll", "[", "slotinfo", "[", 1, "[", "name", "technique", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 2, "[", "name", "temporal_mode", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 3, "[", "name", "selectnumber", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080016896, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 4, "[", "name", "slot floatlist", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 5, "[", "name", "slot int", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080016896, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 6, "[", "name", "slot float", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 7, "[", "name", "slot text", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 8, "[", "name", "slot filelist", "]", "[", "type", "filelist", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080213504, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 9, "[", "name", "slot spat", "]", "[", "type", "spat", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1076101120, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "auto", "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 10, "[", "name", "fullpath", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 11, "[", "name", "filename", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 12, "[", "name", "sfskiptime", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 13, "[", "name", "db_scale", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 14, "[", "name", "sftransposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 15, "[", "name", "sfchannels", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 16, "[", "name", "env_onset", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 17, "[", "name", "env_offset", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 18, "[", "name", "slot 18", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 19, "[", "name", "slot 19", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 20, "[", "name", "dynamics", "]", "[", "type", "dynamics", "]", "[", "key", "d", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 21, "[", "name", "lyrics", "]", "[", "type", "text", "]", "[", "key", "l", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 22, "[", "name", "articulations", "]", "[", "type", "articulations", "]", "[", "key", "a", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 23, "[", "name", "notehead", "]", "[", "type", "notehead", "]", "[", "key", "h", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 24, "[", "name", "annotation", "]", "[", "type", "text", "]", "[", "key", "t", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 25, "[", "name", "slot 25", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 26, "[", "name", "slot 26", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 27, "[", "name", "slot 27", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 28, "[", "name", "slot 28", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 29, "[", "name", "slot 29", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 30, "[", "name", "slot 30", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "]", "[", "commands", "[", 1, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 2, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 3, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 4, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 5, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "]", "[", "groups", "]", "[", "markers", "]", "[", "midichannels", 1, 2, "]", "[", "articulationinfo", "]", "[", "noteheadinfo", "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086415360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/artificial-harmonic/Vn-art-harm-F6-f-3c.aif", "]", "[", 11, "Vn-art-harm-F6-f-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086173184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-E5-ff-4c.aif", "]", "[", 11, "Vn-pont-E5-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082318848, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086479360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A#6-ff-1c.aif", "]", "[", 11, "Vn-ord-A#6-ff-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082486784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-F4-pp-3c.aif", "]", "[", 11, "Vn-ord-F4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082843136, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086440960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-G6-ff-2c.aif", "]", "[", 11, "Vn-ord-G6-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083241472, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086121984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-D5-ff-3c.aif", "]", "[", 11, "Vn-pont-D5-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083325440, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086045184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081122816, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-B4-pp-3c.aif", "]", "[", 11, "Vn-pont-B4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085814784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-D4-ff-3c.aif", "]", "[", 11, "Vn-ord-D4-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083901952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086671360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/artificial-harmonic/Vn-art-harm-C#8-f-1c.aif", "]", "[", 11, "Vn-art-harm-C#8-f-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085328384, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085686784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A3-ff-4c.aif", "]", "[", 11, "Vn-ord-A3-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085349376, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079263232, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-F4-pp-3c.aif", "]", "[", 11, "Vn-ord-F4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085840384, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-D#4-ff-4c.aif", "]", "[", 11, "Vn-ord-D#4-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085396736, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086121984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 3, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-D5-pp-3c.aif", "]", "[", 11, "Vn-ord-D5-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085712384, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081372672, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A#3-ff-4c.aif", "]", "[", 11, "Vn-ord-A#3-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085462272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085540864, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-F4-ff-3c.aif", "]", "[", 11, "Vn-pont-F4-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086070784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 3, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-C5-ff-2c.aif", "]", "[", 11, "Vn-pont-C5-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085658880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086492160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_B6.wav", "]", "[", 11, "VI_stac_p_B6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_G7.wav", "]", "[", 11, "VI_stac_p_G7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086096384, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_f_C#5.wav", "]", "[", 11, "VI_stac_f_C#5.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085818624, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086402560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_E6.wav", "]", "[", 11, "VI_stac_p_E6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086492160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/artificial-harmonic/Vn-art-harm-B6-f-3c.aif", "]", "[", 11, "Vn-art-harm-B6-f-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085913088, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-F4-ff-3c.aif", "]", "[", 11, "Vn-pont-F4-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085934080, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086045184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-B4-pp-3c.aif", "]", "[", 11, "Vn-pont-B4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086019584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A#4-ff-4c.aif", "]", "[", 11, "Vn-ord-A#4-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086492160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-B6-ff-1c.aif", "]", "[", 11, "Vn-ord-B6-ff-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086059776, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079263232, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-F4-pp-3c.aif", "]", "[", 11, "Vn-ord-F4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-F4-ff-3c.aif", "]", "[", 11, "Vn-pont-F4-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086112256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086045184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 3, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-B4-pp-3c.aif", "]", "[", 11, "Vn-pont-B4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086045184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 7, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-B4-mf-2c.aif", "]", "[", 11, "Vn-ord-B4-mf-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_" ],
					"whole_roll_data_0000000001" : [ 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mf", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086325760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A#5-ff-2c.aif", "]", "[", 11, "Vn-ord-A#5-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086279936, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085789184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081290752, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-C#4-ff-4c.aif", "]", "[", 11, "Vn-pont-C#4-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086338560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-B5-ff-3c.aif", "]", "[", 11, "Vn-ord-B5-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086365312, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085686784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A3-ff-4c.aif", "]", "[", 11, "Vn-ord-A3-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086375808, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 3, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086440960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 3, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-G6-ff-2c.aif", "]", "[", 11, "Vn-ord-G6-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086530560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-D7-ff-1c.aif", "]", "[", 11, "Vn-ord-D7-ff-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086463616, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086351360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 7, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-C6-mf-1c.aif", "]", "[", 11, "Vn-ord-C6-mf-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mf", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086474112, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078558720, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086487168, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086453760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082003456, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/artificial-harmonic/Vn-art-harm-G#6-f-3c.aif", "]", "[", 11, "Vn-art-harm-G#6-f-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086500352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086453760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/artificial-harmonic/Vn-art-harm-G#6-p-3c.aif", "]", "[", 11, "Vn-art-harm-G#6-p-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086590720, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085686784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A3-ff-4c.aif", "]", "[", 11, "Vn-ord-A3-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086601216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086275584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 0, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-G#5-ff-2c.aif", "]", "[", 11, "Vn-ord-G#5-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086453760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-G#6-ff-1c.aif", "]", "[", 11, "Vn-ord-G#6-ff-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086096384, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-C#5-ff-4c.aif", "]", "[", 11, "Vn-ord-C#5-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082318848, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086453760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_G#6.wav", "]", "[", 11, "VI_stac_p_G#6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082486784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086428160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_F#6.wav", "]", "[", 11, "VI_stac_p_F#6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082843136, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086466560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-A6-ff-2c.aif", "]", "[", 11, "Vn-pont-A6-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083241472, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086453760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-G#6-ff-1c.aif", "]", "[", 11, "Vn-ord-G#6-ff-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083325440, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081122816, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086070784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-C5-ff-4c.aif", "]", "[", 11, "Vn-ord-C5-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083901952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086428160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-F#6-ff-2c.aif", "]", "[", 11, "Vn-pont-F#6-ff-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085328384, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085993984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A4-ff-3c.aif", "]", "[", 11, "Vn-ord-A4-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085349376, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086376960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079263232, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-D6-pp-1c.aif", "]", "[", 11, "Vn-ord-D6-pp-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_C7.wav", "]", "[", 11, "VI_stac_mp_C7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085396736, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086492160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_B6.wav", "]", "[", 11, "VI_stac_mp_B6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085686784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081372672, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_f_A3.wav", "]", "[", 11, "VI_stac_f_A3.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085462272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086376960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_D6.wav", "]", "[", 11, "VI_stac_mp_D6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085540864, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086249984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 7, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-G5-mf-2c.aif", "]", "[", 11, "Vn-pont-G5-mf-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mf", "=", "]", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086325760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 7, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/sul-ponticello/Vn-pont-A#5-mf-2c.aif", "]", "[", 11, "Vn-pont-A#5-mf-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085658880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085679616, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078558720, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-F4-pp-3c.aif", "]", "[", 11, "Vn-ord-F4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085968384, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-G#4-ff-4c.aif", "]", "[", 11, "Vn-ord-G#4-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085818624, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-F4-pp-3c.aif", "]", "[", 11, "Vn-ord-F4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086070784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-C5-ff-3c.aif", "]", "[", 11, "Vn-ord-C5-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085913088, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086364160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-C#6-ff-1c.aif", "]", "[", 11, "Vn-ord-C#6-ff-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085934080, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A5-pp-2c.aif", "]", "[", 11, "Vn-ord-A5-pp-2c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086466560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_A6.wav", "]", "[", 11, "VI_stac_p_A6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086543360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_D#7.wav", "]", "[", 11, "VI_stac_p_D#7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086059776, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079263232, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_G7.wav", "]", "[", 11, "VI_stac_p_G7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085737984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 7, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mf_B3.wav", "]", "[", 11, "VI_stac_mf_B3.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mf", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086112256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086453760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_G#6.wav", "]", "[", 11, "VI_stac_mp_G#6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086504960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 7, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-C7-mf-1c.aif", "]", "[", 11, "Vn-ord-C7-mf-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mf", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086440960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_f_G6.wav", "]", "[", 11, "VI_stac_f_G6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086173184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_E5.wav", "]", "[", 11, "VI_stac_p_E5.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086279936, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085635584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081290752, 12, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_f_G3.wav", "]", "[", 11, "VI_stac_f_G3.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "f", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086620160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_A7.wav", "]", "[", 11, "VI_stac_p_A7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086365312, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086325760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_A#5.wav", "]", "[", 11, "VI_stac_mp_A#5.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086375808, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086301184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_A5.wav", "]", "[", 11, "VI_stac_mp_A5.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0 ],
					"whole_roll_data_0000000002" : [ "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086492160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_B6.wav", "]", "[", 11, "VI_stac_p_B6.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086543360, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_D#7.wav", "]", "[", 11, "VI_stac_p_D#7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086463616, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085865984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-E4-ff-3c.aif", "]", "[", 11, "Vn-ord-E4-ff-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086474112, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085891584, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078558720, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-F4-pp-3c.aif", "]", "[", 11, "Vn-ord-F4-pp-3c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "pp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086487168, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085993984, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082003456, 40, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-A4-ff-4c.aif", "]", "[", 11, "Vn-ord-A4-ff-4c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "ff", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086500352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086376960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/ord/Vn-ord-D6-pp-1c.aif", "]", "[", 11, "Vn-ord-D6-pp-1c.aif", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086590720, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086517760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080991744, 2, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_mp_C#7.wav", "]", "[", 11, "VI_stac_mp_C#7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "mp", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086601216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086594560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 2, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_G7.wav", "]", "[", 11, "VI_stac_p_G7.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086325760, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 1, "[", "slots", "[", 1, "arco", "]", "[", 2, "sus", "]", "[", 3, 1, "]", "[", 10, "/Users/ben/Documents/sfdb/violin/staccato/VI_stac_p_A#5.wav", "]", "[", 11, "VI_stac_p_A#5.wav", "]", "[", 12, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 14, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 15, 1, "]", "[", 16, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 17, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 20, "[", "auto", "p", "=", "]", "]", "]", 0, "]", 0, "]", 0, "]" ],
					"whole_roll_data_count" : [ 3 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 408.0, 79.0, 161.0, 22.0 ],
					"text" : "loadmess symbol annotation"
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
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-16",
									"linecount" : 3,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 135.0, 40.0, 593.0, 60.0 ],
									"text" : "INSTRUMENTS_BACH_SLOTS_DICT = {1: 'technique', 2: 'temporal_mode', 3: 'selectnumber', 10: 'fullpath', 11: 'filename', 12: 'sfskiptime', 13: 'db_scale', 14: 'sftransposition', 15: 'sfchannels', 20: 'dynamic', 22: 'articulation', 23: 'notehead', 24: 'annotation'}\n"
								}

							}
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
, 							{
								"box" : 								{
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
									"text" : "11"
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
									"text" : "10"
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
									"text" : "12"
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
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-10", 0 ]
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
									"destination" : [ "obj-10", 0 ],
									"source" : [ "obj-12", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-12", 12 ]
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
									"source" : [ "obj-12", 5 ]
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
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-12", 11 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"source" : [ "obj-12", 10 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-12", 9 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"source" : [ "obj-12", 8 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"source" : [ "obj-12", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-13", 0 ]
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
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-9", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 408.0, 144.0, 161.0, 22.0 ],
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
					"id" : "obj-19",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 408.0, 174.0, 128.0, 22.0 ],
					"presentation" : 1,
					"presentation_linecount" : 7,
					"presentation_rect" : [ 1346.0, 552.0, 29.5, 102.0 ],
					"text" : "linkannotationtoslot $1"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 20.0,
					"id" : "obj-2",
					"items" : [ "technique", ",", "temporal_mode", ",", "selectnumber", ",", "fullpath", ",", "filename", ",", "sfskiptime", ",", "db_scale", ",", "sftransposition", ",", "sfchannels", ",", "dynamic", ",", "articulation", ",", "notehead", ",", "annotation" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 408.0, 107.0, 163.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 162.0, 50.0, 193.0, 60.0 ],
					"text" : "<- this file is created by audioguide if you use INSTRUMENTS. by default it is put into the output/ directory."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 18.0,
					"id" : "obj-44",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 408.0, 41.0, 253.0, 27.0 ],
					"text" : "Changing What is Displayed"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-42",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 513.5, 213.0, 114.0, 47.0 ],
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
					"patching_rect" : [ 407.0, 221.0, 100.0, 22.0 ],
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
					"patching_rect" : [ 60.0, 50.0, 94.0, 22.0 ],
					"text" : "read bachroll.txt"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 1 ],
					"order" : 0,
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"order" : 1,
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 1 ],
					"order" : 0,
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"order" : 1,
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 0 ],
					"source" : [ "obj-3", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 7 ],
					"source" : [ "obj-49", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 6 ],
					"source" : [ "obj-49", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 5 ],
					"source" : [ "obj-49", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 4 ],
					"source" : [ "obj-49", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 3 ],
					"source" : [ "obj-49", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 2 ],
					"source" : [ "obj-49", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 1 ],
					"source" : [ "obj-49", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-49", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "playsound.maxpat",
				"bootpath" : "~/Documents/audioguide/maxmsp/musicalwriting",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "bach.roll.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "bach.playkeys.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
