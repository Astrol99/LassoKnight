GDPC                `                                                                         X   res://.godot/exported/133200997/export-228b07c0f167c36ab505597bb43d450a-ropesim_demo.scn�~      ,      ��
�Њ�q�l���-�p    T   res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn `k      �      |�uNrHX�h:�waC    T   res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn  �[      �      d|3�u�X9Ӷ�:76z    X   res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn    n      �      &W��;7��&�-R�        res://.godot/extension_list.cfg ��      ,       V���٢:��*�l    ,   res://.godot/global_script_class_cache.cfg  ��      S      4����O�Lw�e���    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�p      �      �Yz=������������       res://.godot/uid_cache.bin  ��      �       8�^V~'ÃU�/       res://addons/ropesim/Rope.gd�      �      k��!\C�^p��A�    $   res://addons/ropesim/RopeAnchor.gd  �,      T      �b���(�-C��;�    4   res://addons/ropesim/RopeCollisionShapeGenerator.gd �3      7	      ��o'��+�����0��    $   res://addons/ropesim/RopeHandle.gd   =      �      6>�I~�,Dn�[���    ,   res://addons/ropesim/RopeRendererLine2D.gd  �E      m      ��k��L]!��     (   res://addons/ropesim/RopeToolHelper.gd  `L            �x�@�����zD\    ,   res://addons/ropesim/libropesim.gdextension         $      ����@� ����        res://addons/ropesim/plugin.gd  0      G      ��d�AK.}�H�5c�    $   res://entities/knight/Camera2D.gd   �T            �"���%��A����FZ�        res://entities/knight/knight.gd  X      �      ����^0�t{PM��    (   res://entities/knight/knight.tscn.remap ��      c       	%�]�K�wıË�L�       res://icon.svg.import   �}      �       ��wFŽ��R�"���        res://levels/level_0.tscn.remap 0�      d       �]LG˻�<�5��7�    $   res://levels/main_menu.tscn.remap   ��      f       ���p��!c����#v�       res://project.binaryЌ      �      `@���X�����~�        res://ropesim_demo.tscn.remap   �      i       W���$z�n+EH�߈_        [configuration]

entry_symbol = "libropesim_init"
compatibility_minimum = "4.2"

[libraries]

macos.debug = "res://addons/ropesim/bin/libropesim.macos.template_debug.framework"
macos.release = "res://addons/ropesim/bin/libropesim.macos.template_release.framework"
windows.debug.x86_32 = "res://addons/ropesim/bin/libropesim.windows.template_debug.x86_32.dll"
windows.release.x86_32 = "res://addons/ropesim/bin/libropesim.windows.template_release.x86_32.dll"
windows.debug.x86_64 = "res://addons/ropesim/bin/libropesim.windows.template_debug.x86_64.dll"
windows.release.x86_64 = "res://addons/ropesim/bin/libropesim.windows.template_release.x86_64.dll"
linux.debug.x86_64 = "res://addons/ropesim/bin/libropesim.linux.template_debug.x86_64.so"
linux.release.x86_64 = "res://addons/ropesim/bin/libropesim.linux.template_release.x86_64.so"
linux.debug.arm64 = "res://addons/ropesim/bin/libropesim.linux.template_debug.arm64.so"
linux.release.arm64 = "res://addons/ropesim/bin/libropesim.linux.template_release.arm64.so"
linux.debug.rv64 = "res://addons/ropesim/bin/libropesim.linux.template_debug.rv64.so"
linux.release.rv64 = "res://addons/ropesim/bin/libropesim.linux.template_release.rv64.so"
android.debug.x86_64 = "res://addons/ropesim/bin/libropesim.android.template_debug.x86_64.so"
android.release.x86_64 = "res://addons/ropesim/bin/libropesim.android.template_release.x86_64.so"
android.debug.arm64 = "res://addons/ropesim/bin/libropesim.android.template_debug.arm64.so"
android.release.arm64 = "res://addons/ropesim/bin/libropesim.android.template_release.arm64.so"
            @tool
extends EditorPlugin

const MENU_INDEX_UPDATE_IN_EDITOR = 0

var _menu_toolbox: HBoxContainer
var _menu_popup: PopupMenu

func _enter_tree() -> void:
    _build_gui()


func _exit_tree() -> void:
    _free_gui()


func _handles(object: Object) -> bool:
    if _menu_toolbox:
        _menu_toolbox.hide()

    return (
        object is Rope or
        object is RopeAnchor or
        object is RopeHandle or
        object is RopeCollisionShapeGenerator or
        object is RopeRendererLine2D
    )


func _edit(_object: Object) -> void:
    _menu_toolbox.show()


func _build_gui() -> void:
    _menu_toolbox = HBoxContainer.new()
    _menu_toolbox.hide()
    add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, _menu_toolbox)

    var menu_button = MenuButton.new()
    menu_button.text = "Ropesim"
    _menu_toolbox.add_child(menu_button)
    _menu_popup = menu_button.get_popup()
    _menu_popup.add_check_item("Preview in Editor")
    _menu_popup.set_item_checked(MENU_INDEX_UPDATE_IN_EDITOR, NativeRopeServer.update_in_editor)
    _menu_popup.connect("id_pressed", self._menu_item_clicked)


