GDPC                �                                                                      *   P   res://.godot/exported/133200997/export-134b5bc730c825a647ffd81bf58fa0a2-seed.scn@F      )      �r/���֠]��9    \   res://.godot/exported/133200997/export-176b3652f885f810abceb657bf9c86ae-player_health_ui.scn�0      �      XL����V�ء��5�j�    T   res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn �U      ,      E*9������$���0    T   res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn         d      p�:;a��Ѷx����k    T   res://.godot/exported/133200997/export-94ac7a95b932d7103c68a5776a7128f3-enemy.scn   @      |      %��O؛d6�z>v9l    T   res://.godot/exported/133200997/export-bc3b4a5402c2d367850c1b7aab3bd030-Charger.scn �      �      "`�D4�1Gһ �-�    X   res://.godot/exported/133200997/export-c43e392915a6619ac46a946642c83ca9-seed_shooter.scnpJ            @����FWb�P'����    X   res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn   �Z      �      vqŴ�&*��<����    T   res://.godot/exported/133200997/export-f8b957969db01dd0b3d81f4e4ece5ef6-lasso.scn    ;      L	      ����Yc_WN2IT��A    ,   res://.godot/global_script_class_cache.cfg  ��             ��Р�8���8~$}P�    X   res://.godot/imported/Basic Charakter Actions.png-0a72d1f4561d9ac29332b94b1ac7d66c.ctex p]      �      9wY�Z`΄}��EQ�    \   res://.godot/imported/Basic Charakter Spritesheet.png-a6c5fbedfdb2988fe044bfdcde38b569.ctex 0j      ,      ȭ��x��m���|    L   res://.godot/imported/Egg_And_Nest.png-e90aec337b65910de43c9ef09a9c865c.ctex@o      f      5�� q��V��]�����    T   res://.godot/imported/Free Chicken Sprites.png-07e84994a07a94afbe3b2ffa4b603772.ctex�q      �      ��2]c���G'�Q�;Zr    P   res://.godot/imported/Free Cow Sprites.png-2672a408f416f26b15622784cb90a57e.ctex t      �      �������Rx[����    H   res://.godot/imported/Tools.png-277f03943986df300b32fdd5968fec42.ctex   �w      �      q��;E�O�A�Y�t    D   res://.godot/imported/icon.svg-13cb4c3794b53af6ed75e5428c303866.ctex@~      �      �Yz=������������       res://.godot/uid_cache.bin   �      m      ��<C�+���7����    H   res://Temporary Sprites/Characters/Basic Charakter Actions.png.import   Pi      �       ����$m:��%֩�    L   res://Temporary Sprites/Characters/Basic Charakter Spritesheet.png.import   `n      �       KbI��V�D�1NR���    <   res://Temporary Sprites/Characters/Egg_And_Nest.png.import  �p      �       �ؕ
MPjw�a�O��    D   res://Temporary Sprites/Characters/Free Chicken Sprites.png.import  @s      �       �hP~��U5��
�^    @   res://Temporary Sprites/Characters/Free Cow Sprites.png.import  �v      �       {y��N��Wy9n߻    4   res://Temporary Sprites/Characters/Tools.png.import p}      �       F��L�p0
�3�(    (   res://Temporary Sprites/icon.svg.import  �      �       N2\����f$*ǡ    $   res://entities/charger/Charger.gd           �      u����,5n+Nj�EN�    ,   res://entities/charger/Charger.tscn.remap   ��      d       �HǕSl��:���PhX1        res://entities/enemy/enemy.gd   �
      h      
�f}w9�@�!��mP�    (   res://entities/enemy/enemy.tscn.remap   `�      b       �T���Agt#C���O    $   res://entities/knight/Camera2D.gd   �            �"���%��A����FZ�        res://entities/knight/knight.gd �            ���c�p��{�4y6    (   res://entities/knight/knight.tscn.remap Ќ      c       	%�]�K�wıË�L�    ,   res://entities/knight/player_health_ui.gd   p/            A(� �`�;��#    4   res://entities/knight/player_health_ui.tscn.remap   @�      m       ;�d������(A�        res://entities/lasso/lasso.gd   p4      �      Q��67���9��ז�    (   res://entities/lasso/lasso.tscn.remap   ��      b       }�3!Fu��4HP3    (   res://entities/seed_shooter/seed/seed.gdPD      �      �\�n��E_��a��    0   res://entities/seed_shooter/seed/seed.tscn.remap �      a       �M�4q� trY�u�    4   res://entities/seed_shooter/seed_shooter.tscn.remap ��      i       3|E���f�d/h��        res://levels/level_0.tscn.remap  �      d       �]LG˻�<�5��7�    $   res://levels/main_menu.tscn.remap   p�      f       ���p��!c����#v�       res://project.binaryp�      �      ��+��uL?�m=����        extends CharacterBody2D
@export var walk_speed = 100
@export var run_speed = 200
@export var damage : int = 1

@onready var player = get_parent().get_node("Knight")
@onready var timer = $Timer

var predict_length=walk_speed/10
var player_predicted_position
var alarmed = false
var current_speed = 50
var make_charge = true
var direction = Vector2(0, 0)
var desired_velocity
var steering_force = 20
var steering = Vector2(0,0)

func _ready():
	timer.timeout.connect(_timeout)

func _physics_process(delta):
	
	if(alarmed):
		if(timer.is_stopped()):
			current_speed = walk_speed
			timer.start(7)
		
		
		if is_instance_valid(player):
			#position = position.lerp(player.position, speed * delta)
			if(current_speed==walk_speed):
				predict_length = global_position.distance_to(player.global_position)/10
				player_predicted_position = player.position + player.velocity*delta*predict_length
				var desired_velocity = (player_predicted_position - position).normalized()*walk_speed
				var steering = (desired_velocity - velocity).normalized()*steering_force
				velocity = velocity + steering
			if(current_speed==run_speed):
				velocity = direction*run_speed
				
				
		
		move_and_collide(velocity * delta)
	
func _timeout():
	if(make_charge):
		current_speed = run_speed
		make_charge = false
		timer.start(2)	
		direction = velocity.normalized()
	else:
		make_charge = true
	
func _on_alarmed():
	var direction = (player.position - position).normalized()
	velocity = direction*walk_speed
	alarmed = true
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script "   res://entities/charger/Charger.gd ��������
   Texture2D 8   res://Temporary Sprites/Characters/Free Cow Sprites.png �5�h�p      local://RectangleShape2D_v1x8v �         local://PackedScene_rer1n �         RectangleShape2D             PackedScene          	         names "         Charger    scale    collision_layer    collision_mask    script    CharacterBody2D 	   Sprite2D 	   position    texture    hframes    vframes    CollisionShape2D    shape    Timer 	   one_shot    	   variants    	   
      @   @                      
         ��                                     node_count             nodes     0   ��������       ����                                              ����               	      
                        ����                           ����                   conn_count              conns               node_paths              editable_instances              version             RSRC          extends CharacterBody2D

#much of movement in charger and other enemies is same as here, but with ability code added on.


@export var speed = 100
@export var damage : int = 1
@export var steering_force = 20 #used to make turning more smooth and flowing
@onready var player = get_parent().get_node("Knight")

var predict_length = 5 #enemy predicts where player will be this length of frames ahead (5 is temporary number
var alarmed = false #enemy has state of rest
var player_predicted_position #position calculated through predict length

func _physics_process(delta):
	if is_instance_valid(player) and alarmed:
		predict_length = global_position.distance_to(player.global_position)/10
		player_predicted_position = player.position + player.velocity*delta*predict_length
		var desired_velocity = (player_predicted_position - position).normalized()*speed
		var steering = (desired_velocity - velocity).normalized()*steering_force
		velocity = velocity + steering
		
		move_and_collide(velocity * delta)
	
func _on_alarmed():
	var direction = (player.position - position).normalized()
	velocity = direction*speed
	alarmed = true
        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script    radius 	   _bundled       Script    res://entities/enemy/enemy.gd ��������
   Texture2D !   res://Temporary Sprites/icon.svg �rO3t��b      local://RectangleShape2D_sdnq0 �         local://CircleShape2D_sysfw �         local://PackedScene_7w1op          RectangleShape2D       
      B   B         CircleShape2D             PackedScene          	         names "         Enemy 	   modulate    collision_layer    collision_mask    script    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    avoid_enemies    Area2D    _on_avoid_enemies_body_entered    body_entered    	   variants    	        �?          �?                      
     �>  �>                   
     �@  �@               node_count             nodes     5   ��������       ����                                              ����                           	   	   ����   
                        ����               	   	   ����         
                conn_count             conns                                      node_paths              editable_instances              version             RSRC    extends Camera2D

# Radius of the zone in the middle of the screen where the cam doesn't move
const DEAD_ZONE = 80

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: # If the mouse moved...
		var _target = event.position - get_viewport().get_visible_rect().size * 0.5	# Get the mouse position relative to the middle of the screen
		if _target.length() < DEAD_ZONE:	# If we're in the middle (dead zone)...
			self.position = Vector2(0,0)	# ... reset the camera to the middle (= center on player)
		else:
			# _target.normalized() is the direction in which to move
			# _target.length() - DEAD_ZONE is the distance the mouse is outside of the dead zone
			# 0.5 is an arbitrary scalar
			self.position = _target.normalized() * (_target.length() - DEAD_ZONE) * 0.5
            extends CharacterBody2D

signal hp_changed(old_value: int, new_value: int)
signal alarmed()
@export var hp : int = 3 :
	get:
		return hp
	set(new_hp):
		if new_hp <= 0:
			die()
		hp_changed.emit(hp, new_hp)
		hp = new_hp

@export var move_speed : float = 150.0
@export var lasso_speed : float = 2.0


@onready var sense_range = $SenseRange
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var lasso = $Lasso

func die():
	queue_free()

func _ready():
	hp = hp

func _physics_process(_delta):
	# Movement
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	# Lasso
	if Input.is_action_just_pressed("whip"):
		lasso.whip(get_global_mouse_position())
	
	velocity = input_direction * move_speed
	
	move_and_slide()

func _on_hit_box_body_entered(body):
	if body.is_in_group("enemies") and not body.is_in_group("captured"):
		hp -= body.damage

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies") and body.is_in_group("captured"):
		# Delete rope and enemy attached
		lasso.captured_enemies[body].queue_free()
		body.queue_free()
		# Remove enemy and rope entries from captured_enemy dictionary
		lasso.captured_enemies.erase(body)
		

func _on_sense_range_body_entered(body):
	if body.is_in_group("enemies") and not body.is_in_group("captured"):
		sense_range.body_entered.connect(body._on_alarmed)
	sense_range.emit_signal("body_entered")

       RSRC                    PackedScene            ��������                                            *      ..    AnimationPlayer    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    _data    auto_triangles 
   min_space 
   max_space    snap    x_label    y_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/Idle/node    states/Idle/position    states/Start/node    states/Start/position    states/Walk/node    states/Walk/position    transitions    graph_offset    radius 	   _bundled       Script     res://entities/knight/knight.gd ��������
   Texture2D !   res://Temporary Sprites/icon.svg �rO3t��b   Script "   res://entities/knight/Camera2D.gd ��������   PackedScene     res://entities/lasso/lasso.tscn f�s�@��   PackedScene ,   res://entities/knight/player_health_ui.tscn �y���      local://RectangleShape2D_vcw2b �         local://Animation_8qprx �         local://AnimationLibrary_a50b0 �      (   local://AnimationNodeBlendSpace2D_va5ow A      (   local://AnimationNodeBlendSpace2D_8tqgi �      2   local://AnimationNodeStateMachineTransition_qojdq �      2   local://AnimationNodeStateMachineTransition_1x020 �      (   local://AnimationNodeStateMachine_yrndm 5         local://CircleShape2D_mtcxo (	         local://RectangleShape2D_nid7g R	         local://RectangleShape2D_an74c �	         local://PackedScene_oqjgi �	         RectangleShape2D       
      B   B      
   Animation             idle_up          AnimationLibrary    
               idle_up                   AnimationNodeBlendSpace2D       
     ���̌�   
     �?�̌?                  AnimationNodeBlendSpace2D          $   AnimationNodeStateMachineTransition          $   AnimationNodeStateMachineTransition                       AnimationNodeStateMachine 
                      !   
    ��C  �B"      #   
     /C  �B$            %   
     �C  �B&               Start       Idle                Idle       Walk          '   
     ��  ��         CircleShape2D    (        �B         RectangleShape2D       
      B   B         RectangleShape2D       
     B  B         PackedScene    )      	         names "   $      Knight    collision_layer    script    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    AnimationPlayer 
   libraries    AnimationTree 
   tree_root    anim_player    parameters/Idle/blend_position    parameters/Walk/blend_position 	   Camera2D    process_callback    position_smoothing_enabled    SenseRange    collision_mask    Area2D    one_way_collision_margin    HitBox    debug_color    HurtBox    Lasso    HUD    CanvasLayer    PlayerHealthUI    offset 
   transform    _on_sense_range_body_entered    body_entered    _on_hit_box_body_entered    _on_hurtbox_body_entered    	   variants                       
     �>  �>                                                               
   `��7M��
                                                             	      ���>��?���>���>      
        �?        ���>                  
      A   A   ���=        ���=   A   A      node_count             nodes     �   ��������       ����                                  ����                                 ����                     	   	   ����   
                        ����   
                           	                     ����      
                                 ����                                 ����                                 ����                                 ����                                 ����      
             
             ����                           ���                            ����               ���                               conn_count             conns               !                         !   "              
       !   #                    node_paths              editable_instances              version             RSRC            extends CanvasLayer

@onready var player = get_parent().get_parent()
@onready var HealthUIFull = $HealthUIFull

func _ready():
	if player:
		player.hp_changed.connect(_on_player_hp_changed)

func _on_player_hp_changed(hp, new_hp):
	if new_hp >= 0:
		HealthUIFull.size.x = new_hp * 128
   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script *   res://entities/knight/player_health_ui.gd ��������
   Texture2D !   res://Temporary Sprites/icon.svg �rO3t��b      local://PackedScene_skdm0 \         PackedScene          	         names "         PlayerHealthUI    scale 
   transform    script    CanvasLayer    HealthUIFull    offset_right    offset_bottom    texture    stretch_mode    TextureRect    	   variants       
   ���=���=   ���=        ���=                        B                     node_count             nodes        ��������       ����                                  
      ����                     	                conn_count              conns               node_paths              editable_instances              version             RSRC          extends Area2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var reel_rate : float = 7.0
@export var lasso_curve : float = 50.0
@export var lasso_width : float = 2.0
@export var lasso_color : Color = Color(0.588, 0.447, 0.349)

# key: value pair
# {body: rope}
var captured_enemies = {}

func _physics_process(delta):
	# Captured enemies in dictionary {body: rope} pair
	for body in captured_enemies:
		var rope = captured_enemies[body]
		rope.points = lasso_to_curve(Vector2.ZERO, to_local(body.position))
		# Slowly increase reeling speed
		if Input.is_action_pressed("reel_in"):
			body.speed += reel_rate

func whip(mouse_pos):
	look_at(mouse_pos)
	animation_player.play("whip")

func lasso_to_curve(p0_vertex: Vector2, p1_vertex: Vector2):
	var curve = Curve2D.new()
	# Adjust curves to change sides
	var p0_out = Vector2.ZERO
	if p0_vertex.x > p1_vertex.x:
		p0_out = Vector2(-lasso_curve, 0)
	else:
		p0_out = Vector2(lasso_curve, 0)
	curve.add_point(p0_vertex, Vector2.ZERO, p0_out);
	curve.add_point(p1_vertex, Vector2.ZERO, Vector2.ZERO);
	return curve.get_baked_points()

func reel_in(body):
	# Instance new rope on knight
	var rope = Line2D.new()
	rope.width = lasso_width
	rope.default_color = lasso_color
	add_child(rope)
	# Add rope point on knight and enemy and connect (relative position to knight)
	rope.points = lasso_to_curve(Vector2.ZERO, to_local(body.position))
	# Save captured enemies in array to continiously update in process function
	captured_enemies[body] = rope

func _on_body_entered(body):
	if body.is_in_group("enemies") and not body.is_in_group("captured"):
		body.add_to_group("captured")
		reel_in(body)
        RSRC                    PackedScene            ��������                                               	   Sprite2D    visible    .    collision_mask    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    _data 	   _bundled       Script    res://entities/lasso/lasso.gd ��������
   Texture2D !   res://Temporary Sprites/icon.svg �rO3t��b      local://RectangleShape2D_uhr6h `         local://Animation_h4bxe �         local://AnimationLibrary_etrjf �         local://PackedScene_ky42k �         RectangleShape2D       
     �B  �A      
   Animation             whip 	         ?         value                                                                    times !             ?      transitions !        �?  �?      values                          update                value                                                                   times !             ?      transitions !        �?  �?      values                          update                AnimationLibrary                   whip                   PackedScene          	         names "         Lasso    collision_layer    collision_mask    script    Area2D 	   Sprite2D    visible 	   position    scale    texture    CollisionShape2D    shape    debug_color    AnimationPlayer 
   libraries    _on_body_entered    body_entered    	   variants    
                           
     �B��5
     8?   >         
     �B                 ��U?���>��*?���>                            node_count             nodes     2   ��������       ����                                         ����                     	                  
   
   ����                                       ����      	             conn_count             conns                                       node_paths              editable_instances              version             RSRC    extends Area2D

@onready var player = get_parent().get_parent().get_node("knight")
@onready var father_shooter = get_parent().get_parent().get_node("SeedShooter")
var speed = 50
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	var direction = (player.position - father_shooter.position).normalized()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction * speed * delta)
          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    height    script 	   _bundled       Script )   res://entities/seed_shooter/seed/seed.gd ��������
   Texture2D 4   res://Temporary Sprites/Characters/Egg_And_Nest.png �W#���W      local://CapsuleShape2D_1h2gs �         local://PackedScene_to4c1 �         CapsuleShape2D            @@         A         PackedScene          	         names "         Area2D    script    CollisionShape2D    shape 	   Sprite2D 	   position    texture    hframes    	   variants                           
          �                     node_count             nodes        ��������        ����                            ����                           ����                               conn_count              conns               node_paths              editable_instances              version             RSRC       RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    script/source    custom_solver_bias    size    script    radius 	   _bundled    
   Texture2D <   res://Temporary Sprites/Characters/Free Chicken Sprites.png �fO�j�8      local://GDScript_2ilfr          local://RectangleShape2D_wxj8i �         local://CircleShape2D_ue5nu �         local://CircleShape2D_oi58g �         local://PackedScene_ce2lj       	   GDScript          �  extends CharacterBody2D
