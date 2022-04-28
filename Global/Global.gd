extends Node

var xp_enemy = 0
# warning-ignore:unused_signal
signal xp
# warning-ignore:unused_signal
signal defense_changed

#------------------------------------Global Variables--------------------------------------
var name_player = null
export var health_global = 3
var damage = 1
var shot_speed = 0.4
var defense = 0
export (int) var speed = 600
var score= 0
var xp = 0
var level = 0

#-----------------------------------UPGRADES VARIABLES--------------------------------------
var level_shot_speed = 0
var level_damage = 0
var level_speed = 0
var num

#-----------------------------------------DATA--------------------------------------
var path = "user://data.json" 
var data = {
	"Name": name_player,
	"Score": score,
	"HealthGlobal": health_global,
	"Damage": damage,
	"ShotSpeed": shot_speed,
	"Defense": defense,
	"Speed": speed,
	"Xp": xp,
	"Level": level,
	"LevelShotSpeed": level_shot_speed,
	"LevelDamage": level_damage,
	"LevelSpeed": level_speed,
}

#--------------------------------------SAVE SYSTEM--------------------------------------
#save game
func save_game():
	#print(data)
	var _file = File.new()
	
	var _error = _file.open(path, File.WRITE)
	if not _error:
		_file.store_var(data)
	_file.close()
#load game
func load_game():
	var _file = File.new()
	var _error = _file.open(path, File.READ)
	
	if not _error:
		data = _file.get_var()
	if name_player != null:
		name_player = data.Name
	score = data.Score
	health_global = data.HealthGlobal
	damage = data.Damage
	shot_speed = data.ShotSpeed
	defense = data.Defense
	speed = data.Speed
	xp = data.Xp
	level = data.Level
	level_shot_speed = data.LevelShotSpeed
	level_damage = data.LevelDamage
	level_speed = data.LevelSpeed
	#print(data)
	_file.close()
func reload():
	Global.save_game()
	Global.load_game()

#-------------------------------------Name System--------------------------------------
func set_player_name(nameP):
	data.Name = nameP


#-----------------------------------Physics Process--------------------------------------
func _physics_process(_delta):
	Global.save_game()
	Global.load_game()




#-------------------------------------RESET--------------------------------------
func reset():
	Global.data.Score = 0
	Global.data.HealthGlobal = 3
	Global.data.Damage = 1
	Global.data.ShotSpeed = 0.4
	Global.data.Defense = 0
	Global.data.Speed = 350
	Global.data.Score= 0
	Global.data.Xp = 0
	Global.data.Level = 0
	Global.data.LevelShotSpeed = 0
	Global.data.LevelDamage = 0
	Global.data.LevelSpeed = 0
	Global.save_game()
	Global.load_game()
