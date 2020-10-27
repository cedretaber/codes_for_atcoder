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

alias P = Tuple!(long, "x", long, "y", char, "c");
int['O'+1] c2i;

void main()
{
    int K, N; get(K, N);
    P[] ps;
    foreach (_; 0..N) {
        long x, y; string s; get(x, y, s);
        ps ~= P(x, y, s[0]);
    }
    c2i['O'] = 1;
    c2i['I'] = 2;

    int[4] ii;

    int solve(int k, long x, long y, P[] ps) {
        // writeln([k, x, y], " ", ps);
        if (k == 0 || ps.length <= 1) return 0;

        auto l = 2L^^(k-1);
        P[][4] pps;
        int[4][4] cs;
        foreach (p; ps) {
            int i;
            if (p.x < x+l && p.y < y+l) {
                i = 0;
            } else if (p.x >= x+l && p.y < y+l) {
                i = 1;
            } else if (p.x < x+l && p.y >= y+l) {
                i = 2;
            } else {
                i = 3;
            }
            pps[i] ~= p;
            ++cs[i][c2i[p.c]];
            ++cs[i][3];
        }
        // writeln(cs);

        if (k > 1 &&
            pps[0].length <= 1 &&
            pps[1].length <= 1 &&
            pps[2].length <= 1 &&
            pps[3].length <= 1) return 0;

        auto tl = [
            solve(k-1, x, y, pps[0]),
            solve(k-1, x+l, y, pps[1]),
            solve(k-1, x, y+l, pps[2]),
            solve(k-1, x+l, y+l, pps[3])
        ];

        int min_r = int.max;
        ii[0] = 0; ii[1] = 1; ii[2] = 2; ii[3] = 3;
        do {
            int r;
            static foreach (j; [0,1,2,3]) {{
                auto i = ii[j];
                if (i == 3) {
                    r += tl[j];
                } else {
                    r += cs[j][3] - cs[j][i];
                }
            }}
            min_r = min(min_r, r);
        } while (nextPermutation(ii[]));

        // writeln([k, x, y], " r=", min_r);
        return min_r;
    }

    writeln(solve(K, 1, 1, ps));
}