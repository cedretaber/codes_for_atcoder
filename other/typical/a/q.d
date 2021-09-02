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

enum D = [[0, 1], [1, 0], [0, -1], [-1, 0]];

void main()
{
    int H, W; get(H, W);
    int rs, cs; get(rs, cs); --rs, --cs;
    int rt, ct; get(rt, ct); --rt; --ct;
    char[][] MAP; get_lines(H, MAP);

    auto DP = new int[][][](H, W, 4);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max / 3;
    DP[rs][cs][] = 0;

    alias S = Tuple!(int, "r", int, "c", int, "x", int, "d");
    auto ss = DList!S(0.iota(4).map!(d => S(rs, cs, 0, d)));
    while (!ss.empty) with (ss.front) {
        ss.removeFront();
        static foreach (dd; 0..4) {{
            auto rr = r + D[dd][0];
            auto cc = c + D[dd][1];
            if (0 <= rr && rr < H && 0 <= cc && cc < W && MAP[rr][cc] == '.') {
                auto xx = x + (d == dd ? 0 : 1);
                if (DP[rr][cc][dd] > xx) {
                    DP[rr][cc][dd] = xx;
                    auto s = S(rr, cc, xx, dd);
                    if (d == dd) {
                        ss.insertFront(s);
                    } else {
                        ss.insertBack(s);
                    }
                }
            }
        }}
    }
    writeln(DP[rt][ct].minElement());
}
