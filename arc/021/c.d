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
    long K; get(K);
    int N; get(N);
    ulong[] AS, DS; get_lines(N, AS, DS);

    ulong l, r = ulong.max, res = ulong.max;
    while (l+1 < r) {
        auto m = (l + r) / 2;
        long k;
        ulong c, rem;
        foreach (i; 0..N) {
            auto a = AS[i];
            auto d = DS[i];
            if (a + d * (K - 1) <= m) {
                k += K;
                c += a * K + K * (K - 1) / 2 * d;
                if (a + d * (K - 1) == m) ++rem;
                continue;
            } else if (a > m) {
                continue;
            }
            long ll, rr = K;
            while (ll + 1 < rr) {
                auto mm = (ll + rr) / 2;
                if (a + d * (mm - 1) <= m) {
                    ll = mm;
                } else {
                    rr = mm;
                }
            }
            k += ll;
            c += a * ll + ll * (ll - 1) / 2 * d;
            if (a + d * (ll - 1) == m) ++rem;
        }
        if (k >= K) {
            r = m;
            while (rem && k > K) {
                --rem;
                --k;
                c -= m;
            }
            res = min(res, c);
        } else {
            l = m;
        }
    }
    writeln(res);
}

/*

1000 1000

1000
1000 1000
1000 1000 1000
1000 1000 1000 1000


3
2
1 1
1 1

1 -> 2 +1
1 -> 2 +1
2 -> 3 +2

*/