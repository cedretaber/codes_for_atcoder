import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto ts = readln.split.to!(long[]);
    auto I = ts[0];
    auto O = ts[1];
    auto J = ts[3];
    auto L = ts[4];

    auto K = O + I/2*2 + J/2*2 + L/2*2;
    auto r = I%2 + J%2 + L%2;
    if (r == 3) {
        K += 3;
    } else if (r == 2 && I > 0 && J > 0 && L > 0) {
        K += 1;
    }

    writeln(K);
}

/*

####
####

### #
# ###

1 0 0 1 1 0 0
=> 3

1 0 0 2 2 0 0
=> 4

2 0 0 3 3 0 0
=> 6

1 0 0 3 3 0 0
=> 7

2 0 0 2 2 0 0
=> 6

3 0 0 0 0 0 0
=> 2

1 0 0 1 2 0 0
=>

 #
###

##
 ##

 ##
##

#
###

###
  #


###
#

  #
###

O = 2
I*2 = 4
L*2 = 4
J*2 = 4
I+L+J = 6

#++++@
###@@@

#@@@
###@

###@
#@@@

#++++$$$
###@@@@$



*/