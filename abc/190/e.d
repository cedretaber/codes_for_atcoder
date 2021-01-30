import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

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
    int N, M; get(N, M);
    auto G = new int[][N];
    foreach (_; 0..M) {
        int A, B; get(A, B); --A; --B;
        G[A] ~= B;
        G[B] ~= A;
    }
    int K; get(K);
    int[] CS; get(CS);
    foreach (ref c; CS) c -= 1;

    auto G2 = new long[][](K, K);
    auto DP = new long[](N);
    foreach (i; 0..K) {
        auto s = CS[i];
        DP[] = long.max / 3;
        DP[s] = 0;
        auto ss = [s];
        int l;
        while (!ss.empty) {
            ++l;
            int[] nss;
            foreach (j; ss) foreach (k; G[j]) if (DP[k] == long.max / 3) {
                DP[k] = l;
                nss ~= k;
            }
            ss = nss;
        }
        foreach (j; 0..K) G2[i][j] = DP[CS[j]];
    }

    auto DP2 = new long[][](K, 1<<K);
    foreach (ref dp; DP2) dp[] = long.max / 3;
    foreach (i; 0..K) {
        DP2[i][1<<i] = 1;
    }
    auto bs = 0.iota(1<<K).array();
    sort!((a, b) => popcnt(a) < popcnt(b))(bs);
    foreach (b; bs)
    foreach (i; 0..K)
    foreach (j; 0..K)
    if (DP2[j][b | (1<<j)] > DP2[i][b] + G2[i][j]) {
        DP2[j][b | (1<<j)] = DP2[i][b] + G2[i][j];
    }
    auto res = long.max / 3;
    foreach (i; 0..K) res = min(res, DP2[i][(1<<K) - 1]);
    writeln(res == long.max / 3 ? -1 : res);
}