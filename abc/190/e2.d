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

import core.bitop;

void main()
{
    int N, M; get(N, M);
    auto g1 = new int[][N];
    while (M--) {
        int A, B; get(A, B); --A; --B;
        g1[A] ~= B;
        g1[B] ~= A;
    }
    int K; get(K);
    int[] CC; get(CC); foreach (ref c; CC) --c;

    auto g2 = new int[][](K, K);
    auto DP = new int[](N);
    foreach (i, c; CC) {
        DP[] = int.max / 3; DP[c] = 0;
        auto ss = [c];
        int t;
        while (!ss.empty) {
            ++t;
            int[] nss;
            foreach (s; ss) foreach (j; g1[s]) if (DP[j] > t) {
                DP[j] = t;
                nss ~= j;
            }
            ss = nss;
        }
        foreach (j, d; CC) {
            if (DP[d] == int.max / 3) return writeln(-1);
            g2[i][j] = DP[d];
        }
    }

    auto bs = 0.iota(1 << K).array();
    sort!((a, b) => popcnt(a) < popcnt(b))(bs);
    auto DP2 = new int[][](K, 1 << K);
    foreach (ref dp; DP2) dp[] = int.max / 3;
    foreach (i; 0..K) DP2[i][1 << i] = 1;

    foreach (b; bs) foreach (i; 0..K) foreach (j; 0..K) {
        if (DP2[j][b | (1 << j)] > DP2[i][b] + g2[i][j]) {
            DP2[j][b | (1 << j)] = DP2[i][b] + g2[i][j];
        }
    }
    auto r = int.max;
    foreach (i; 0..K) r = min(r, DP2[i][(1 << K) - 1]);
    writeln(r);
}
