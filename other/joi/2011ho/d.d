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
    long W, H; get(W, H);
    int N; get(N);

    if (N == 1) {
        long x, y; get(x, y);
        writefln!"%d\n%d %d"(0, x, y);
        return;
    }

    P[] ps; get_lines(N, ps);
    sort!"a.x < b.x"(ps);
    auto x1 = ps[(N-1)/2].x;
    auto x2 = ps[(N-1)/2 + (N%2 == 0 ? 1 : -1)].x;
    sort!"a.y < b.y"(ps);
    auto y1 = ps[(N-1)/2].y;
    auto y2 = ps[(N-1)/2 + (N%2 == 0 ? 1 : -1)].y;

    long r11, r12, r21, r22;
    foreach (p; ps) {
        r11 += (abs(p.x - x1) + abs(p.y - y1)) * 2;
        r12 += (abs(p.x - x1) + abs(p.y - y2)) * 2;
        r21 += (abs(p.x - x2) + abs(p.y - y1)) * 2;
        r22 += (abs(p.x - x2) + abs(p.y - y2)) * 2;
    }

    long x, y, r_min = long.max;
    foreach (p; ps) {
        foreach (rxy; [[r11, x1, y1], [r12, x1, y2], [r21, x2, y1], [r22, x2, y2]]) {
            auto rr = rxy[0];
            auto xx = rxy[1];
            auto yy = rxy[2];
            auto r = rr - abs(p.x - xx) - abs(p.y - yy);
            if (r < r_min || (r == r_min && (xx < x || (xx == x && yy < y)))) {
                r_min = r;
                x = xx;
                y = yy;
            }
        }
    }

    writefln!"%d\n%d %d"(r_min, x, y);
}

/*

  * +
1 2 3 4

  + *
1 2 3 4 5

*/