func _menu_item_clicked(idx: int) -> void:
    match idx:
        MENU_INDEX_UPDATE_IN_EDITOR:
            var value = not _menu_popup.is_item_checked(idx)
            _menu_popup.set_item_checked(MENU_INDEX_UPDATE_IN_EDITOR, value)
            NativeRopeServer.update_in_editor = value


func _free_gui() -> void:
    remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, _menu_toolbox)
    _menu_toolbox.queue_free()
    _menu_toolbox = null
    _menu_popup = null
         @tool
extends Node2D
class_name Rope

# TODO: Split line rendering into a separate node

signal on_registered()
signal on_unregistered()

@export var pause: bool = false: set = _set_pause
@export var num_segments: int = 10: set = _set_num_segs
@export var rope_length: float = 100: set = _set_length
@export var segment_length_distribution: Curve: set = _set_seg_dist
@export var stiffness: float = 0.0  # Stiffness forces the rope to return to its resting position.
@export var gravity: float = 100  # Gravity
@export var damping: float = 0  # Friction
@export var damping_curve: Curve  # (Optional) Apply different amounts of damping along the rope.
@export var num_constraint_iterations: int = 10  # Constraints the rope to its intended length. Less constraint iterations effectively makes the rope more elastic.

@export var render_debug: bool = false: set = _set_draw_debug
@export var render_line: bool = true: set = _set_render_line
@export var line_width: float = 2: set = _set_line_width
@export var color: Color = Color.WHITE: set = _set_color
@export var color_gradient: Gradient: set = _set_gradient

var _colors := PackedColorArray()
var _seg_lengths := PackedFloat32Array()
var _points := PackedVector2Array()
var _oldpoints := PackedVector2Array()
var _registered: bool = false


# General

func _enter_tree() -> void:
	_setup()

	if Engine.physics_ticks_per_second != 60:
		push_warning("Verlet Integration is FPS dependant -> Only 60 FPS are supported")


func _exit_tree() -> void:
	_unregister_server()


func _on_post_update() -> void:
	if visible:
		queue_redraw()


func _draw() -> void:
	draw_set_transform_matrix(get_global_transform().affine_inverse())

	if render_line and _points.size() > 1:
		_points[0] = global_position
		if color_gradient:
			draw_polyline_colors(_points, _colors, line_width)
		else:
			draw_polyline(_points, color, line_width)

	if render_debug:
		for i in _points.size():
			draw_circle(_points[i], line_width / 2, Color.RED)


# Logic

func _setup(run_reset: bool = true) -> void:
	if not is_inside_tree():
		return

	_points.resize(num_segments + 1)
	_oldpoints.resize(num_segments + 1)
	update_colors()
	update_segments()

	if damping_curve:
		# NOTE: As long as the Curve is not modified during runtime, it should be fine.
		# if not damping_curve.get_local_scene():
		#     push_warning("Damping curve should be local to scene, otherwise it could lead to crashes due to multi-threading when it is change during runtime.")

		# NOTE: We probably shouldn't override user settings, even though it could
		# save some work from the user.
		# if damping_curve.bake_resolution != _points.size():
		#     damping_curve.bake_resolution = _points.size()

		# Force bake() here to prevent possible crashes when the Curve is baked
		# during simulation. Since Resource access is not thread-safe, it will
		# crash when multiple threads try to access or bake the Curve
		# simultaneously.
		damping_curve.bake()

	if run_reset:
		reset()
	_start_stop_process()


