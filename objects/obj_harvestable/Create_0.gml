enum HType {
	GRASS =			1 << 0,
	BUSH_SMALL =	1 << 1,
	ROCK_SMALL =	1 << 2,
	WOOD_SMALL =	1 << 3,
	BUSH_BIG =		1 << 4,
	ROCK_BIG =		1 << 5,
	WOOD_BIG =		1 << 6
}

enum HState {
	IDLE,
	CARRY,
	DESTROY
}

tile = -1;
type = -1;
state = HState.IDLE;
hp = 1;
init = false;
hitDamage = 0;