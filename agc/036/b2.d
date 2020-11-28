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
    int N; long K; get(N, K);
    int[] AS; get(AS);

    auto jj = new int[](2 * 10^^5 + 1);
    auto fs = new int[](N);
    foreach_reverse (i, a; AS) {
        if (jj[a]) fs[i] = jj[a];
        jj[a] = i.to!int;
    }
    auto ii = new int[][](41, N+1);
    ii[0][] = -1;
    ii[0][N] = 0;
    foreach (i; 0..N) {
        if (ii[0][i] == -1) {
            auto j = i;
            int n = jj[AS[i]];
            for (;;) {
                if (j == N) {
                    n = -1;
                    break;
                }
                n = jj[AS[j]];
                if (fs[j] == 0) break;
                j = fs[j] + 1;
            }
            j = i;
            for (;;) {
                if (j == N) break;
                ii[0][j] = n + 1;
                if (fs[j] == 0) break;
                j = fs[j] + 1;
            }
        }
    }
    static foreach (x; 0..40) {{
        foreach (i; 0..N+1) {
            ii[x+1][i] = ii[x][ii[x][i]];
        }
    }}

    int i;
    --K;
    foreach_reverse (x; 0..41) if (K >= 2L^^x) {
        i = ii[x][i];
        K -= 2L^^x;
    }

    int[] rs;
    while (i < N) {
        if (fs[i] == 0) {
            rs ~= AS[i];
            ++i;
        } else {
            i = fs[i] + 1;
        }
    }
    writefln!"%(%d %)"(rs);
}