func _start_stop_process() -> void:
	if is_inside_tree() and not pause:
		_register_server()
	else:
		_unregister_server()


func _start_stop_rendering() -> void:
	# Re-register (or not) to hook NativeRopeServer.on_post_update() if neccessary.
	_unregister_server()
	_start_stop_process()
	queue_redraw()


func _register_server():
	if not _registered:
		NativeRopeServer.register_rope(self)
		emit_signal("on_registered")
		if render_debug or render_line:
			NativeRopeServer.connect("on_post_update", Callable(self, "_on_post_update"))  # warning-ignore: return_value_discarded
		_registered = true


func _unregister_server():
	if _registered:
		NativeRopeServer.unregister_rope(self)
		emit_signal("on_unregistered")
		if NativeRopeServer.is_connected("on_post_update", Callable(self, "_on_post_update")):
			NativeRopeServer.disconnect("on_post_update", Callable(self, "_on_post_update"))
		_registered = false


# Cache line colors according to color and color_gradient.
# Usually, you should not need to call this manually.
func update_colors():
	if not color_gradient:
		return

	if _colors.size() != _points.size():
		_colors.resize(_points.size())

	for i in _colors.size():
		_colors[i] = color * color_gradient.sample(get_point_perc(i))

	queue_redraw()


# Recompute segment lengths according to rope_length, num_segments and segment_length_distribution curve.
# Usually, you should not need to call this manually.
func update_segments():
	if _seg_lengths.size() != num_segments:
		_seg_lengths.resize(num_segments)

	if segment_length_distribution:
		var length = 0.0

		for i in _seg_lengths.size():
			_seg_lengths[i] = segment_length_distribution.sample(get_point_perc(i + 1))
			length += _seg_lengths[i]

		var scaling = rope_length / length

		for i in _seg_lengths.size():
			_seg_lengths[i] *= scaling
	else:
		var base_seg_length = rope_length / num_segments
		for i in _seg_lengths.size():
			_seg_lengths[i] = base_seg_length



# Access

func get_num_points() -> int:
	return _points.size()


func get_point_index(position_percent: float) -> int:
	return int((get_num_points() - 1) * clamp(position_percent, 0, 1))


func get_point_perc(index: int) -> float:
	return index / float(_points.size() - 1) if _points.size() > 0 else 0.0


func get_point_interpolate(position_perc: float) -> Vector2:
	var idx := get_point_index(position_perc)
	if idx == _points.size() - 1:
		return _points[idx]
	var next := idx + 1
	var next_perc := get_point_perc(next)
	var perc := get_point_perc(idx)
	return lerp(_points[idx], _points[next], (position_perc - perc) / (next_perc - perc))


func get_nearest_point_index(pos: Vector2) -> int:
	var min_dist = 1e10
	var idx = 0

	for i in _points.size():
		var dist = pos.distance_squared_to(_points[i])
		if dist < min_dist:
			min_dist = dist
			idx = i

	return idx

func get_point(index: int) -> Vector2:
	return _points[index]


func set_point(index: int, point: Vector2) -> void:
	_points[index] = point


func move_point(index: int, vec: Vector2) -> void:
	_points[index] += vec


# Makes a copy! PoolVector2Array is pass-by-value.
func get_points() -> PackedVector2Array:
	return _points


# Makes a copy! PoolVector2Array is pass-by-value.
func get_old_points() -> PackedVector2Array:
	return _oldpoints


func get_segment_length(segment_index: int) -> float:
	return _seg_lengths[segment_index]


func reset(dir: Vector2 = Vector2.DOWN) -> void:
	# TODO: Reset in global_transform direction
	_points[0] = (global_position if is_inside_tree() else position)
	for i in range(1, _points.size()):
		_points[i] = _points[i - 1] + dir * get_segment_length(i - 1)
	_oldpoints = _points
	queue_redraw()


