# Code Challenge - Toy Robot

This is a code challenge simulating a toy robot operated through commands on a
file. The robot walks on a surface of 5x5 units and it ignores any command that
could make it fall from the table.

## Bootstrap

This application was developed on Ubuntu 14.04 x64

> Install >= Ruby 2.2 - Installation instructions [here](https://www.ruby-lang.org) or you can use [RVM](https://rvm.io/)
> Run `bundle install`

## Usage

The file `app/main.rb` is the entry point for the app and it takes a file as a
param. There's a sample file in the `fixtures` folder.

You can se an usage example running `ruby app/main.rb fixtures/commands.txt`
from the root of the project.

### Commands

The robot obeys to a limited set of commands and it reads one at a time from the
file. Allowed commands are:

> **PLACE** - Places the robot on the specified coordinate on the table. The
format is `PLACE X,Y,F`, *X* and *Y* being coordinates ranging from 0 to 5 and 
F the direction the robot is facing (NORTH, SOUTH, EAST or WEST in uppercase).
If the robot is placed on an invalid coordinate, the command is ignored. All the
other commands except for *REPORT* are ignored until the robot is placed on a 
valid location on the table.

> **MOVE** - Moves the robot one unit in the direction it is facing. If the
movement would make the robot fall from the table, the command is ignored. 

> **LEFT** and **RIGHT** - Turn the robot 90 degrees in the direction specified.

> **REPORT** - Returns the current position and orientation of the robot.

## Testing

To run the tests, simply run `rspec` from the root of the project. 

When developing you might want to use guard to keep a live flow of tests running 
as you change code. Just run `guard` from the root folder.

The project is also using [SimpleCov](https://github.com/colszowka/simplecov)
for code coverage. After running the tests, a `coverage/` folder will be created
on the root of the project with the report in it.

## Design

I tried to keep the classes as losely coupled as I could. On the current status,
Robot does not know about Table or CommandParsers. It just knows how to move and
do its thing. Table as well. Even CommandParser just know who to call to execute
a command.

### app/main.rb

The application reads lines from a specified file and feeds a command parser
which is initialized with a `Table` and `Robot` instances. The default command
parser is the `SafeTripCommandParser` that uses commands that check cases where
the robot can fall from the table.

This class invokes several others that implement the [Command
Pattern](https://en.wikipedia.org/wiki/Command_pattern) in order to keep it from
knowing too much about the robot api. It only knows about some patterns and
which command class deals with each one.

### app/table.rb

The `Table` class just holds attributes for its size and can tell if a given
coordinate is within its boundaries with the `Table#over_the_edge?` method.

### app/robot.rb

The `Robot` has methods for turning, moving, and reporting and being placed on a
coordinate somewhere. It also has an utility method `Robot#calculate_movement` 
which gives the coordinates of the robot after the next move without altering 
its state.

### app/commands/*_command.rb

Each class implements the Command interface as stated above. They receive an
instance of `Robot` and `Table` and the command being executed on the
`*Command#execute` call.

## License

The MIT License (MIT)

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contributing

> Fork it
> Make it fly
> Pull Request Me
