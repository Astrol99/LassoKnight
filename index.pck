GDPC                0                                                                         \   res://.godot/exported/133200997/export-176b3652f885f810abceb657bf9c86ae-player_health_ui.scn�      �      O�§����p\�@�N    T   res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn �0            ɷd��N��^�I���    T   res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn  �            V�	8'┥�^�P��    T   res://.godot/exported/133200997/export-94ac7a95b932d7103c68a5776a7128f3-enemy.scn   �      L      �~^���*�=�FAWj��    X   res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn   �4      �      �H�w�
m�"n/��    T   res://.godot/exported/133200997/export-f8b957969db01dd0b3d81f4e4ece5ef6-lasso.scn   @'      :	      �!�����DO0p��    ,   res://.godot/global_script_class_cache.cfg  �G             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP7      �      �Yz=������������       res://.godot/uid_cache.bin  �G      $      ���@�=�!|~�/6	        res://entities/enemy/enemy.gd           �      �	��0��=���M��    (   res://entities/enemy/enemy.tscn.remap    E      b       �T���Agt#C���O    $   res://entities/knight/Camera2D.gd   �            �"���%��A����FZ�        res://entities/knight/knight.gd  	      �      ?L;];��Ӯ*��$`�    (   res://entities/knight/knight.tscn.remap pE      c       	%�]�K�wıË�L�    ,   res://entities/knight/player_health_ui.gd   �            A(� �`�;��#    4   res://entities/knight/player_health_ui.tscn.remap   �E      m       ;�d������(A�        res://entities/lasso/lasso.gd   �!      �      ,����`ы��"�Ix    (   res://entities/lasso/lasso.tscn.remap   PF      b       }�3!Fu��4HP3       res://icon.svg.import   0D      �       ��wFŽ��R�"���        res://levels/level_0.tscn.remap �F      d       �]LG˻�<�5��7�    $   res://levels/main_menu.tscn.remap   0G      f       ���p��!c����#v�       res://project.binary�H      �      ��pO�>_�E-�ڄ    extends CharacterBody2D

@export var speed = 0.5
@onready var player = get_parent().get_node("Knight")

func _physics_process(delta):
	if is_instance_valid(player):
		position = position.lerp(player.position, speed * delta)
		#var direction = (player.position - position).normalized()
		#velocity = direction * speed
	
	#if is_in_group("captured"):
		
	
	#move_and_collide(velocity * delta)
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://entities/enemy/enemy.gd ��������
   Texture2D    res://icon.svg �rO3t��b      local://RectangleShape2D_sdnq0 �         local://PackedScene_50huy �         RectangleShape2D       
      B   B         PackedScene          	         names "         Enemy 	   modulate    collision_layer    collision_mask    script    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    	   variants            �?          �?                      
     �>  �>                         node_count             nodes     #   ��������       ����                                              ����                           	   	   ����   
                conn_count              conns               node_paths              editable_instances              version             RSRC    extends Camera2D

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
	if Input.is_action_just_pressed("m1"):
		lasso.whip(get_global_mouse_position())
	
	velocity = input_direction * move_speed
	
	move_and_slide()

