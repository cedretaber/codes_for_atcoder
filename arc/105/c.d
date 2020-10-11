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

alias B = Tuple!(int, "l", int, "v");

void main()
{
    int N, M; get(N, M);
    int[] ws; get(ws);
    B[] bs; get_lines(M, bs);

    foreach (w; ws) foreach (b; bs) if (b.v < w) {
        writeln(-1);
        return;
    }

    sort!"a.v == b.v ? a.l > b.l : a.v < b.v"(bs);
    int last_l;
    foreach (ref b; bs) {
        last_l = max(last_l, b.l);
        b.l = last_l;
    }

    auto G = new int[][](N, N);
    auto DP = new int[](N);
    auto res = int.max;
    sort(ws);
    do {
        auto cs = new int[](N+1);
        foreach (i; 0..N) cs[i+1] = cs[i] + ws[i];
        foreach (i; 0..N) foreach (j; i+1..N) {
            auto w = cs[j+1] - cs[i];
            if (w <= bs[0].v) {
                G[i][j] = 0;
            } else {
                int l, r = bs.length.to!int;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (w <= bs[m].v) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
                G[i][j] = bs[l].l;
            }
        }
        DP[] = 0;
        foreach (i; 0..N) {
            foreach (j; i+1..N) {
                DP[j] = max(DP[j], DP[i] + G[i][j]);
            }
        }
        res = min(res, DP[N-1]);
    } while (nextPermutation(ws));
    writeln(res);
}