var alarmed = false
@export var speed = 50
@export var damage : int = 1
@export var steering_force = 20
@export var too_close_radius = 5
@export var max_run_radius = 7
@onready var player = get_parent().get_node("Knight")
@onready var too_close = get_node("too_close")
@onready var max_run = get_node("max_run")

func _on_ready():
	too_close.scale.x = too_close_radius

func _physics_process(delta):
	!too_close.has_overlapping_bodies()
	if is_instance_valid(player) and alarmed and !too_close.has_overlapping_bodies():
		var desired_velocity = (player.position - position).normalized()*speed
		var steering = (desired_velocity - velocity).normalized()*steering_force
		velocity = velocity + steering
	else:
		if is_instance_valid(player) and alarmed and too_close.has_overlapping_bodies(): 
			var desired_velocity = -(player.position - position).normalized()*speed
			var steering = (desired_velocity - velocity).normalized()*steering_force
			velocity = velocity + steering
	move_and_collide(velocity * delta)
	
func _on_alarmed():
	var direction = (player.position - position).normalized()
	velocity = direction*speed
	alarmed = true
    RectangleShape2D             CircleShape2D             CircleShape2D             PackedScene          	         names "         SeedShooter    collision_layer    collision_mask    script    CharacterBody2D 	   Sprite2D    texture    hframes    vframes    CollisionShape2D    shape 
   too_close    scale    Area2D    debug_color    max_run    	   variants                                                      
      B   B       
   ���=���=              �?�� <��`=���>
     �B  �B                ��?��3?���>      node_count             nodes     S   ��������       ����                                        ����                                  	   	   ����   
                        ����                                	   	   ����         
   	      
                     ����                    	   	   ����         
                      conn_count              conns               node_paths              editable_instances              version             RSRC              RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene "   res://entities/knight/knight.tscn �}�J��%l   PackedScene $   res://entities/charger/Charger.tscn coKl�   PackedScene     res://entities/enemy/enemy.tscn ����s�	   PackedScene .   res://entities/seed_shooter/seed_shooter.tscn �E2~gp      local://PackedScene_ptnom �         PackedScene          	         names "         Level0    Node2D    Knight 	   position    Charger    enemies    Enemy    Enemy2    Enemy3    Enemy4    SeedShooter    	   variants                 
     �B  �A         
    ��C  �B         
     �C   @
     LB  C
     �A  ��
     6�  �A         
     ,�  �@      node_count             nodes     L   ��������       ����                ���                            ���                             ���                             ���                             ���                             ���	                             ���
   	         
               conn_count              conns               node_paths              editable_instances              version             RSRC    RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_5jpix �          PackedScene          	         names "      	   MainMenu    Node2D    Label    offset_right    offset_bottom    text    	   variants             B     �A      LassoKnight       node_count             nodes        ��������       ����                      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC           GST2   `   @     ����               ` @       �  RIFF�  WEBPVP8L�  /_���&���J	�H�?��m�K�`IV�� �56�q��#V�6u�GF:ұt�/��A�����yS�i@7�w�@�O���(�~��$��� ��@�>�iC�lۮH<�B�"��@��@���w���S�$Ip�dϬ ����?]��[L�m���G[�����2�<C8�DJǤS%�Z�j�=T&$#]te�ž�&��	��ۦD$�DqX7�n7A��nvP�t<.$�� �=�X",78�s��8' � �= �=$W_���q��E��r��s���	>@i{�.֑�$
