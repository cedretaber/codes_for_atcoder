import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

alias P = Tuple!(long, "x", long, "y");

void main()
{
    int T; get(T);
    while (T--) {
        long ax, ay, bx, by, cx, cy; get(ax, ay, bx, by, cx, cy);

        auto p = P(ax == bx || ax == bx ? ax : bx, ay == by || ay == cy ? ay : by);
        auto ux = max(ax, bx, cx);
        auto lx = min(ax, bx, cx);
        auto uy = max(ay, by, cy);
        auto ly = min(ay, by, cy);

        auto a = P(ax, ay);
        auto b = P(bx, by);
        auto c = P(cx, cy);

        long r, x, y;
        if (lx >= 0 && ly >= 0) {
            r += 1;
            x = lx;
            y = ly;
            p = P(lx, ly);
        } else if (lx >= 0) {
            r += 2;
            x = lx;
            y = -uy;
            p = P(lx, uy);
        } else if (ly >= 0) {
            r += 2;
            x = -ux;
            y = ly;
            p = P(ux, ly);
        } else {
            r += 3;
            x = -ux;
            y = -uy;
            p = P(ux, uy);
        }
        if (x >= y) {
            r += (y - 1) * 3;
            x -= y;
            r += (x - 1) * 2;
        } else {
            r += (x - 1) * 3;
            y -= x;
            r += (y - 1) * 2;
        }
        r += 3;
        if (a != p && b != p && c != p) r += 1;
        writeln(r);
    }
}


/*


....
..++
#.+.
##..

....
..++
.#+.
##..

....
..++
.##.
.#..

....
..#+
.##.
....

....
..##
..#.
....

..6.
..45
123.
11..

---

.+..
.++.
....
1...
11..

.7..
.65.
.34.
12..
11..



  56
 34
12
11


12468
113579

9
78
56
34
12
11


#      #    #
## -> ## -> ##

  68
 357
124
11

  78
 456
123
11

#
##

 #
##

##
#

##
 #

1
11
 23
  45
   67


   7
  56
 34
12
11

7
65
 43
  21
   11

   1
  211
 43
65
7

*/