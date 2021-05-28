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
    int[] AS; get(AS); AS ~= 0;

    auto ii = new int[][10^^5 * 2 + 1];
    foreach (i, a; AS) ii[a] ~= i.to!int;

    auto ns = new int[][](N + 1, 42);
    ns[N][0] = 0;
    foreach_reverse (i; 0..N) {
        auto a = AS[i];
        if (ii[a][$ - 1] == i) {
            ns[i][0] = ii[a][0] + 1;
        } else {
            int l, r = ii[a].length.to!int - 1;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (ii[a][m] <= i) {
                    l = m;
                } else {
                    r = m;
                }
            }
            ns[i][0] = ns[ii[a][r] + 1][0];
        }
    }
    foreach (j; 1..42) foreach (i; 0..N + 1) ns[i][j] = ns[ns[i][j - 1]][j - 1];

    int p;
    foreach (j; 0..42) if ((K - 1) & (1L << j)) p = ns[p][j];

    int[] res;
    for (auto i = p; i < N; ++i) {
        auto a = AS[i];
        if (ii[a][$ - 1] == i) {
            res ~= a;
        } else {
            int l, r = ii[a].length.to!int - 1;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (ii[a][m] <= i) {
                    l = m;
                } else {
                    r = m;
                }
            }
            i = ii[a][r];
        }
    }
    writefln!"%(%d %)"(res);
}

/*

1 2 3 1 
2 3 1 2 
3

1 1 2 2 3 1 1 2 2 3 1 1 2 2 3

*/