func set_points(points: PackedVector2Array) -> void:
	_points = points


func set_old_points(points: PackedVector2Array) -> void:
	_oldpoints = points


func get_color(index: int) -> Color:
	if color_gradient:
		return _colors[index]
	return color


func get_segment_lengths() -> PackedFloat32Array:
	return _seg_lengths


# Setters

func _set_num_segs(value: int):
	num_segments = value
	_setup(false)

func _set_length(value: float):
	rope_length = value
	_setup(false)

func _set_draw_debug(value: bool):
	render_debug = value
	_start_stop_rendering()

func _set_render_line(value: bool):
	render_line = value
	_start_stop_rendering()

func _set_line_width(value: float):
	line_width = value
	queue_redraw()

func _set_color(value: Color):
	color = value
	update_colors()

func _set_pause(value: bool):
	pause = value
	_start_stop_process()

func _set_gradient(value: Gradient):
	if color_gradient:
		color_gradient.disconnect("changed", Callable(self, "update_colors"))
	color_gradient = value
	if color_gradient:
		color_gradient.connect("changed", Callable(self, "update_colors"))  # warning-ignore: return_value_discarded
	update_colors()

func _set_seg_dist(value: Curve):
	if segment_length_distribution:
		segment_length_distribution.disconnect("changed", Callable(self, "update_segments"))
	segment_length_distribution = value
	if segment_length_distribution:
		segment_length_distribution.connect("changed", Callable(self, "update_segments"))  # warning-ignore: return_value_discarded
	update_segments()

    @tool
extends Marker2D
class_name RopeAnchor

# Gets emitted just after applying the position.
signal on_after_update()

@export var force_update: bool: set = _set_force_update
@export var enable: bool = true: get = get_enable, set = set_enable  # Enable or disable.
@export var rope_path: NodePath: set = set_rope_path
@export var rope_position = 1.0  # Position on the rope between 0 and 1. # (float, 0, 1)
@export var apply_angle := false  # Also apply rotation according to the rope curvature.
## If false, only consider the nearest vertex on the rope. Otherwise, interpolate the position between two relevant points when applicable.
@export var precise: bool = false
var _helper: RopeToolHelper


func _init() -> void:
    if not _helper:
        _helper = RopeToolHelper.new(RopeToolHelper.UPDATE_HOOK_POST, self, "_on_post_update")
        add_child(_helper)


func _ready() -> void:
    set_rope_path(rope_path)
    set_enable(enable)


func _on_post_update() -> void:
    _update()
    emit_signal("on_after_update")


func set_rope_path(value: NodePath):
    rope_path = value
    if is_inside_tree():
        _helper.target_rope = get_node(rope_path) as Rope


func set_enable(value: bool):
    enable = value
    _helper.enable = value


func get_enable() -> bool:
    return _helper.enable


func _update() -> void:
    var rope: Rope = _helper.target_rope

    if precise:
        global_position = rope.get_point_interpolate(rope_position)
    else:
        global_position = rope.get_point(rope.get_point_index(rope_position))

    if apply_angle:
        var a := rope.get_point(rope.get_point_index(rope_position - 0.1))
        var b := rope.get_point(rope.get_point_index(rope_position + 0.1))
        global_rotation = (b - a).angle()


func _set_force_update(_val: bool) -> void:
    if Engine.is_editor_hint() and _helper.target_rope:
        _update()
            @tool
extends Node
class_name RopeCollisionShapeGenerator

# Populates the parent with CollisionShape2Ds with a SegmentShape2D to fit the target rope.
# It can be added as child to an Area2D for example, to detect if something collides with the rope.
# It does _not_ make the rope interact with other physics objects.

@export var enable: bool = true: get = get_enable, set = set_enable  # Enable or disable.
@export var rope_path: NodePath: set = set_rope_path

var _helper: RopeToolHelper
var _colliders := []  # Array[CollisionShape2D]


func _init() -> void:
    if not _helper:
        _helper = RopeToolHelper.new(RopeToolHelper.UPDATE_HOOK_POST, self, "_on_post_update")
        add_child(_helper)


func _ready() -> void:
    if not get_parent() is CollisionObject2D:
        push_warning("Parent is not a CollisionObject2D")
    set_rope_path(rope_path)
    set_enable(enable)


func _on_post_update() -> void:
    if _needs_rebuild():
        _build()
    _update_shapes()


func set_rope_path(value: NodePath):
    rope_path = value
    if is_inside_tree():
        _helper.target_rope = get_node(rope_path) as Rope
        _build()


func set_enable(value: bool):
    enable = value
    _helper.enable = value


func get_enable() -> bool:
    return _helper.enable


func _needs_rebuild() -> bool:
    var rope: Rope = _helper.target_rope
    return rope and rope.num_segments != _colliders.size()


func _build() -> void:
    var rope: Rope = _helper.target_rope

    if rope:
        _enable_shapes(rope.num_segments)
    else:
        _enable_shapes(0)


func _enable_shapes(num: int) -> void:
    var diff = num - _colliders.size()

    if diff > 0:
        for i in diff:
            var shape := CollisionShape2D.new()
            shape.shape = SegmentShape2D.new()
            _colliders.append(shape)
            get_parent().call_deferred("add_child", shape)
    elif diff < 0:
        for i in abs(diff):
            _colliders.pop_back().queue_free()


func _update_shapes() -> void:
    var points = _helper.target_rope.get_points()

    for i in _colliders.size():
        var shape: CollisionShape2D = _colliders[i]
        shape.global_transform = Transform2D(0, Vector2.ZERO)  # set_as_top_level() is buggy with collision shapes
        var seg: SegmentShape2D = shape.shape
        seg.a = points[i]
        seg.b = points[i + 1]
         @tool
extends Marker2D
class_name RopeHandle

# Gets emitted just before applying the position.
signal on_before_update()

@export var enable: bool = true: get = get_enable, set = set_enable  # Enable or disable
@export var rope_path: NodePath: set = set_rope_path
@export var rope_position = 1.0  # Position on the rope between 0 and 1. # (float, 0, 1)
@export var smoothing: bool = false  # Whether to smoothly snap to RopeHandle's position instead of instantly.
@export var position_smoothing_speed: float = 0.5  # Smoothing speed
## If false, only affect the nearest vertex on the rope. Otherwise, affect both surrounding points when applicable.
@export var precise: bool = false
var _helper: RopeToolHelper

func _init() -> void:
	if not _helper:
		_helper = RopeToolHelper.new(RopeToolHelper.UPDATE_HOOK_PRE, self, "_on_pre_update")
		add_child(_helper)


func _ready() -> void:
	set_rope_path(rope_path)
	set_enable(enable)


func _on_pre_update() -> void:
	emit_signal("on_before_update")
	var rope: Rope = _helper.target_rope
	var point_index: int = rope.get_point_index(rope_position)

	# Only use this method if this is not the last point.
	if precise and point_index < rope.get_num_points() - 1:
		# TODO: Consider creating a corresponding function in Rope.gd for universal access, e.g. set_point_interpolated().
		var point_pos: Vector2 = rope.get_point_interpolate(rope_position)
		var diff := global_position - point_pos
		var pos_a: Vector2 = rope.get_point(point_index)
		var pos_b: Vector2 = rope.get_point(point_index + 1)
		var new_pos_a: Vector2 = pos_a + diff
		var new_pos_b: Vector2 = pos_b + diff

		_move_point(point_index, pos_a, new_pos_a)
		_move_point(point_index + 1, pos_b, new_pos_b)
	else:
		_move_point(point_index, rope.get_point(point_index), global_position)


func _move_point(idx: int, from: Vector2, to: Vector2) -> void:
	if smoothing:
		to = from.lerp(to, get_physics_process_delta_time() * position_smoothing_speed)
	_helper.target_rope.set_point(idx, to)


func set_rope_path(value: NodePath):
	rope_path = value
	if is_inside_tree():
		_helper.target_rope = get_node(rope_path) as Rope


func set_enable(value: bool):
	enable = value
	_helper.enable = value

func get_enable() -> bool:
	return _helper.enable
 @tool
extends Line2D
class_name RopeRendererLine2D

const UPDATE_HOOK = "on_post_update"
const HOOK_FUNC = "refresh"

@export var force_update: bool: set = _force_update
@export var target_rope_path: NodePath = "..": set = set_rope_path
@export var keep_rope_position: bool = true: set = _set_keep_pos
@export var auto_update: bool = true: get = get_auto_update, set = set_auto_update
@export var invert: bool = false
var _helper: RopeToolHelper


func _init() -> void:
	if not _helper:
		_helper = RopeToolHelper.new(RopeToolHelper.UPDATE_HOOK_POST, self, "refresh")
		add_child(_helper)


func _ready() -> void:
	set_rope_path(target_rope_path)
	set_auto_update(auto_update)
	refresh()


func refresh() -> void:
	var target: Rope = _helper.target_rope

	if target and target.get_num_points() > 0 and visible:
		var xform: Transform2D

		if keep_rope_position:
			if Engine.is_editor_hint():
				xform = Transform2D(0, -global_position - target.get_point(0) + target.global_position)
			else:
				xform = Transform2D(0, -global_position)
		else:
			xform = Transform2D(0, -target.get_point(0))

		xform = xform.scaled(scale)
		var p: PackedVector2Array = xform * target.get_points()

		if invert:
			p.reverse()

		points = p
		global_rotation = 0


func set_rope_path(value: NodePath):
	target_rope_path = value
	if is_inside_tree():
		_helper.target_rope = get_node(target_rope_path) as Rope
		refresh()


func _force_update(_value: bool):
	refresh()


func _set_keep_pos(value: bool):
	keep_rope_position = value
	refresh()


func set_auto_update(value: bool):
	_helper.enable = value

func get_auto_update() -> bool:
	return _helper.enable
   extends Node
class_name RopeToolHelper

# This node should be used programmatically as helper in other rope tools.
# It contains boilerplate for registering/unregistering to/from NativeRopeServer when needed.

const UPDATE_HOOK_POST = "on_post_update"
const UPDATE_HOOK_PRE = "on_pre_update"

@export var enable: bool = true: set = set_enable
var target_rope: Rope: set = set_target_rope

var _update_hook: String
var _target_method: String
var _target: Object


func _init(update_hook: String, target: Object, target_method: String) -> void:
	_update_hook = update_hook
	_target = target
	_target_method = target_method


func _enter_tree() -> void:
	start_stop_process()


func _exit_tree() -> void:
	_unregister_server()


func _unregister_server() -> void:
	if _is_registered():
		NativeRopeServer.disconnect(_update_hook, Callable(self, "_on_update"))


func _is_registered() -> bool:
	return NativeRopeServer.is_connected(_update_hook, Callable(self, "_on_update"))


func _on_update() -> void:
	if not target_rope.pause:
		_target.call(_target_method)


# Start or stop the process depending on internal variables.
func start_stop_process() -> void:
	# NOTE: It sounds smart to disable this helper if the rope is paused, but maybe there are exceptions.
	if enable and is_inside_tree() and target_rope and not target_rope.pause:
		if not _is_registered():
			NativeRopeServer.connect(_update_hook, Callable(self, "_on_update"))
	else:
		_unregister_server()


func set_enable(value: bool) -> void:
	enable = value
	start_stop_process()


func set_target_rope(value: Rope) -> void:
	if value == target_rope:
		return

	if target_rope and is_instance_valid(target_rope):
		target_rope.disconnect("on_registered", Callable(self, "start_stop_process"))
		target_rope.disconnect("on_unregistered", Callable(self, "start_stop_process"))

	target_rope = value

	if target_rope and is_instance_valid(target_rope):
		target_rope.connect("on_registered", Callable(self, "start_stop_process"))  # warning-ignore: return_value_discarded
		target_rope.connect("on_unregistered", Callable(self, "start_stop_process"))  # warning-ignore: return_value_discarded

	start_stop_process()
 extends Camera2D

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

@export var move_speed : float = 150.0
@export var lasso_speed : float = 1.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var rope = $Rope
@onready var rope_handle = $RopeHandle
@onready var lasso = $Lasso
@onready var lasso_path = $Lasso/Path2D/PathFollow2D

var lassoed = false

func _physics_process(delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if Input.is_action_just_pressed("m1") and not lassoed:
		lasso.look_at(get_global_mouse_position())
		lassoed = true
	
	if lassoed:
		lasso_path.progress_ratio += lasso_speed * delta
		if lasso_path.progress_ratio == 1:
			lasso_path.progress_ratio = 0
			lassoed = false
	
	velocity = input_direction * move_speed
	
	move_and_slide()
         RSRC                    PackedScene            ��������                                            ,      ..    AnimationPlayer    Rope    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    _data    auto_triangles 
   min_space 
   max_space    snap    x_label    y_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/Idle/node    states/Idle/position    states/Start/node    states/Start/position    states/Walk/node    states/Walk/position    transitions    graph_offset    bake_interval    point_count 	   _bundled       Script     res://entities/knight/knight.gd ��������
   Texture2D    res://icon.svg �rO3t��b   Script "   res://entities/knight/Camera2D.gd ��������   Script    res://addons/ropesim/Rope.gd ��������   Script #   res://addons/ropesim/RopeHandle.gd ��������
      local://RectangleShape2D_vcw2b 5         local://Animation_8qprx f         local://AnimationLibrary_a50b0 �      (   local://AnimationNodeBlendSpace2D_va5ow �      (   local://AnimationNodeBlendSpace2D_8tqgi 3      2   local://AnimationNodeStateMachineTransition_qojdq ]      2   local://AnimationNodeStateMachineTransition_1x020 �      (   local://AnimationNodeStateMachine_yrndm �         local://Curve2D_yi1ej �         local://PackedScene_0r6s2 �	         RectangleShape2D       
      B   B      
   Animation             idle_up          AnimationLibrary                   idle_up                   AnimationNodeBlendSpace2D       
     ���̌�   
     �?�̌?                  AnimationNodeBlendSpace2D          $   AnimationNodeStateMachineTransition          $   AnimationNodeStateMachineTransition                       AnimationNodeStateMachine 
         !            "   
    ��C  �B#      $   
     /C  �B%            &   
     �C  �B'               Start       Idle                Idle       Walk          (   
     ��  ��         Curve2D                   points %                                2�      2B      |B  O�                  %CqU���<�BŬ�>�<��Ŭ��  |B�j�B                        *                  PackedScene    +      	         names "   "      Knight    script    CharacterBody2D 	   Sprite2D    scale    texture    CollisionShape2D    shape    AnimationPlayer 
   libraries    AnimationTree 
   tree_root    anim_player    parameters/Idle/blend_position    parameters/Walk/blend_position 	   Camera2D    process_callback    position_smoothing_enabled    Lasso    Node2D    Rope    gravity    line_width    color    Path2D    curve    PathFollow2D 	   rotation    rotates    loop    RopeHandle    enable 
   rope_path 	   Marker2D    	   variants                 
     �>  �>                                                               
   `��7M��
                                                A     �?   ��$?���>���>  �?
     �?���?            �I@                                           node_count             nodes     }   ��������       ����                            ����                                 ����                           ����   	                  
   
   ����                                             ����      	      
                           ����                     ����                                            ����                                ����                         	       !      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene "   res://entities/knight/knight.tscn �}�J��%l      local://PackedScene_sgsa8          PackedScene          	         names "         Level0    Node2D    Knight 	   position    	   variants                 
     _C  �B      node_count             nodes        ��������       ����                ���                          conn_count              conns               node_paths              editable_instances              version             RSRC         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_s6gbr �          PackedScene          	         names "      	   MainMenu    Node2D    Label    offset_right    offset_bottom    text    	   variants             B     �A      LassoKnight       node_count             nodes        ��������       ����                      ����                                conn_count              conns               node_paths              editable_instances              version             RSRC           GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
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
                RSRC                    PackedScene            ��������                                                  ..    Rope    resource_local_to_scene    resource_name 	   _bundled    script       Script #   res://addons/ropesim/RopeHandle.gd ��������   Script #   res://addons/ropesim/RopeAnchor.gd ��������
   Texture2D    res://icon.svg �rO3t��b   Script    res://addons/ropesim/Rope.gd ��������   Script +   res://addons/ropesim/RopeRendererLine2D.gd ��������      local://PackedScene_cc4hr          PackedScene          	         names "         main    Node2D    RopeHandle 	   position    script    enable 
   rope_path    rope_position 	   Marker2D    RopeAnchor    Icon    scale    texture 	   Sprite2D    RopeAnchor2    Rope    texture_repeat    num_segments    rope_length    damping    render_line    metadata/_edit_group_    RopeRendererLine2D    show_behind_parent    points    texture_mode    auto_update    Line2D    	   variants       
      A  �B                              )   ףp=
��?
   �ѕ�5^�B              �>
          B
      ?   ?         
   �N���6C      
     ��  �B                    HC      A      %              �A(a�@H��A��0Aa2�A2�sA��#B>h�A)\PBx�A�z}B�h�Ah�B{�AnT�B�uA���B�*8Aݤ�Bڬ�@L7�B��(@ @�Be@m��B��AAw��BV�A��B��B��Bb-BJL�BO�VB���B��Bs��B��B`%�B5��B                     node_count             nodes     |   ��������       ����                      ����                                                 	   ����                                               
   ����            	      
                     ����                                         
   ����            	      
                     ����                                                                    ����                  
                               conn_count              conns               node_paths              editable_instances              version             RSRC    [remap]

path="res://.godot/exported/133200997/export-7ec4f56097d651596b126122d79c30eb-knight.scn"
             [remap]

path="res://.godot/exported/133200997/export-6dc351d0aa33c8c9359ec60a0d0cff40-level_0.scn"
            [remap]

path="res://.godot/exported/133200997/export-d4e83b31417540e021f1ffd2ec82c3cc-main_menu.scn"
          [remap]

path="res://.godot/exported/133200997/export-228b07c0f167c36ab505597bb43d450a-ropesim_demo.scn"
       list=Array[Dictionary]([{
"base": &"Node2D",
"class": &"Rope",
"icon": "",
"language": &"GDScript",
"path": "res://addons/ropesim/Rope.gd"
}, {
"base": &"Marker2D",
"class": &"RopeAnchor",
"icon": "",
"language": &"GDScript",
"path": "res://addons/ropesim/RopeAnchor.gd"
}, {
"base": &"Node",
"class": &"RopeCollisionShapeGenerator",
"icon": "",
"language": &"GDScript",
"path": "res://addons/ropesim/RopeCollisionShapeGenerator.gd"
}, {
"base": &"Marker2D",
"class": &"RopeHandle",
"icon": "",
"language": &"GDScript",
"path": "res://addons/ropesim/RopeHandle.gd"
}, {
"base": &"Line2D",
"class": &"RopeRendererLine2D",
"icon": "",
"language": &"GDScript",
"path": "res://addons/ropesim/RopeRendererLine2D.gd"
}, {
"base": &"Node",
"class": &"RopeToolHelper",
"icon": "",
"language": &"GDScript",
"path": "res://addons/ropesim/RopeToolHelper.gd"
}])
                �}�J��%l!   res://entities/knight/knight.tscn�yG= 8�   res://levels/level_0.tscn��+��)b   res://levels/main_menu.tscn�rO3t��b   res://icon.svg��mK۰�n   res://ropesim_demo.tscn      res://addons/ropesim/libropesim.gdextension
    ECFG      application/config/name         LassoKnight    application/run/main_scene$         res://levels/main_menu.tscn    application/config/features(   "         4.1    GL Compatibility    "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   display/window/stretch/scale         @   editor_plugins/enabled8   "      *   res://addons/coi_serviceworker/plugin.cfg      input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/m1�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     C  �A   global_position      C  �B   factor       �?   button_index         canceled          pressed          double_click          script         layer_names/2d_physics/layer_1         ground     layer_names/2d_physics/layer_2         player     layer_names/2d_physics/layer_3         hook   physics/2d/default_gravity        pB9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility         