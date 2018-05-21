# Mario like
Try to make a mario like game in Ruby. I am using the following gems :
* Gosu : To make the game
* byebug : Debugging
* rubocop : Correction

## To-do list
* Check ice effect
* check movement axe x 
* Check collision bottom (after jump)
* Do collision diagonal bot-left & bot-right

## My help
I used the following links to create this game :

### For the x movements :
* https://github.com/gosu/gosu/wiki/Ruby-Tutorial

### For the jump :
* https://stackoverflow.com/questions/41913771/how-can-i-jump-on-gosu-gem-from-ruby

#### Jump modification :
The main philosophy is following this code, but I changed a lot of things :
* Gravity effect when the character is falling
* I used the Gosu.offset for the velocity
* I blocked the space button, then we can jump only when the character is on the ground

#### How the jump is working :
The jump has 4 variables :
* @y_speed : The speed of the jump, this influence also the jump max height
* @jump_delta : The difference between each frames for the jump
* @jump_allow : The authorization if the player can jump
* @jump_height_max : The max height of the jump

We have 6 methods for the jump :
* jump_initialization
* jump_heigh_variation
* jump_go_up
* jump_go_down
* check_jump
* jump_height_max
* jump_allow_check

##### jump_initialization

This is the initialization of the jump. We need to add the following parameters :
```
@jump_delta = @jump_height_max => The jump_delta is our incrementation
@jump_allow = false => The player can't jump if he is already jumping
@vel_y = jump_velocity_max(@jump_delta) => We are calculating the max velocity
@down_y = @jump_height_max * -1 => This is our incrementation when falling
```

##### jump_height_variation : 

The main method, it's calling the method depending of if the player is going up or down and we check if the player is allow to jump. Depending of the variable @jump_delta :
```
if @jump_delta > 0 => We call jump_go_up, the player is jumping
```
```
if @jump_delta < 0 => We call jump_go_down, the player is falling
```

##### jump_go_up & jump_go_down

Those methods are working on the same way. When the player begin to jump, the velocity is maximum and then decrease at each iteration. In the same way, when the player is falling, the velocity is minimum at the begining and then increasing.

#### check_jump

We are checking if the jump is allowed and if the ascending or descending action is finished.
* Ascending : When the incrementation is 0, we reset the velocity and set our new @jump_delta for the descending.
* Descending : When the incrementation is -1, we reset the velocity and allow the action of jump because the jump is finish.

#### jump_velocity_max

This method is used to calculate the max velocity we need at the beginning of the jump (for the ascending part). We are incrementing as the jump_go_up and down methods.

#### jump_allow_check

Here it's the method to get the information from other part of the codes about if the jump is allowed or not.

### For the camera which following the character :
* https://stackoverflow.com/questions/32741782/looping-background-image-in-ruby-side-scrolling-game

The methode I used is very different, but it's a good example to understand how to do the background scrolling.

## class Map
### Overview

This class manages the background and the tilesets. We parse a JSON file to get the tileset. The mapping for tileset use a matrix to add each elements where it has to be.

### Initialize

* We get the tile image 
* We get the tile matrix from the JSON, we get the data in a array
* We get the background image, there is no collision between the element of the background and the character

### draw

We loop into the tile array to get every element we have to add in the map. The loop write every column of a row, when it's done it switchs into the next row.

### Scrolling

...

## Character

The character's coordinates are in the middle of image.