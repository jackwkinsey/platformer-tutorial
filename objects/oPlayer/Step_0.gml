/// @description Update player

leftInput = keyboard_check(vk_left) || keyboard_check(ord("A"));
rightInput = keyboard_check(vk_right) || keyboard_check(ord("D"));
jumpInput = keyboard_check_pressed(vk_space);

var xDir = rightInput - leftInput;
xSpeed = xDir * walkSpeed;

ySpeed += gravityValue;

if (ySpeed > terminalVelocity) {
	ySpeed = terminalVelocity;
}

if (place_meeting(x, y + 1, oWall)) {
	grounded = true;
	timesJumped = 0;
}

if ((grounded || timesJumped < 2) && jumpInput) {
	ySpeed = jumpSpeed + (timesJumped * 1.5);
	timesJumped++;
	show_debug_message("jumps: " + string(timesJumped));
	grounded = false;
}

if (place_meeting(x + xSpeed, y, oWall)) {
	var xDelta = abs(xSpeed) > 1 ? sign(xSpeed) : xSpeed;
	while(!place_meeting(x + sign(xSpeed), y, oWall)) {
		x += xDelta;
	}
	
	xSpeed = 0;
}
x += xSpeed;

if (place_meeting(x, y + ySpeed, oWall)) {
	var yDelta = abs(ySpeed) > 1 ? sign(ySpeed) : ySpeed;
	while(!place_meeting(x, y + yDelta, oWall)) {
		y += yDelta;
	}
	
	ySpeed = 0;
}
y += ySpeed;