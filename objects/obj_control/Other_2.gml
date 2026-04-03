#macro V_WIDTH 256
#macro V_HEIGHT 192
#macro V_ZOOM 5

#macro NONE 0
#macro LEFT -1
#macro RIGHT 1
#macro UP -2
#macro DOWN 2

#macro L_UI			0400 // mouse, menus, etc.
#macro L_HUD		0500 // any in-game display
#macro L_EFFECTS	1000
#macro L_PROJECTILE	2000
#macro L_OBJ		3000
#macro L_PLAYER		4000
#macro L_ENEMY		3000
#macro L_BACKGROUND 8000

// tile map
#macro L_FG			3000
#macro L_BG			4000
#macro T			   8

#macro XVIEW camera_get_view_x(view_camera[0])
#macro YVIEW camera_get_view_y(view_camera[0])
#macro WVIEW camera_get_view_width(view_camera[0])
#macro HVIEW camera_get_view_height(view_camera[0])

//#macro cc_green			#6ac81f
//#macro cc_lightgreen	#c1f567
//#macro cc_red			#f82542
//#macro cc_yellow		#ffdc04
//#macro cc_orange		#ffc200
//#macro cc_blue			#398dd5
//#macro cc_darkblue		#3056ac

global.debug = true;