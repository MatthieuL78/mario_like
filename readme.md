# Mario like
Try to make a mario like game in Ruby. I am using the following gems :
* Gosu : For making the game
* byebug : For debugging

## To-do list
* Collision of the character

## My help
I used the following links to create this game :

### For the x movements :
* https://github.com/gosu/gosu/wiki/Ruby-Tutorial

### For the jump :
* https://stackoverflow.com/questions/41913771/how-can-i-jump-on-gosu-gem-from-ruby

The main philosophy is following this code, but I changed a lot of things :
* Gravity effect when the character is falling
* I used the Gosu.offset for the velocity
* I blocked the space button, then we can jump only when the character is on the ground

### For the camera which following the character :
* https://stackoverflow.com/questions/32741782/looping-background-image-in-ruby-side-scrolling-game

The methode I used is very different, but it's a good example to understand how to do the background scrolling.

