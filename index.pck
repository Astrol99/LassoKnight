GDPC                @                                                                         \   res://.godot/exported/133200997/export-176b3652f885f810abceb657bf9c86ae-player_health_ui.scn`'      �      ����
a��q���0�    X   res://.godot/exported/133200997/export-41a665b0cc927053a3c3b5d615e927db-verlet_rope.scn �7      r      A08؞A�JJ�6�!6    T   res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn P;      �      ��b!��� ڤ�OV-    T   res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn  �      Y      ��l/�ǾX�r߅�A�/    T   res://.godot/exported/133200997/export-94ac7a95b932d7103c68a5776a7128f3-enemy.scn   P      �      6�W�3ݣ6���K    X   res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn   0@      �      ����2�.E���)�|    ,   res://.godot/global_script_class_cache.cfg  @S             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�B      �      �Yz=������������       res://.godot/uid_cache.bin  `S      *      4m�m��S ��)�q�6        res://entities/enemy/enemy.gd           M      \x��h�h��)q�J    (   res://entities/enemy/enemy.tscn.remap   �P      b       �T���Agt#C���O    $   res://entities/knight/Camera2D.gd   �            �"���%��A����FZ�        res://entities/knight/knight.gd       �      wO{�I&{Kf@##�    (   res://entities/knight/knight.tscn.remap Q      c       	%�]�K�wıË�L�    ,   res://entities/knight/player_health_ui.gd   @&            :�����t��`�R��%    4   res://entities/knight/player_health_ui.tscn.remap   �Q      m       ;�d������(A�    $   res://entities/lasso/verlet_rope.gd 0+      �      f!���0�����M���    ,   res://entities/lasso/verlet_rope.tscn.remap �Q      h       �[G�:�3|�?9A���       res://icon.svg.import   �O      �       ��wFŽ��R�"���        res://levels/level_0.tscn.remap `R      d       �]LG˻�<�5��7�    $   res://levels/main_menu.tscn.remap   �R      f       ���p��!c����#v�       res://project.binary�T      0      ����z?�G4g�A �)_        extends CharacterBody2D

@export var speed = 50
@export var damage : int = 1
@export var moving: bool = true

@onready var player = get_parent().get_node("Knight")

var desired_velocity = Vector2.ZERO

func _physics_process(delta):
	if is_instance_valid(player) and moving:
		var direction = (player.position - position).normalized()
		desired_velocity = direction * speed
		if is_in_group("capturing"):
			direction *= -1
			velocity.x = desired_velocity.x - player.desired_velocity.x
		else:
			velocity = desired_velocity
	
	move_and_slide()


func _on_hitbox_area_entered(area):
	pass
   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://entities/enemy/enemy.gd ��������
   Texture2D    res://icon.svg �rO3t��b      local://RectangleShape2D_sdnq0 �         local://RectangleShape2D_bra3n          local://RectangleShape2D_ark4w A         local://PackedScene_yx0r2 r         RectangleShape2D       
      B   B         RectangleShape2D       
      B   B         RectangleShape2D       
     B  B         PackedScene          	         names "         Enemy    collision_layer    script    enemy    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    debug_color    Hitbox    collision_mask    Area2D    Hurtbox 	   position    _on_hitbox_area_entered    area_entered    	   variants                       
     �>  �>                          ��?��3?���>   
                   ��%?��p>���>             
          ?            ��n?��\>���>���>      node_count             nodes     P   ��������       ����                                    ����                                 ����   	      
                        ����                                 ����   	      
                        ����      	      
                    ����         	      
                conn_count             conns                                      node_paths              editable_instances              version             RSRC       extends Camera2D

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

@onready var lasso = preload("res://entities/lasso/verlet_rope.tscn")
@onready var hurtbox = $HurtBox

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var desired_velocity = Vector2.ZERO

var bodies = []

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
	if Input.is_action_just_pressed("whip") and not animation_player.is_playing():
		hurtbox.look_at(get_global_mouse_position())
		animation_player.play("attack")
	
	desired_velocity = input_direction * move_speed
	
	velocity = desired_velocity
	
	for body in bodies:
		velocity -= body.desired_velocity
	
	move_and_slide()


var verlet_rope = preload("res://entities/lasso/verlet_rope.tscn")

func add_new_rope(body):
	var rope = verlet_rope.instantiate()
	rope.origin = self
	rope.target = body
	get_parent().add_child(rope)

