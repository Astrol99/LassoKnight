GDPC                P                                                                         T   res://.godot/exported/133200997/export-1379ea380d03dac7714a34775bb82206-chain.scn           $      �,L|���},kנP�"    T   res://.godot/exported/133200997/export-21b780c0d4e68e8c35280599c3e67de2-player.scn  �      �      /N����
��بh��    P   res://.godot/exported/133200997/export-7800922cd0580362ce56304d6150ac04-test.scn`      �      �;/�?kd�Ņ�ّ�    X   res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn   �      �      `	ҙ������S�t6oq    ,   res://.godot/global_script_class_cache.cfg  �&             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex       �      �Yz=������������       res://.godot/uid_cache.bin  �&      �       �Q�{:qU~�ga�G ��    (   res://entities/chain/chain.tscn.remap   �$      b       ]4;"n��c�(�_|K        res://entities/player/player.gd 0      �      ���+�H �GI��Յ�    (   res://entities/player/player.tscn.remap @%      c       MR`�櫗�.�	��w       res://icon.svg.import    $      �       ��wFŽ��R�"���    $   res://levels/main_menu.tscn.remap   �%      f       ���p��!c����#v�       res://levels/test.tscn.remap &      a       �l�}B���7����}+       res://project.binaryp'      	      J	���%�6�� y��    �&�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_xinqj �          PackedScene          	         names "         Chain    Node2D    	   variants              node_count             nodes        ��������       ����              conn_count              conns               node_paths              editable_instances              version             RSRC�V��w20�{���extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const SPEED = 300.0
const MAX_SPEED = 2000
const JUMP_VELOCITY = -400.0
const FRICTION_AIR = 0.95
const FRICTION_GROUND = 0.85
const CHAIN_PULL = 105

var chain_velocity := Vector2(0,0)
var can_jump = false

"""
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			$Chain.shoot(event.position - get_viewport().size * 0.5)
		else:
			$Chain.release()
"""

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Walk
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	"""
	# Hook physics
	if $Chain.hooked:
		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			# Pulling down weaker
			chain_velocity.y *= 0.55
		else:
			# Pulling up stronger
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(velocity.x):
			# If walking diff direction than chain pull, reduce pull
			chain_velocity.x *= 0.7
	else:
		# No chain velocity if not hooked
		chain_velocity = Vector2(0,0)
	
	# Apply chain velocity
	velocity += chain_velocity
	"""
	move_and_slide()
	
	# Friction on ground
	if is_on_floor():
		velocity.x *= FRICTION_GROUND
		if velocity.y >= 5:velocity.y = 5
	elif is_on_ceiling() and velocity.y <= -5:
		velocity.y = -5

	# Friciton on Air
	if not is_on_floor():
		velocity.x *= FRICTION_AIR
		if velocity.y > 0:
			velocity.y *= FRICTION_AIR
H�b���T�+>'�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script     res://entities/player/player.gd ��������
   Texture2D    res://icon.svg �rO3t��b      local://RectangleShape2D_6r81l �         local://PackedScene_ir678 �         RectangleShape2D       
     �B  �B         PackedScene          	         names "   	      Player    scale    script    CharacterBody2D    Icon    texture 	   Sprite2D    CollisionShape2D    shape    	   variants       
      ?   ?                                   node_count             nodes        ��������       ����                                  ����                           ����                   conn_count              conns               node_paths              editable_instances              version             RSRC��MD&URSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_74qfg �          PackedScene          	         names "      	   MainMenu    Node2D    Label    offset_right    offset_bottom    text    	   variants             B     �A      TEST       node_count             nodes        ��������       ����                      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC~�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    texture    margins    separation    texture_region_size    use_texture_padding    0:0/0    0:0/0/modulate &   0:0/0/physics_layer_0/linear_velocity '   0:0/0/physics_layer_0/angular_velocity '   0:0/0/physics_layer_0/polygon_0/points    0:0/0/script    script    tile_shape    tile_layout    tile_offset_axis 
   tile_size    uv_clipping     physics_layer_0/collision_layer 
   sources/0    tile_proxies/source_level    tile_proxies/coords_level    tile_proxies/alternative_level 	   _bundled    
   Texture2D    res://icon.svg �rO3t��b   PackedScene "   res://entities/player/player.tscn !&Ъ�D   !   local://TileSetAtlasSource_lnxt6 ~         local://TileSet_l1qvr 5         local://PackedScene_248p1 y         TileSetAtlasSource 	                   -   �   �                                 �?	   
           
             %        ��  ��  �B  ��  �B  �B  ��  �B               TileSet       -   �   �                                  PackedScene          	         names "         test    Node2D    TileMap 	   tile_set    format    layer_0/tile_data    Player 	   position    	   variants                          H                                                                                              	                                                                                                          	          	          	          	          	                    
    ��C �D      node_count             nodes        ��������       ����                      ����                                  ���                         conn_count              conns               node_paths              editable_instances              version             RSRC��S���GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[  ߟ��y[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c8n7jy45rivst"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 R�!���$�u����[remap]

path="res://.godot/exported/133200997/export-1379ea380d03dac7714a34775bb82206-chain.scn"
1'���?��P)��[remap]

path="res://.godot/exported/133200997/export-21b780c0d4e68e8c35280599c3e67de2-player.scn"
������9�[remap]

path="res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn"
G��`CH��[remap]

path="res://.godot/exported/133200997/export-7800922cd0580362ce56304d6150ac04-test.scn"
�
(�� λ�m�A2ylist=Array[Dictionary]([])
t���   _7�/<��[   res://entities/chain/chain.tscn!&Ъ�D!   res://entities/player/player.tscn��+��)b   res://levels/main_menu.tscn�ba�w�;   res://levels/test.tscn�rO3t��b   res://icon.svgpECFG      application/config/name         LassoKnight    application/run/main_scene$         res://levels/main_menu.tscn    application/config/features(   "         4.1    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility�9