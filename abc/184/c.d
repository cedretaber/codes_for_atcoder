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
    long r1, c1, r2, c2; get(r1, c1); get(r2, c2);
    if (r1 == r2 && c1 == c2) {
        writeln(0);
        return;
    }

    int d = ((r1 + c1) % 2 == (r2 + c2) % 2) || (abs(r1 - r2) + abs(c1 - c2) <= 6) ? 2 : 3;
    static foreach (x; -3..4)
    static foreach (y; -3..4)
    if (abs(x) + abs(y) <= 3) {
        auto r = r1 + x;
        auto c = c1 + y;
        if (r == r2 && c == c2) {
            d = min(d, 1);
        } else if (r + c == r2 + c2 || r - c == r2 - c2) {
            d = min(d, (x == 0 && y == 0) ? 1 : 2);
        }
    }
    writeln(d);
}