func _on_hit_box_body_entered(body):
	if body.is_in_group("enemy") and not body.is_in_group("captured"):
		hp -= body.damage

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemy") and not body.is_in_group("captured"):
		call_deferred("add_new_rope", body)
		body.add_to_group("capturing")
		bodies.append(body)
 RSRC                    PackedScene            ��������                                            ;      HurtBox    collision_mask 	   Sprite2D    visible    ..    AnimationPlayer    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    _data    auto_triangles 
   min_space 
   max_space    snap    x_label    y_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/Idle/node    states/Idle/position    states/Start/node    states/Start/position    states/Walk/node    states/Walk/position    transitions    graph_offset 	   _bundled       Script     res://entities/knight/knight.gd ��������
   Texture2D    res://icon.svg �rO3t��b   Script "   res://entities/knight/Camera2D.gd ��������   PackedScene ,   res://entities/knight/player_health_ui.tscn �y���      local://RectangleShape2D_vcw2b h         local://Animation_audbw �         local://AnimationLibrary_a50b0 �	      (   local://AnimationNodeBlendSpace2D_va5ow �	      (   local://AnimationNodeBlendSpace2D_8tqgi 8
      2   local://AnimationNodeStateMachineTransition_qojdq b
      2   local://AnimationNodeStateMachineTransition_1x020 �
      (   local://AnimationNodeStateMachine_yrndm �
         local://RectangleShape2D_nid7g �         local://RectangleShape2D_an74c �         local://PackedScene_kg564 +         RectangleShape2D    	   
      B   B
      
   Animation             attack          ?         value                                                                    times !             ?      transitions !        �?  �?      values                          update                value                                                                       times !             ?      transitions !        �?  �?      values                          update       
         AnimationLibrary                   attack          
         AnimationNodeBlendSpace2D       
     ���̌�   
     �?�̌?#         
         AnimationNodeBlendSpace2D    
      $   AnimationNodeStateMachineTransition    
      $   AnimationNodeStateMachineTransition    *          
         AnimationNodeStateMachine 
   0      2            3   
    ��C  �B4      5   
     /C  �B6            7   
     �C  �B8               Start       Idle                Idle       Walk          9   
     ��  ��
         RectangleShape2D    	   
      B   B
         RectangleShape2D    	   
     �B  B
         PackedScene    :      	         names "   "      Knight    collision_layer    script    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    AnimationPlayer 
   libraries    AnimationTree 
   tree_root    anim_player    parameters/Idle/blend_position    parameters/Walk/blend_position 	   Camera2D    process_callback    position_smoothing_enabled    HitBox    collision_mask    Area2D    debug_color    HurtBox 	   position    visible    HUD    CanvasLayer    PlayerHealthUI    offset 
   transform    _on_hit_box_body_entered    body_entered    _on_hurtbox_body_entered    	   variants                       
     �>  �>                                                              
   `��7M��
                                                   ���>��?���>���>      
     �B          	        �?        ���>       
     x?  �>         
      A   A   ���=        ���=   A   A      node_count             nodes     �   ��������       ����                                  ����                                 ����                     	   	   ����   
                        ����   
                           	                     ����      
                                 ����                                 ����                                 ����            
                    ����                                      ����                                             ����               ���                               conn_count             conns                                            !                    node_paths              editable_instances              version       
      RSRC       extends CanvasLayer

@onready var player = get_parent().get_parent()
@onready var HealthUIFull = $HealthUIFull

func _ready():
	if player:
		player.hp_changed.connect(_on_player_hp_changed)

func _on_player_hp_changed(_hp, new_hp):
	if new_hp >= 0:
		HealthUIFull.size.x = new_hp * 128
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script *   res://entities/knight/player_health_ui.gd ��������
   Texture2D    res://icon.svg �rO3t��b      local://PackedScene_s61fe J         PackedScene          	         names "         PlayerHealthUI    scale 
   transform    script    CanvasLayer    HealthUIFull    offset_right    offset_bottom    texture    stretch_mode    TextureRect    	   variants       
   ���=���=   ���=        ���=                        B                     node_count             nodes        ��������       ����                                  
      ����                     	                conn_count              conns               node_paths              editable_instances              version             RSRC            extends Node2D

@onready var origin: CharacterBody2D
@export var target: CharacterBody2D

@export var range: float = 250
@export var ropeLength: float = 30
@export var constrain: float = 1	# distance between points
@export var gravity: Vector2 = Vector2(0,9.8)
@export var dampening: float = 0.9
@export var startPin: bool = true
@export var endPin: bool = true

@onready var line2D: = $Line2D
@onready var progressBar = $ProgressBar

var pos: PackedVector2Array
var posPrev: PackedVector2Array
var pointCount: int

func _ready()->void:
	progressBar.max_value = range
	pointCount = get_pointCount(ropeLength)
	resize_arrays()
	init_position()

func get_pointCount(distance: float)->int:
	return int(ceil(distance / constrain))

func resize_arrays():
	pos.resize(pointCount)
	posPrev.resize(pointCount)

func init_position()->void:
	for i in range(pointCount):
		pos[i] = position + Vector2(constrain *i, 0)
		posPrev[i] = position + Vector2(constrain *i, 0)
	position = Vector2.ZERO

"""
func _unhandled_input(event:InputEvent)->void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("click"):	#Move start point
			set_start(get_global_mouse_position())
		if Input.is_action_pressed("right_click"):	#Move start point
			set_last(get_global_mouse_position())
	elif event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			set_start(get_global_mouse_position())
		elif event.button_index == 2:
			set_last(get_global_mouse_position())
"""

func _process(delta)->void:
	# Lock rope and bodies to certain range of distance
	if target and origin:
		var dist = origin.position.distance_to(target.position)
		progressBar.global_position = origin.global_position
		progressBar.value = dist
		if dist < range:
			set_start(origin.position)
			set_last(target.position)
		else:
			print("ROPE BROKE")
			target.remove_from_group("capturing")
			queue_free()
	update_points(delta)
	update_constrain()
	
	#update_constrain()	#Repeat to get tighter rope
	#update_constrain()
	
	# Send positions to Line2D for drawing
	line2D.points = pos

func set_start(p:Vector2)->void:
	pos[0] = p
	posPrev[0] = p

func set_last(p:Vector2)->void:
	pos[pointCount-1] = p
	posPrev[pointCount-1] = p

func update_points(delta)->void:
	for i in range (pointCount):
		# not first and last || first if not pinned || last if not pinned
		if (i!=0 && i!=pointCount-1) || (i==0 && !startPin) || (i==pointCount-1 && !endPin):
			var velocity = (pos[i] -posPrev[i]) * dampening
			posPrev[i] = pos[i]
			pos[i] += velocity + (gravity * delta)

func update_constrain()->void:
	for i in range(pointCount):
		if i == pointCount-1:
			return
		var distance = pos[i].distance_to(pos[i+1])
		var difference = constrain - distance
		var percent = difference / distance
		var vec2 = pos[i+1] - pos[i]
		
		# if first point
		if i == 0:
			if startPin:
				pos[i+1] += vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
		# if last point, skip because no more points after it
		elif i == pointCount-1:
			pass
		# all the rest
		else:
			if i+1 == pointCount-1 && endPin:
				pos[i] -= vec2 * percent
			else:
				pos[i] -= vec2 * (percent/2)
				pos[i+1] += vec2 * (percent/2)
              RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script $   res://entities/lasso/verlet_rope.gd ��������      local://PackedScene_rvh8w          PackedScene          	         names "   
      VerletRope    script    Node2D    Line2D    width    ProgressBar    offset_left    offset_top    offset_right    offset_bottom    	   variants                       @     ��     l�     �B      �      node_count             nodes     !   ��������       ����                            ����                           ����                     	                conn_count              conns               node_paths              editable_instances              version             RSRC              RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    diffuse_texture    normal_texture    specular_texture    specular_color    specular_shininess    texture_filter    texture_repeat    script 	   _bundled       PackedScene "   res://entities/knight/knight.tscn �}�J��%l   PackedScene     res://entities/enemy/enemy.tscn ����s�	      local://CanvasTexture_yebod          local://PackedScene_g03wf ,         CanvasTexture    	         PackedScene    
      	         names "         Level0    Node2D    TextureRect    offset_left    offset_top    offset_right    offset_bottom    texture    Knight    Enemy 	   position    speed    	   variants    	        ��     ��     �     l�                             
     C   @   d         node_count             nodes     *   ��������       ����                      ����                                              ���                      ���	         
                      conn_count              conns               node_paths              editable_instances              version       	      RSRC RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_wbnuq �          PackedScene          	         names "      	   MainMenu    Node2D    Label    offset_right    offset_bottom    text    	   variants             B     �A      LassoKnight       node_count             nodes        ��������       ����                      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC           GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
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
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-94ac7a95b932d7103c68a5776a7128f3-enemy.scn"
              [remap]

path="res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn"
             [remap]

path="res://.godot/exported/133200997/export-176b3652f885f810abceb657bf9c86ae-player_health_ui.scn"
   [remap]

path="res://.godot/exported/133200997/export-41a665b0cc927053a3c3b5d615e927db-verlet_rope.scn"
        [remap]

path="res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn"
            [remap]

path="res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn"
          list=Array[Dictionary]([])
        ����s�	   res://entities/enemy/enemy.tscn�}�J��%l!   res://entities/knight/knight.tscn�y���+   res://entities/knight/player_health_ui.tscn�6�4k��%   res://entities/lasso/verlet_rope.tscn�yG= 8�   res://levels/level_0.tscn��+��)b   res://levels/main_menu.tscn�rO3t��b   res://icon.svg      ECFG      application/config/name         LassoKnight    application/run/main_scene$         res://levels/level_0.tscn      application/config/features(   "         4.2    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   display/window/stretch/scale         @   editor_plugins/enabled8   "      *   res://addons/coi_serviceworker/plugin.cfg      input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      
   input/whip�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     C  �A   global_position      C  �B   factor       �?   button_index         canceled          pressed          double_click          script         input/reel_in�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     C  �A   global_position      C  �B   factor       �?   button_index         canceled          pressed          double_click          script         layer_names/2d_physics/layer_1         ground     layer_names/2d_physics/layer_2         player     layer_names/2d_physics/layer_3         enemy      layer_names/2d_physics/layer_4         rope   physics/2d/default_gravity        pB9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc         