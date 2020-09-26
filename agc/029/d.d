import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

alias P = Tuple!(int, "x", int, "y");

void main()
{
    int H, W, N; get(W, H, N);
    P[] ps; get_lines(N, ps);
    sort!"a.x < b.x"(ps);
    auto MAP = new int[][H];
    foreach (p; ps) {
        MAP[p.y-1] ~= p.x-1;
    }
    foreach (ref L; MAP) L ~= W;

    int x, res = W;
    foreach (y, L; MAP) {
        int r_limit;
        if (L[0] > x) {
            res = min(res, L[0]);
            r_limit = L[0];
        } else {
            int l, r = L.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (L[m] < x) {
                    l = m;
                } else {
                    r = m;
                }
            }
            res = min(res, L[r]);
            r_limit = L[r];
        }

        if (x+1 == r_limit) break;
        ++x;

        if (y < H-1) {
            auto LL = MAP[y+1];
            int l, r = LL.length.to!int-1;
            if (LL[0] >= x) {
                r = 0;
            } else {
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (LL[m] < x) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
            }
            while (r < LL.length && x < r_limit && LL[r] == x) {
                ++x;
                ++r;
            }
            if (x == r_limit) break;
        }
    }
    writeln(res);
}

/*
10 10 14
4 3
2 2
7 3
9 10
7 7
8 1
10 10
5 4
3 4
2 8
6 4
4 4
5 8
9 2



0                 * *
9
8   *     *
7             *
6
5
4     * * * *
3       * + + *
2   * + + +       *
1 + + +         *
0 1 2 3 4 5 6 7 8 9 0
*/