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

alias P = Tuple!(int, "to", long, "c");

void main()
{
    int N, M; get(N, M);
    auto g = new P[][N];
    foreach (_; 0..M) {
        int f, t; long c; get(f, t, c);
        g[f] ~= P(t, c);
        g[t] ~= P(f, c);
    }

    alias S = Tuple!(int, "i", long, "c", int, "dpi", int, "r");
    auto Q = heapify!"a.c > b.c"([S(0, 0, 0, 4), S(0, 0, 1, 7)]);
    auto dp = [new long[][](N, 4), new long[][](N, 7)];
    foreach (ref dp1; dp) foreach (ref dp2; dp1) dp2[] = long.max / 10;
    dp[0][0][0] = dp[1][0][0] = 0;
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (i == N - 1) continue;
        foreach (n; g[i]) {
            auto j = n.to;
            auto d = c + n.c;
            if (dp[dpi][n.to][d % r] > d) {
                dp[dpi][n.to][d % r] = d;
                Q.insert(S(n.to, d, dpi, r));
            }
        }
    }
    writeln(min(dp[0][N - 1][0], dp[1][N - 1][0]));
}
