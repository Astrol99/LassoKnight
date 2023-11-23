GDPC                �                                                                         T   res://.godot/exported/133200997/export-21b780c0d4e68e8c35280599c3e67de2-player.scn  �6      �      �]��TI�T�`���_[    T   res://.godot/exported/133200997/export-48d9922f8b8c50fc9589f06111672b9b-Lasso.scn    #      |      [��I�� ��۸��    P   res://.godot/exported/133200997/export-7800922cd0580362ce56304d6150ac04-test.scn�>      �      �=����2d��.MT��    X   res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn   �;      �      ,Ӧ(t�N92A޸�    T   res://.godot/exported/133200997/export-f8b957969db01dd0b3d81f4e4ece5ef6-lasso.scn   �      |      
VRx� r?3:��HI!    ,   res://.godot/global_script_class_cache.cfg   W             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex G      �      �Yz=������������    H   res://.godot/imported/noose.png-2c7b89ce14d41a6e9fedf8a0c03304ae.ctex           �       *����u�
��.�l�    L   res://.godot/imported/rope_links.png-15f63f73da0bf2fa96bebcd81ed5b6ed.ctex  `      j       ���ާ5��J}N���Q       res://.godot/uid_cache.bin   W            #(��~r�[���(�E�    $   res://assets/lasso/noose.png.import �       �       ��5�g@c"q���g�    (   res://assets/lasso/rope_links.png.import�      �       �i��~��І+��^        res://entities/Lasso/Lasso.gd          �      "�^P����s��bx��    (   res://entities/Lasso/Lasso.tscn.remap   @U      b       �X��B��i#z���        res://entities/lasso/Lasso.gd   �      �      "�^P����s��bx��        res://entities/lasso/lasso.gd   �      �      "�^P����s��bx��    (   res://entities/lasso/lasso.tscn.remap   �T      b       }�3!Fu��4HP3    $   res://entities/player/Camera2D.gd   �(            �	�=\�`&\�'��P�        res://entities/player/player.gd �+            �����@l8�9_D$    (   res://entities/player/player.tscn.remap �U      c       MR`�櫗�.�	��w       res://icon.svg.import    T      �       ��wFŽ��R�"���    $   res://levels/main_menu.tscn.remap    V      f       ���p��!c����#v�       res://levels/test.tscn.remap�V      a       �l�}B���7����}+       res://project.binary@X      N
      d�Iگ��\I��&{�        GST2            ����                        J   RIFFB   WEBPVP8L6   /�0��?��pE�$5�3L���� ������s�LDy�j�SP ���              [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b20y0tf0125gq"
path="res://.godot/imported/noose.png-2c7b89ce14d41a6e9fedf8a0c03304ae.ctex"
metadata={
"vram_texture": false
}
               GST2            ����                        2   RIFF*   WEBPVP8L   /�0��?��p�l��l3;�"�.�      [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d1k1yogptxstn"
path="res://.godot/imported/rope_links.png-15f63f73da0bf2fa96bebcd81ed5b6ed.ctex"
metadata={
"vram_texture": false
}
          """
This script controls the chain.
"""
extends Node2D

@onready var links = $Links
@onready var tip = $Tip
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip_pos := Vector2(0,0)			# The global position the tip should be in
								# We use an extra var for this, because the chain is 
								# connected to the player and thus all .position
								# properties would get messed with when the player
								# moves.

const SPEED = 50	# The speed with which the chain moves

var flying = false	# Whether the chain is moving through the air
var hooked = false	# Whether the chain has connected to a wall

# shoot() shoots the chain in a given direction
func shoot(dir: Vector2) -> void:
	direction = dir.normalized()	# Normalize the direction and save it
	flying = true					# Keep track of our current scan
	tip_pos = self.global_position		# reset the tip position to the player's position

# release() the chain
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something
	if not self.visible:
		return	# Not visible -> nothing to draw
	var tip_loc = to_local(tip_pos)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	links.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	tip.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	links.position = tip_loc						# The links are moved to start at the tip
	links.region_rect.size.y = tip_loc.length()		# and get extended for the distance between (0,0) and the tip

# Every physics frame we update the tip position
func _physics_process(_delta: float) -> void:
	tip.global_position = tip_pos	# The player might have moved and thus updated the position of the tip -> reset it
	if flying:
		# `if move_and_collide()` always moves, but returns true if we did collide
		if tip.move_and_collide(direction * SPEED):
			hooked = true	# Got something!
			flying = false	# Not flying anymore
	tip_pos = tip.global_position	# set `tip` as starting position for next frame
     """
This script controls the chain.
"""
extends Node2D

@onready var links = $Links
@onready var tip = $Tip
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip_pos := Vector2(0,0)			# The global position the tip should be in
								# We use an extra var for this, because the chain is 
								# connected to the player and thus all .position
								# properties would get messed with when the player
								# moves.

const SPEED = 50	# The speed with which the chain moves

var flying = false	# Whether the chain is moving through the air
var hooked = false	# Whether the chain has connected to a wall

# shoot() shoots the chain in a given direction
func shoot(dir: Vector2) -> void:
	direction = dir.normalized()	# Normalize the direction and save it
	flying = true					# Keep track of our current scan
	tip_pos = self.global_position		# reset the tip position to the player's position

# release() the chain
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something
	if not self.visible:
		return	# Not visible -> nothing to draw
	var tip_loc = to_local(tip_pos)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	links.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	tip.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	links.position = tip_loc						# The links are moved to start at the tip
	links.region_rect.size.y = tip_loc.length()		# and get extended for the distance between (0,0) and the tip

# Every physics frame we update the tip position
func _physics_process(_delta: float) -> void:
	tip.global_position = tip_pos	# The player might have moved and thus updated the position of the tip -> reset it
	if flying:
		# `if move_and_collide()` always moves, but returns true if we did collide
		if tip.move_and_collide(direction * SPEED):
			hooked = true	# Got something!
			flying = false	# Not flying anymore
	tip_pos = tip.global_position	# set `tip` as starting position for next frame
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    height    script 	   _bundled       Script    res://entities/lasso/lasso.gd ��������
   Texture2D "   res://assets/lasso/rope_links.png �����K�|
   Texture2D    res://assets/lasso/noose.png , �韴'<      local://CapsuleShape2D_7tnxl �         local://PackedScene_hjej1          CapsuleShape2D             @        @A         PackedScene          	         names "         Lasso    scale    script    Node2D    Links    texture_repeat    texture 	   centered    offset    region_enabled    region_rect 	   Sprite2D    Tip    collision_layer    CharacterBody2D    Noose    CollisionShape2D    shape    	   variants       
      @   @                                
     ��               �@       @  �C                               node_count             nodes     9   ��������       ����                                  ����                           	      
                        ����                          ����      	                    ����      
             conn_count              conns               node_paths              editable_instances              version             RSRC    """
This script controls the chain.
"""
extends Node2D

@onready var links = $Links
@onready var tip = $Tip
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip_pos := Vector2(0,0)			# The global position the tip should be in
								# We use an extra var for this, because the chain is 
								# connected to the player and thus all .position
								# properties would get messed with when the player
								# moves.

const SPEED = 50	# The speed with which the chain moves

var flying = false	# Whether the chain is moving through the air
var hooked = false	# Whether the chain has connected to a wall

# shoot() shoots the chain in a given direction
func shoot(dir: Vector2) -> void:
	direction = dir.normalized()	# Normalize the direction and save it
	flying = true					# Keep track of our current scan
	tip_pos = self.global_position		# reset the tip position to the player's position

# release() the chain
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something
	if not self.visible:
		return	# Not visible -> nothing to draw
	var tip_loc = to_local(tip_pos)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	links.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	tip.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	links.position = tip_loc						# The links are moved to start at the tip
	links.region_rect.size.y = tip_loc.length()		# and get extended for the distance between (0,0) and the tip

# Every physics frame we update the tip position
func _physics_process(_delta: float) -> void:
	tip.global_position = tip_pos	# The player might have moved and thus updated the position of the tip -> reset it
	if flying:
		# `if move_and_collide()` always moves, but returns true if we did collide
		if tip.move_and_collide(direction * SPEED):
			hooked = true	# Got something!
			flying = false	# Not flying anymore
	tip_pos = tip.global_position	# set `tip` as starting position for next frame
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    height    script 	   _bundled       Script    res://entities/lasso/lasso.gd ��������
   Texture2D "   res://assets/lasso/rope_links.png �����K�|
   Texture2D    res://assets/lasso/noose.png , �韴'<      local://CapsuleShape2D_7tnxl �         local://PackedScene_8pa2y          CapsuleShape2D             @        @A         PackedScene          	         names "         Lasso    scale    script    Node2D    Links    texture_repeat    texture 	   centered    offset    region_enabled    region_rect 	   Sprite2D    Tip    collision_layer    CharacterBody2D    Noose    CollisionShape2D    shape    	   variants       
      @   @                                
     ��               �@       @  �C                               node_count             nodes     9   ��������       ����                                  ����                           	      
                        ����                          ����      	                    ����      
             conn_count              conns               node_paths              editable_instances              version             RSRC    extends Camera2D

# Radius of the zone in the middle of the screen where the cam doesn't move
const DEAD_ZONE = 160

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
           """
This script controls the player character.
"""
extends CharacterBody2D

@onready var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP_FORCE = 1000			# Force applied on jumping
const MOVE_SPEED = 500			# Speed to walk with
const MAX_SPEED = 2000			# Maximum speed the player is allowed to move
const FRICTION_AIR = 0.95		# The friction while airborne
const FRICTION_GROUND = 0.85	# The friction while on the ground
const CHAIN_PULL = 105

@onready var lasso = $Lasso
var chain_velocity := Vector2(0,0)
var can_jump = false			# Whether the player used their air-jump

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			# We clicked the mouse -> shoot()
			lasso.shoot(event.position - get_viewport().get_visible_rect().size * 0.5)
		else:
			# We released the mouse -> release()
			lasso.release()

# This function is called every physics frame
func _physics_process(_delta: float) -> void:
	# Walking
	var walk = (Input.get_action_strength("right") - Input.get_action_strength("left")) * MOVE_SPEED

	# Falling
	velocity.y += GRAVITY

	# Hook physics
	if lasso.hooked:
		# `to_local(lasso.tip).normalized()` is the direction that the chain is pulling
		chain_velocity = to_local(lasso.tip_pos).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			# Pulling down isn't as strong
			chain_velocity.y *= 0.55
		else:
			# Pulling up is stronger
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(walk):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			chain_velocity.x *= 0.7
	else:
		# Not hooked -> no chain velocity
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity

	velocity.x += walk		# apply the walking
	move_and_slide()	# Actually apply all the forces
	velocity.x -= walk		# take away the walk speed again
	# ^ This is done so we don't build up walk speed over time

	# Manage friction and refresh jump and stuff
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)	# Make sure we are in our limits
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	var grounded = is_on_floor()
	if grounded:
		velocity.x *= FRICTION_GROUND	# Apply friction only on x (we are not moving on y anyway)
		can_jump = true 				# We refresh our air-jump
		if velocity.y >= 5:		# Keep the y-velocity small such that
			velocity.y = 5		# gravity doesn't make this number huge
	elif is_on_ceiling() and velocity.y <= -5:	# Same on ceilings
		velocity.y = -5

	# Apply air friction
	if !grounded:
		velocity.x *= FRICTION_AIR
		if velocity.y > 0:
			velocity.y *= FRICTION_AIR

	# Jumping
	if Input.is_action_just_pressed("up"):
		if grounded:
			velocity.y = -JUMP_FORCE	# Apply the jump-force
		elif can_jump:
			can_jump = false	# Used air-jump
			velocity.y = -JUMP_FORCE
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script     res://entities/player/player.gd ��������
   Texture2D    res://icon.svg �rO3t��b   Script "   res://entities/player/Camera2D.gd ��������   PackedScene     res://entities/Lasso/Lasso.tscn �H��>`      local://RectangleShape2D_6r81l           local://PackedScene_sh6hl 1         RectangleShape2D       
     �B  �B         PackedScene          	         names "         Player    scale    collision_layer    script    CharacterBody2D    Sprite    texture 	   Sprite2D    CollisionShape2D    shape 	   Camera2D    Lasso    	   variants       
      ?   ?                                                           node_count             nodes     /   ��������       ����                                        ����                           ����   	                  
   
   ����                     ���                    conn_count              conns               node_paths              editable_instances              version             RSRC              RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_dvjrh �          PackedScene          	         names "      	   MainMenu    Node2D    Label    offset_right    offset_bottom    text    	   variants             B     �A      LassoKnight       node_count             nodes        ��������       ����                      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC           RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    texture    margins    separation    texture_region_size    use_texture_padding    0:0/0    0:0/0/modulate &   0:0/0/physics_layer_0/linear_velocity '   0:0/0/physics_layer_0/angular_velocity '   0:0/0/physics_layer_0/polygon_0/points    0:0/0/script    script    tile_shape    tile_layout    tile_offset_axis 
   tile_size    uv_clipping     physics_layer_0/collision_layer 
   sources/0    tile_proxies/source_level    tile_proxies/coords_level    tile_proxies/alternative_level 	   _bundled    
   Texture2D    res://icon.svg �rO3t��b   PackedScene "   res://entities/player/player.tscn !&Ъ�D   !   local://TileSetAtlasSource_lnxt6 ~         local://TileSet_l1qvr 5         local://PackedScene_vw3me y         TileSetAtlasSource 	                   -   �   �                                 �?	   
           
             %        ��  ��  �B  ��  �B  �B  ��  �B               TileSet       -   �   �                                  PackedScene          	         names "         test    Node2D    Label    offset_left    offset_top    offset_right    offset_bottom    text    TileMap 	   tile_set    format    layer_0/tile_data    Player 	   position    	   variants    
       �D     C    �"D     9C      TEST                    K                                                                                              	                                                                                                          	          	          	          	          	                              
    ��C  D      node_count             nodes     .   ��������       ����                      ����                                                    ����   	      
                        ���            	             conn_count              conns               node_paths              editable_instances              version             RSRC    GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
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

path="res://.godot/exported/133200997/export-f8b957969db01dd0b3d81f4e4ece5ef6-lasso.scn"
              [remap]

path="res://.godot/exported/133200997/export-48d9922f8b8c50fc9589f06111672b9b-Lasso.scn"
              [remap]

path="res://.godot/exported/133200997/export-21b780c0d4e68e8c35280599c3e67de2-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn"
          [remap]

path="res://.godot/exported/133200997/export-7800922cd0580362ce56304d6150ac04-test.scn"
               list=Array[Dictionary]([])
        , �韴'<   res://assets/lasso/noose.png�����K�|!   res://assets/lasso/rope_links.png�H��>`   res://entities/Lasso/Lasso.tscn!&Ъ�D!   res://entities/player/player.tscn��+��)b   res://levels/main_menu.tscn�ba�w�;   res://levels/test.tscn�rO3t��b   res://icon.svg            ECFG      application/config/name         LassoKnight    application/run/main_scene          res://levels/test.tscn     application/config/features(   "         4.1    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   display/window/stretch/aspect         expand     input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         layer_names/2d_physics/layer_1         ground     layer_names/2d_physics/layer_2         player     layer_names/2d_physics/layer_3         hook   physics/2d/default_gravity        pB9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility  