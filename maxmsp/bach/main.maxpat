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
		"rect" : [ 407.0, 79.0, 1011.0, 1007.0 ],
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
									"linecount" : 8,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 160.0, 172.0, 50.0, 22.0 ],
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
					"id" : "obj-19",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 632.3333740234375, 764.0, 258.0, 22.0 ],
					"text" : "[ 0. 0. 0. ] [ 0.0337 1. 0. ] [ 0.7 1. 0. ] [ 1. 0. 0. ]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 443.0, 764.0, 150.0, 20.0 ],
					"text" : "route by sf channel count"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 389.5, 764.0, 46.0, 22.0 ],
					"text" : "route 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 389.5, 804.0, 79.0, 22.0 ],
					"text" : "prepend note"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-31",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 477.0, 804.0, 304.0, 20.0 ],
					"text" : "duration cents voice fullpath skip_ms trans env"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "newobj",
					"numinlets" : 7,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 389.5, 726.0, 432.0, 22.0 ],
					"text" : "pack i f f i s f f"
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
					"id" : "obj-26",
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
					"patching_rect" : [ 140.0, 360.5, 607.0, 303.0 ],
					"pitcheditrange" : [ "null" ],
					"stafflines" : [ 5, 5, 5 ],
					"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"versionnumber" : 80100,
					"voicenames" : [ "target", "cps_vc1", "cps_vc0" ],
					"voicespacing" : [ 0.0, 17.0, 17.0, 17.0 ],
					"whole_roll_data_0000000000" : [ "roll", "[", "slotinfo", "[", 1, "[", "name", "fullpath", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 2, "[", "name", "sfskiptime", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 3, "[", "name", "sfchannels", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080016896, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 4, "[", "name", "env", "]", "[", "type", "function", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "grid", "]", "[", "ysnap", "]", "[", "domain", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "domainslope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "duration", "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 5, "[", "name", "slot int", "]", "[", "type", "int", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080016896, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1078984704, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 6, "[", "name", "slot float", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 7, "[", "name", "slot text", "]", "[", "type", "text", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 8, "[", "name", "slot filelist", "]", "[", "type", "filelist", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080213504, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 9, "[", "name", "slot spat", "]", "[", "type", "spat", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1076101120, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "temporalmode", "relative", "]", "[", "extend", 0, "]", "[", "width", "auto", "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 10, "[", "name", "sftransposition", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 11, "[", "name", "listofdescriptors", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 12, "[", "name", "noisiness", "]", "[", "type", "floatlist", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 13, "[", "name", "power-seg", "]", "[", "type", "float", "]", "[", "key", 0, "]", "[", "range", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", "slope", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "representation", "]", "[", "default", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 14, "[", "name", "slot 14", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 15, "[", "name", "slot 15", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 16, "[", "name", "slot 16", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 17, "[", "name", "slot 17", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 18, "[", "name", "slot 18", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 19, "[", "name", "slot 19", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 20, "[", "name", "dynamics", "]", "[", "type", "dynamics", "]", "[", "key", "d", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 21, "[", "name", "lyrics", "]", "[", "type", "text", "]", "[", "key", "l", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 0, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 22, "[", "name", "articulations", "]", "[", "type", "articulations", "]", "[", "key", "a", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 23, "[", "name", "notehead", "]", "[", "type", "notehead", "]", "[", "key", "h", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079738368, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 24, "[", "name", "annotation", "]", "[", "type", "text", "]", "[", "key", "t", "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 25, "[", "name", "slot 25", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 26, "[", "name", "slot 26", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 27, "[", "name", "slot 27", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 28, "[", "name", "slot 28", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 29, "[", "name", "slot 29", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "[", 30, "[", "name", "slot 30", "]", "[", "type", "none", "]", "[", "key", 0, "]", "[", "temporalmode", "none", "]", "[", "extend", 0, "]", "[", "width", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079574528, "]", "[", "height", "auto", "]", "[", "copywhensplit", 1, "]", "[", "access", "readandwrite", "]", "[", "follownotehead", 0, "]", "]", "]", "[", "commands", "[", 1, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 2, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 3, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 4, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "[", 5, "[", "note", "note", "]", "[", "chord", "chord", "]", "[", "rest", "rest", "]", "[", "key", 0, "]", "]", "]", "[", "groups", "]", "[", "markers", "]", "[", "midichannels", 1, 2, 3, "]", "[", "articulationinfo", "]", "[", "noteheadinfo", "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085781248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1157123321, 1068624583, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082464256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085652224, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081749504, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 902582527, 1067452140, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083261952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085647104, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 835247478, 1068018799, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085606912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082507264, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4218055101, 1068114667, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085338880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085605120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3695037559, 1067785551, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085612800, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4227848486, 1067269872, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085443840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085679616, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081413632, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 689417037, 1068241217, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085629440, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081581568, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1200033994, 1068381406, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085576960, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3996495280, 1062401601, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085683968, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1154262430, 1067899499, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085660160, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 901076894, 1068075729, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085559296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1901520912, 1066619626, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085595392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081331712, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3874039789, 1067842311, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085350912, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085657344, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082085376, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4029824963, 1068872379, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085634560, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 670062026, 1061745132, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085632256, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081540608, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2541547091, 1068675414, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085637120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4215237665, 1067346884, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085611008, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082359808, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 110919438, 1066806958, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086592000, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085650432, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1945117137, 1066944879, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085451264, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082296320, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/cage.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2945042254, 1065820729, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081081856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085377280, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1067279240, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 383466530, 1065862643, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081204736, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4171072354, 1065423991, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 914381675, 1065198090, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086084352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 512652231, 1065874341, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3243695279, 1066083252, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082464256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085944320, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081835520, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 913969041, 1066876587, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1707700809, 1066426665, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086368640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081122816, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2762522965, 1067663438, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3100945668, 1067692696, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082486784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086213120, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1539316279, 1067532576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1730858737, 1066476431, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081794560, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2281486628, 1066916852, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2980176063, 1066562772, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082570752, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086358784, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081245696, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1539316279, 1067532576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2951126902, 1067398614, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083251712, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 792363520, 1065328262, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083261952, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_" ],
					"whole_roll_data_0000000001" : [ 331016115, 1065882754, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085977088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1844421068, 1066105022, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083273216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4171072354, 1065423991, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086258432, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081290752, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2075328197, 1067495666, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3187427502, 1067828450, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083629568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085914112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2903986736, 1067626970, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 968456697, 1066556213, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083639808, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1613693509, 1065577371, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1083650048, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 981431364, 1066642542, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086137088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 893504995, 1068166100, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085341696, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085977088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1844421068, 1066105022, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085344256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085939456, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1642395494, 1068816033, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3751675552, 1066850493, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086073088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3353510465, 1068940184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 305700487, 1065489239, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085375744, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085377280, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081458688, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1067279240, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 383466530, 1065862643, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1067030937, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3468036153, 1066463177, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086137088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 893504995, 1068166100, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085391360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1203009120, 1070471421, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085409792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2103797570, 1067450828, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085441280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086060032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082044416, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4033833284, 1066715525, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1565538346, 1067376238, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085443840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086375808, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2906833866, 1068621417, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1852020734, 1068767804, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085448960, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 880928847, 1065603772, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3383911403, 1067861101, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085454336, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 968456697, 1066556213, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085551360, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085371392, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1758598061, 1065835767, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086120704, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081163776, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1882913663, 1067616462, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 981431364, 1066642542, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085553920, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 792363520, 1065328262, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1613693509, 1065577371, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086336128, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 596830532, 1066574960, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085797632, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1067030937, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3468036153, 1066463177, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085800448, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085394176, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1067077913, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1587674638, 1067407740, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085805568, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085401856, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 219936068, 1068144966, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085813504, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086258432, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081290752, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2075328197, 1067495666, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3187427502, 1067828450, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085837056, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086378496, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1642395494, 1068816033, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2805710665, 1066523692, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085871104, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085926400, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080655872, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1209462791, 1068039248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2605333500, 1069933053, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085915648, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263296, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081794560, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2281486628, 1066916852, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2980176063, 1066562772, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085918208, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085966848, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1311699812, 1066681884, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085921024, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 792363520, 1065328262, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2103797570, 1067450828, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085976064, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 914381675, 1065198090, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085890048, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081667584, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2576980378, 1067030937, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3468036153, 1066463177, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1613693509, 1065577371, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085978624, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983488, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080156160, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2906833866, 1068621417, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 789272366, 1065392620, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086103552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3383911403, 1067861101, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086038784, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2824370494, 1068223797, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1371057389, 1064504710, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085884416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_" ],
					"whole_roll_data_0000000002" : [ 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 525056518, 1066125950, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086046720, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085977088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1844421068, 1066105022, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086049280, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 792363520, 1065328262, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085594368, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4174754004, 1065941187, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086091264, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085966848, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1311699812, 1066681884, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 880928847, 1065603772, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086084352, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 512652231, 1065874341, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086093824, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1224249916, 1066266546, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086096640, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086189824, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 18052756, 1066533659, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086177792, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086335872, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3353510465, 1068940184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 863892037, 1066912158, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086203904, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086365440, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2415380628, 1067935303, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086230272, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 331016115, 1065882754, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086286336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 968456697, 1066556213, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086232832, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 914381675, 1065198090, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3243695279, 1066083252, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086235392, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085358592, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 792363520, 1065328262, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086343040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085607168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079607296, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 13743895, 1069089502, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4186067262, 1065911828, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086073088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079771136, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3353510465, 1068940184, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 305700487, 1065489239, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086263552, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080074240, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3958241860, 1068710336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2234690458, 1066646726, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086367872, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085368576, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3461809759, 1065721804, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 914381675, 1065198090, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983232, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1281197497, 1065726481, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086371840, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4171072354, 1065423991, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086251520, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3243695279, 1066083252, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086420352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085774336, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1224249916, 1066266546, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086423040, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085594368, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4174754004, 1065941187, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085884416, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 525056518, 1066125950, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086042112, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080238080, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3271047093, 1068542564, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 880928847, 1065603772, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086488576, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085394176, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1081626624, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1067077913, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1587674638, 1067407740, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2103797570, 1067450828, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086489856, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086316032, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1203009120, 1070471421, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086500352, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086018304, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082591232, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 432932703, 1066130001, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 284422508, 1065894909, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086071808, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1082150912, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1298798110, 1066634995, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1633778768, 1068399633, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086592000, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085515776, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4171072354, 1065423991, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085842688, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 914381675, 1065198090, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086595968, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086068480, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080573952, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 3456589680, 1068126489, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 2103797570, 1067450828, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086599936, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085927168, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080909824, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1546188227, 1067827855, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1613693509, 1065577371, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086601216, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085594368, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 4174754004, 1065941187, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086623488, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085232640, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080745984, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 377957122, 1067962073, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 331016115, 1065882754, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085983232, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1281197497, 1065726481, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086208512, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080410112, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1704243023, 1068327816, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 197501353, 1066091778, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086627456, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085406208, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2824370494, 1068223797, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1371057389, 1064504710, "]", "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085977088, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080320000, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/lachenmann.aiff", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1511828488, 1068448612, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1844421068, 1066105022, "]", "]", 0, "]", 0, "]", 0, "]", "[", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085338880, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1084987904, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079443456, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 4020089389, 1069270695, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918 ],
					"whole_roll_data_0000000003" : [ 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1447531176, 1065778153, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085344256, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085726976, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1079934976, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1642395494, 1068816033, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 3498180689, 1067488182, "]", "]", 0, "]", 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1086419072, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1085676544, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1080492032, 127, "[", "slots", "[", 1, "/Users/ben/Documents/audioguide/examples/heat", "]", "[", 2, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "]", "[", 3, 1, "]", "[", 4, "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 2824370494, 1068223797, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 1717986918, 1072064102, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", "_x_x_x_x_bach_float64_x_x_x_x_", 0, 1072693248, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "]", "[", 10, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 11, "_x_x_x_x_bach_float64_x_x_x_x_", 0, 0, "]", "[", 13, "_x_x_x_x_bach_float64_x_x_x_x_", 1574871522, 1068581697, "]", "]", 0, "]", 0, "]", 0, "]" ],
					"whole_roll_data_count" : [ 4 ]
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
					"fontname" : "Arial",
					"fontsize" : 13.0,
					"id" : "obj-5",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 8,
					"outlettype" : [ "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 389.5, 684.0, 500.833343505859375, 23.0 ],
					"saved_object_attributes" : 					{
						"versionnumber" : 80100
					}
,
					"text" : "bach.playkeys [slot 3] duration cents voicenumber [slot 1 2 10 4] @out m"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"linecount" : 7,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 757.0, 128.0, 543.0, 114.0 ],
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
					"patching_rect" : [ 129.0, 773.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 389.5, 834.0, 112.0, 22.0 ],
					"text" : "poly~ playsound 20"
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
					"patching_rect" : [ 166.0, 221.0, 31.0, 22.0 ],
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
					"destination" : [ "obj-26", 0 ],
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
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"source" : [ "obj-26", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
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
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 1 ],
					"source" : [ "obj-5", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 6 ],
					"source" : [ "obj-5", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 5 ],
					"source" : [ "obj-5", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 4 ],
					"source" : [ "obj-5", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 3 ],
					"source" : [ "obj-5", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 2 ],
					"source" : [ "obj-5", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 1 ],
					"source" : [ "obj-5", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 0 ],
					"source" : [ "obj-5", 0 ]
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
				"name" : "playsound.maxpat",
				"bootpath" : "~/Documents/audioguide/maxmsp/bach",
				"patcherrelativepath" : ".",
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
				"name" : "bach.roll.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
