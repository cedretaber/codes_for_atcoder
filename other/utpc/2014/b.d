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

void main()
{
    double xr, yr; get(xr, yr);
    auto x = round(xr * 1000).to!long;
    auto y = round(yr * 1000).to!long;

    long mx = 1, my = 1;
    if (x < 0) {
        x = -x;
        mx = -1;
    }
    if (y < 0) {
        y = -y;
        my = -1;
    }

    if (x % 1000 == 0) {
        x /= 1000;
        writefln!"%d %d %d %d"(x * mx, -10_000, x * mx, 10_000);
        if (y % 1000 == 0) {
            writefln!"%d %d %d %d"(-10_000, y / 1000 * my, 10_000, y / 1000 * my);
        } else {
            writefln!"%d %d %d %d"((x - y % 1000) * mx, y / 1000 * my, (x + (1000 - y % 1000)) * mx, (y / 1000 + 1) * my);
        }
    } else if (y % 1000 == 0) {
        y /= 1000;
        writefln!"%d %d %d %d"(x / 1000 * mx, (y - x % 1000) * my, (x / 1000 + 1) * mx, (y + (1000 - x % 1000)) * my);
        writefln!"%d %d %d %d"(-10_000, y * my, 10_000, y * my);
    } else {
        writefln!"%d %d %d %d"(x / 1000 * mx, y / 1000 * my, (x / 1000 + x % 1000) * mx, (y / 1000 + y % 1000) * my);
        writefln!"%d %d %d %d"((x / 1000 + 1) * mx, y / 1000 * my, (x / 1000 + 1 - (1000 - x % 1000)) * mx, (y / 1000 + y % 1000) * my);
    }
}

/*

0.3 0.4
=> (x + 1, y + 1) を右上とする 7 : 6 の長方形の対角線
なので、この 7 : 6 を 1000 倍してやればいい

0.001 0.001
=> 1 - 999, 1 - 999 => -998, -998

*/