func _on_hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		if body.is_in_group("captured"):
			# Delete rope and enemy attached
			lasso.captured_enemies[body].queue_free()
			body.queue_free()
			# Remove enemy and rope entries from captured_enemy dictionary
			lasso.captured_enemies.erase(body)
		else:
			hp -= 1
          RSRC                    PackedScene            ��������                                            )      ..    AnimationPlayer    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    _data    auto_triangles 
   min_space 
   max_space    snap    x_label    y_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/Idle/node    states/Idle/position    states/Start/node    states/Start/position    states/Walk/node    states/Walk/position    transitions    graph_offset 	   _bundled       Script     res://entities/knight/knight.gd ��������
   Texture2D    res://icon.svg �rO3t��b   Script "   res://entities/knight/Camera2D.gd ��������   PackedScene     res://entities/lasso/lasso.tscn f�s�@��   PackedScene ,   res://entities/knight/player_health_ui.tscn �y���
      local://RectangleShape2D_vcw2b )         local://Animation_8qprx Z         local://AnimationLibrary_a50b0 �      (   local://AnimationNodeBlendSpace2D_va5ow �      (   local://AnimationNodeBlendSpace2D_8tqgi '      2   local://AnimationNodeStateMachineTransition_qojdq Q      2   local://AnimationNodeStateMachineTransition_1x020 �      (   local://AnimationNodeStateMachine_yrndm �         local://RectangleShape2D_an74c �         local://PackedScene_cth4a �         RectangleShape2D       
      B   B      
   Animation             idle_up          AnimationLibrary    
               idle_up                   AnimationNodeBlendSpace2D       
     ���̌�   
     �?�̌?                  AnimationNodeBlendSpace2D          $   AnimationNodeStateMachineTransition          $   AnimationNodeStateMachineTransition                       AnimationNodeStateMachine 
                      !   
    ��C  �B"      #   
     /C  �B$            %   
     �C  �B&               Start       Idle                Idle       Walk          '   
     ��  ��         RectangleShape2D       
      B   B         PackedScene    (      	         names "         Knight    collision_layer    script    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    AnimationPlayer 
   libraries    AnimationTree 
   tree_root    anim_player    parameters/Idle/blend_position    parameters/Walk/blend_position 	   Camera2D    process_callback    position_smoothing_enabled    Hitbox    collision_mask    Area2D    debug_color    Lasso    HUD    CanvasLayer    PlayerHealthUI    offset 
   transform    _on_hitbox_body_entered    body_entered    	   variants                       
     �>  �>                                                               
   `��7M��
                                                       ��&?���=���>                  
      A   A   ���=        ���=   A   A      node_count             nodes     u   ��������       ����                                  ����                                 ����                     	   	   ����   
                        ����   
                           	                     ����      
                                 ����                                 ����                           ���                            ����        	       ���                               conn_count             conns                                      node_paths              editable_instances              version             RSRC          extends CanvasLayer

@onready var player = get_parent().get_parent()
@onready var HealthUIFull = $HealthUIFull

func _ready():
	if player:
		player.hp_changed.connect(_on_player_hp_changed)

func _on_player_hp_changed(hp, new_hp):
	if new_hp >= 0:
		HealthUIFull.size.x = new_hp * 128
   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script *   res://entities/knight/player_health_ui.gd ��������
   Texture2D    res://icon.svg �rO3t��b      local://PackedScene_gn6r3 J         PackedScene          	         names "         PlayerHealthUI    scale 
   transform    script    CanvasLayer    HealthUIFull    offset_right    offset_bottom    texture    stretch_mode    TextureRect    	   variants       
   ���=���=   ���=        ���=                        B                     node_count             nodes        ��������       ����                                  
      ����                     	                conn_count              conns               node_paths              editable_instances              version             RSRC            extends Area2D

@onready var animation_player = $AnimationPlayer

# key: value pair
# {body: rope}
var captured_enemies = {}

func _physics_process(delta):
	# Captured enemies in dictionary {body: rope} pair
	for body in captured_enemies:
		var rope = captured_enemies[body]
		rope.points = lasso_to_curve(Vector2.ZERO, to_local(body.position))
		# Slowly increase reeling speed
		body.speed += 7 * delta

func whip(mouse_pos):
	look_at(mouse_pos)
	animation_player.play("whip")

func lasso_to_curve(p0_vertex: Vector2, p1_vertex: Vector2):
	var curve = Curve2D.new()
	# Adjust curves to change sides
	var p0_out = Vector2.ZERO
	if p0_vertex.x > p1_vertex.x:
		p0_out = Vector2(-50, 0)
	else:
		p0_out = Vector2(50, 0)
	curve.add_point(p0_vertex, Vector2.ZERO, p0_out);
	curve.add_point(p1_vertex, Vector2.ZERO, Vector2.ZERO);
	return curve.get_baked_points()

func reel_in(body):
	# Instance new rope on knight
	var rope = Line2D.new()
	rope.width = 2
	rope.default_color = Color(0.588, 0.447, 0.349)
	add_child(rope)
	# Add rope point on knight and enemy and connect (relative position to knight)
	rope.points = lasso_to_curve(Vector2.ZERO, to_local(body.position))
	# Save captured enemies in array to continiously update in process function
	captured_enemies[body] = rope

func _on_body_entered(body):
	if body.is_in_group("enemies") and not body.is_in_group("captured"):
		body.add_to_group("captured")
		reel_in(body)
RSRC                    PackedScene            ��������                                               	   Sprite2D    visible    .    collision_mask    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    _data 	   _bundled       Script    res://entities/lasso/lasso.gd ��������
   Texture2D    res://icon.svg �rO3t��b      local://RectangleShape2D_uhr6h N         local://Animation_h4bxe          local://AnimationLibrary_etrjf z         local://PackedScene_7a8i8 �         RectangleShape2D       
     �B  �A      
   Animation             whip 	         ?         value                                                                    times !             ?      transitions !        �?  �?      values                          update                value                                                                   times !             ?      transitions !        �?  �?      values                          update                AnimationLibrary                   whip                   PackedScene          	         names "         Lasso    collision_layer    collision_mask    script    Area2D 	   Sprite2D    visible 	   position    scale    texture    CollisionShape2D    shape    debug_color    AnimationPlayer 
   libraries    _on_body_entered    body_entered    	   variants    
                           
     �B��5
     8?   >         
     �B                 ��U?���>��*?���>                            node_count             nodes     2   ��������       ����                                         ����                     	                  
   
   ����                                       ����      	             conn_count             conns                                       node_paths              editable_instances              version             RSRC      RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene "   res://entities/knight/knight.tscn �}�J��%l   PackedScene     res://entities/enemy/enemy.tscn ����s�	      local://PackedScene_eq2y5 Z         PackedScene          	         names "   	      Level0    Node2D    Knight 	   position    Enemy    enemies    Enemy2    Enemy3    Enemy4    	   variants                 
     �A  �A         
    ��C  ��
     LB  C
     �A  ��
     6�  �A      node_count             nodes     8   ��������       ����                ���                            ���                             ���                             ���                             ���                           conn_count              conns               node_paths              editable_instances              version             RSRC          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_vmado �          PackedScene          	         names "      	   MainMenu    Node2D    Label    offset_right    offset_bottom    text    	   variants             B     �A      LassoKnight       node_count             nodes        ��������       ����                      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC           GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
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

path="res://.godot/exported/133200997/export-f8b957969db01dd0b3d81f4e4ece5ef6-lasso.scn"
              [remap]

path="res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn"
            [remap]

path="res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn"
          list=Array[Dictionary]([])
        ����s�	   res://entities/enemy/enemy.tscn�}�J��%l!   res://entities/knight/knight.tscn�y���+   res://entities/knight/player_health_ui.tscnf�s�@��   res://entities/lasso/lasso.tscn�yG= 8�   res://levels/level_0.tscn��+��)b   res://levels/main_menu.tscn�rO3t��b   res://icon.svg            ECFG      application/config/name         LassoKnight    application/run/main_scene$         res://levels/level_0.tscn      application/config/features(   "         4.2    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   display/window/stretch/scale         @   editor_plugins/enabled8   "      *   res://addons/coi_serviceworker/plugin.cfg      input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/m1�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     C  �A   global_position      C  �B   factor       �?   button_index         canceled          pressed          double_click          script         layer_names/2d_physics/layer_1         ground     layer_names/2d_physics/layer_2         player     layer_names/2d_physics/layer_3         enemies    physics/2d/default_gravity        pB9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc          