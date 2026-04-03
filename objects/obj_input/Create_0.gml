enum InputState {
	NAN =			1 << 0, 
	PRESSED =		1 << 1,
	HOLD =			1 << 2,
	RELEASED =		1 << 3
}

enum Btn {
	Left =			1 << 0,
	Right =			1 << 1,
	Up =			1 << 2,
	Down =			1 << 3,
	A =				1 << 4,
	B =				1 << 5,
	X =				1 << 6,
	Y =				1 << 7,
	Start =			1 << 8,
	LS =			1 << 9,
	RS =			1 << 10,	
}

bindings = [
	[Btn.Left,		vk_left],
	[Btn.Right,		vk_right],
	[Btn.Up,		vk_up],
	[Btn.Down,		vk_down],
	[Btn.A,			ord("A")],
	[Btn.B,			ord("S")],
	[Btn.X,			ord("D")],
	[Btn.Y,			ord("F")],
	[Btn.Start,		vk_enter],
	[Btn.LS,		ord("Q")],
	[Btn.RS,		ord("E")]
]

input_state = array_create(array_length(bindings), InputState.NAN);