|L %��y4�K���d4"�;q��:�9$]T)�vs�L�4g4�~���m���\n�M�gȰ����c��gk�Ұ��H��ٳ	���'Qs��l���O��U巘�1��e�O��G��a���'��B�!�nU>�����VF���r Hމ![�p@D���n�
W>�f }�D.$�ƞI2�2�\9眣A�{�z�/��{V�c�P�a+�/����"��܏��s�H�0�7�\�i� 符��9�Q��	�)�h��0P4g44��M�s4��I�>G�h�r�8y>k�d����X2fR��~��i��fM�R�1��Ͷm�^�i��Cs���~�)4f����V�8�wLyD�#�X�EX���nɤo�"<	j�Kn�E�i<ZR(?�F��E��E].�c�&���"H�(��`}���]E��dD}�[Rd��@�Q�@�ú�p0�3�*p�ض-��I`
�ø��,�fR��8jn���$v5����QͿ�3���d���a�*7Y[��=�j�Ǿnۦ6u>�2Ks�x��5G)M,�@,Ur�c� r�U��GT�5��)o7�l��r�eF�t~�=���f"yc1���"	�x�&�k���Џ��=����~b쏰��f�����5�i̚��O��@�d�Y�5 {�4���0��8���8g~2�1��m���ʜ��m,v���0�8��q�a�k̨4��r�$z�Jt1g�/NO�Y=�"� P��2n
��w�Ϻ�� Dn7�O)Ҟ�����!���u}���%RNҞ�$�2{&y�A2(H{H:NN�g�Q��0_?����v��u�Ў䂰gM
������]-��=�D�w@�s�!��8��3AsaHD{./8�aFq ���E|�h✶��h"��9yTl��jޣR�8��t�:��l�� 'J[s^g����55f��v���u��J�e�_m�~�{���ŵ�v��q��T#5a�!�i�Fi�K�c���V' �;U:'D�;U7�f Z�.��9m~��D�s�1Z��ZH��	�	�$ ��xs���"�,ޜ��.�l�"�6�s0���̻+.�2M)$�:���e_K�Q�Y�u/f�t��z�ٶ��4]K�hrm�:%U>gCL�6eԗ-f�q�:k��X�f<Pu��ޢ�pg$v>�i}��C] D � "�X3򤛐�-)�]�X
"Dɻ^iD�DR�iCj�)�SC3wfL����W{��b�3��}]Ǔ�0�;�ra�3�m�9c*�O��G�3B!ۖ�a�L����`FC5�qwY@�n�*}��f4#�jٚ�}����jX�i��1SӴ�k
�%]���#"�9#��m�r͠,G]�];ͅ�̠guא�HCv�wi���[�yij�A�oI4�:gU=SUͪz�ȳri�.��/ ��񬌾��C���"��^�D�"B3MהH�B�!����J;⠠�޽��ge���ĸ�����J;.���6Ɯ�mۺɬ�>1Ќse:N�Hge�����d�V���r�O�F���!m�Ჳ�i�`W���d;8��48@(�Z�u�b��d!�G���o�4��$�Q��]��!���5��H���l��)�4G�M��1��	���+����|�+�����@m^&
��w��<�7A��n��B{&B�ܳ�7�)�ƍ�gӭ����잹��a�y	�C۶��W���;���I��@���§.��h$W��h���;L�����#�����%D�wq��y�gM?Ǥ���L�s�jQ���=7��D��ypIF-�'�C5��bgD����ᔌߣe�T>��\C�a�9JSa���vy�R�Z���4����b�����D $�4̭)j���� y'_� ��/!d�����9�_�b6Y�=g��U+�z ���8��C�8�og���9�0���e��{���P�a�D�F@<f��ޞ�TiA�<���1��0��A!�*�P$s�pM�}�p��8g���%��$�0�/i��<E>�I�@��IS�Eß�I����u�+fY�85��E�c�N�S���)��/��Z^�_ {-���%�6?�� ��ݶ����S����ͩg�};�%�~p~��o�!t�A�pn�GI�˅��"��H�y��D,H�q�P4�����3m].��{.;f3����i����(=^K������H�{�s�o���]�i��}7Qdx̏�m���_�=����'���_Co~Q��!�F�Բ<��!� �E�INӛ���4�%b�`n�vN�}� Y��Y|z�Ws[M��d��\���@C����/h�u�[���Ds��+/=��S;�aP" ��{�����aʹ��� �s΋�1��K���c~�� ������÷���ܜi�)����I����L���ַs����0��K�PeD��tI=�<���ج�r1�ȕ��e̜/�'�|�\x��1��N�{���S��e�i���<?J�-}���'�s0?�ж�c~��O=��ޛ_So��~�R�<��В1�粜�pf���)����9������Ua �'�;&��>Ʈ��NL�;r"�Q
&�D��!_GI��A�!�       [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dr221jawlj3n3"
path="res://.godot/imported/Basic Charakter Actions.png-0a72d1f4561d9ac29332b94b1ac7d66c.ctex"
metadata={
"vram_texture": false
}
             GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /��/O`��3I ��{��<�D0���)�Um�0?���/M�"�G��>ү��:��X)�km{��a5��Y�ҩ��Y�fO;]|C�d��of�_ev�rC@�K�Ξ���Cr�H�$�WF����B�da-=3<W��b�O�U�H�Ŵĝ�<Q,K-�(�:�����}�V�T^��O�����ŋMqgCO,�t=9ʲd{�G������޹��E����\ޯ�8�S�܁_�7��������Մ���>yn�I��^�>����H�[�'��G�T���:�����=}*N��~�'�V?�;�����-�����+�����87�)�����Q�#4���`��mԓ���̸����\�ߋ=<eWu#��w6�D�,	�Xܣ��l�/���z�⅔�����X5�Φ�{��u�{'��q>���|0���ZR�t�c���x5!����8�&1�z])�Rǜ�^�"��dZgvK��誧r�	y���T{P�8���Qٲ�j���N5�z�j$����3L\�Aܿ����(
X�D�Uyv��+��Z�;/�דv6�7O/�ώs�eo�b��0%��Xc���AQ>zl���S��<���\�=���M�]�e�s��[�{��q�M��{�?�Ww��?�E&|/��b��N��3�����.�T�$��$	��'%�)�����~4-,�cO6�.C�5'��S7��6DA�젱f��z��m�2�AU��У܃Ac�鰇p�z���=�Ю�RvZv����,�#�j�T���豣{�G����d�<(��m�D`����q�d{ȗ�>I��<��	?B���C���������<��@����X���͠���=�y4���X"_Chy�L7Kһ�������0艒�����WW�ѕ}�/�����-��x���߯�*,L=+[6T��ߢ� :YsO׮�y�)�B��QG7�6|��Z     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cox4iawtjyx34"
path="res://.godot/imported/Basic Charakter Spritesheet.png-a6c5fbedfdb2988fe044bfdcde38b569.ctex"
metadata={
"vram_texture": false
}
         GST2   @         ����               @         .  RIFF&  WEBPVP8L  /?�o���$��{�}�1�Q�Ju�WE3DP#5�$)^|.ο���m:��[> �8������m�g*��+�*0�ͶmMEM���o��L`+�NOX�Y ��*��>&��+p��W۶CϩgD�?CD��/{�ssۚ���������W.��K0�Y#�ć6E�n>�0h܍��x_�� �Zy�P�"u��|�n��-�@��M��x�	�oz^�)�Y�� � �L��iY��k�Ĝ�TjeږD�0|*����^�^�-��0�L�Y�,"����           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cv6u63x6fupep"
path="res://.godot/imported/Egg_And_Nest.png-e90aec337b65910de43c9ef09a9c865c.ctex"
metadata={
"vram_texture": false
}
        GST2   @          ����               @          ~  RIFFv  WEBPVP8Li  /?�W���$e�;\>����(�$�y�/�и��BHr�/�?B��A8�m:��[> ȭۿ�Ee�B������ G�޶���P���=�9��S&���S���c� �� ��lܶ��ٳ�
���I�~�� �cµ��y�/.0��-��;�ųXe��� d����3<��L??_�q��(����H
t�ɅK"��������	�G�ȝ�=rgD��g��A��!�ܗD�ۗ�Q�}�5ߗ��C�3bm_��΄`q��;�}o�Uм�-��}Mٮ|�J���x���|�G���Xt����ʹ��'Jau�j[Wv�\J�2�=��zG���{*G�����C           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://byiwkxevc228r"
path="res://.godot/imported/Free Chicken Sprites.png-07e84994a07a94afbe3b2ffa4b603772.ctex"
metadata={
"vram_texture": false
}
                GST2   `   @      ����               ` @        ^  RIFFV  WEBPVP8LJ  /_�_���$e���Zk��'�h�6�����^�N2ӶM�(���P
�`� (hۆqi��g� �����7�s@^��	� �ʶ�q��L�cn�$�?�Թ�I���\I��c�]�\�I{{y��sN�n#)R�}���0���cV�\_Z�ڑ���Վ��<%�r�V{�V;�Lm5	gg�ZG�B��ޯv���`���aj��;�����"��z�J��=�ю�� ���uU�U)�J�=�aMե��� o��a�")%��m��7h"rǲ�#��x��1)Lf�&�#���2 �21L��<��Tw�,G���p��4���|�yŽ��������|��s�Ym5����^`��b����ryb6��+sX���ˮ��j�:N5W�B�Ќ�EETre�VK�.�2�������]�Ha�vܺ�+s�Ӟ�U�\%Ǖ�{^J l�ܕ;4ț{^��!��B&KNrW�����7)|�&uhf/��Ϧ0�y��)�ehb��>*$��p3��2����Q�aw<����p��5�qq��"%���i8]b�65��6ǫ�          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://p38qfd2rutoo"
path="res://.godot/imported/Free Cow Sprites.png-2672a408f416f26b15622784cb90a57e.ctex"
metadata={
"vram_texture": false
}
     GST2   `   `      ����               ` `        �  RIFF�  WEBPVP8L�  /_���(��h�(��(P��D��6��8,��1�oS�&�ixt��� $":W�������S�[[��>{]��~��Hҁ5>���,I��Z·�?YX{��������H�"I�Y�^�����ϡZ�BN/��O�^���x��2`�N)Y������.��}�9��ߥ���Q.R'!)	Me,˵_�i��r]ג�LKgIȞP�n��Z���m��q\�cO��,G��Է��}?pܪ�P��.�Vxp��)����U}��7Fo�%<z9<.�-H��b����#���u��K\8(�ʮr�a��|�:䰭�j��ًi�\	3��<:�m��%P�����:��s�N�D����,��{�P�k!ՠ����E�̝��-w��ՙ;*�uH)Y��:��ܿtݭ��$��־ʝyj�;�Ms�*w���W�3>�u2��h͑;Uɝ��c�S+ϝ�˝V+ϝ�,w�V�ܩ,w��?ʝ�>ʝ6�f�ϻ<.�u[�h�1��N4Q� =b�~�^�:ꈇ�bfۨ��!��Z�@����PZQ�2�
,�}|d�g<������
�AN��p"�#J��Ӈie��c��l:��E]��}�)���z��\����>9�y�bŜ�wcD�n�kw�)eп�t��+.V�ଓ�6Y�J�HE��H�"�TԖv��UP�D�dӃY���M4#0�N�
`�[����=Xd9�lB����~x��lU�b"����-2�AO`�_�{,��(��b�"(ۺ�#�o���aL�i���X���R<Y�|��z�k.����H��b���Q�XfPJ��ϝ���'�� Ր;U��ܩ�6�D�Uϝj�~�;�5?�@�be,w���H��OkXza��6��G��haʝ�vכ�F� 
�s��6��m��󘯇 L`"s�����!>t}+����C|�W����sX���U_=wZ��`�j���#���!����!�	�ӧΆ�!�� %��8��z��f�v.�_�@���R|�r�D�����0'�]9������4tQ�y����ԋӉ������{hc䂇���\p��}�d�牃���Ո����"Go]R|%�,�r�l�4GW(���@��?C��d1sv��=P-�<PlVľ��ё���0�}��P�':�6F3Y��g�2�([Ҷ�)r=_�x�
'#d�"ǘ;.�]��Ze��C���U�8�t��ཱ| )K/w���ЪC�T��;Ug[�j�����,�5wZ#�^l"�xyZSh���5e;1J�Yɝ�h��MMac�,�in� �f��V�*��N��t�@[u��t�#BK�6�,�<��r��dՑ��+?��y��5�j 3�#��H���n�=C���|�c�˙ F�z  [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b1wm724suakxq"
path="res://.godot/imported/Tools.png-277f03943986df300b32fdd5968fec42.ctex"
metadata={
"vram_texture": false
}
               GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c8n7jy45rivst"
path="res://.godot/imported/icon.svg-13cb4c3794b53af6ed75e5428c303866.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-bc3b4a5402c2d367850c1b7aab3bd030-Charger.scn"
            [remap]

path="res://.godot/exported/133200997/export-94ac7a95b932d7103c68a5776a7128f3-enemy.scn"
              [remap]

path="res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn"
             [remap]

path="res://.godot/exported/133200997/export-176b3652f885f810abceb657bf9c86ae-player_health_ui.scn"
   [remap]

path="res://.godot/exported/133200997/export-f8b957969db01dd0b3d81f4e4ece5ef6-lasso.scn"
              [remap]

path="res://.godot/exported/133200997/export-134b5bc730c825a647ffd81bf58fa0a2-seed.scn"
               [remap]

path="res://.godot/exported/133200997/export-c43e392915a6619ac46a946642c83ca9-seed_shooter.scn"
       [remap]

path="res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn"
            [remap]

path="res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn"
          list=Array[Dictionary]([])
        coKl�#   res://entities/charger/Charger.tscn����s�	   res://entities/enemy/enemy.tscn�}�J��%l!   res://entities/knight/knight.tscn�y���+   res://entities/knight/player_health_ui.tscnf�s�@��   res://entities/lasso/lasso.tscn#]]/=�#E*   res://entities/seed_shooter/seed/seed.tscn�E2~gp-   res://entities/seed_shooter/seed_shooter.tscn�yG= 8�   res://levels/level_0.tscn��+��)b   res://levels/main_menu.tscn��(���t>   res://Temporary Sprites/Characters/Basic Charakter Actions.pngḷ�*��PB   res://Temporary Sprites/Characters/Basic Charakter Spritesheet.png�W#���W3   res://Temporary Sprites/Characters/Egg_And_Nest.png�fO�j�8;   res://Temporary Sprites/Characters/Free Chicken Sprites.png�5�h�p7   res://Temporary Sprites/Characters/Free Cow Sprites.png�٦��;,   res://Temporary Sprites/Characters/Tools.png�rO3t��b    res://Temporary Sprites/icon.svg   ECFG      application/config/name         LassoKnight    application/run/main_scene$         res://levels/level_0.tscn      application/config/features(   "         4.2    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   display/window/stretch/scale         @   editor_plugins/enabled8   "      *   res://addons/coi_serviceworker/plugin.cfg      input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      
   input/whip�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     C  �A   global_position      C  �B   factor       �?   button_index         canceled          pressed          double_click          script         input/reel_in�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     C  �A   global_position      C  �B   factor       �?   button_index         canceled          pressed          double_click          script         layer_names/2d_physics/layer_1         ground     layer_names/2d_physics/layer_2         player     layer_names/2d_physics/layer_3         enemies    physics/2d/default_gravity        pB9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc           