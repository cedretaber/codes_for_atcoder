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
    int N; long L; get(N, L);
    int[] xs; string[] ds; get_lines(N, xs, ds);

    int[] ls, rs;
    string last;
    long res;
    void calc() {
        if (rs.empty && ls.empty) {
            return;
        } else if (rs.empty) {
            long l = 1;
            foreach (x; ls) {
                res += x - l;
                ++l;
            }
        } else if (ls.empty) {
            long r = L;
            foreach_reverse (x; rs) {
                res += r - x;
                --r;
            }
        } else {
            long l = ls[0], r = rs[$-1];
            res += (l - r - 1) * max(ls.length, rs.length);
            foreach (x; ls) {
                res += x - l;
                ++l;
            }
            foreach_reverse (x; rs) {
                res += r - x;
                --r;
            }
        }
    }
    foreach (i; 0..N) {
        auto x = xs[i];
        auto d = ds[i];

        if (last == "L" && d == "R") {
            calc();
            ls = [];
            rs = [];
        }
        if (d == "L") {
            ls ~= x;
        } else {
            rs ~= x;
        }
        last = d;
    }
    calc();
    writeln(res);
}

/*

1 2 3 4 5 6
  +     +

*/