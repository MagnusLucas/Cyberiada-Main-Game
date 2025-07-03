extends Node

const CHARACTER_NODE_POSITION = "/root/world/character"
var act : int = 0
var game_data : Dictionary = {}
var save_slot : int = 1
@onready var path : String = ('save_file_' + str(Globals.save_slot) + '.plik')
