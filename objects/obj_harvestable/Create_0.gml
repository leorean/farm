enum HarvestableType {
	GRASS,
	BUSH_SMALL,
	ROCK_SMALL,
	WOOD_SMALL,
	BUSH_BIG,
	ROCK_BIG,
	WOOD_BIG
}

enum HarvestableState {
	IDLE,
	CARRY,
	DESTROY
}

tile = -1;
type = -1;
state = HarvestableState.IDLE;