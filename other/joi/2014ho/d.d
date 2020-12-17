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

alias P = Tuple!(int, "to", long, "t");

void main()
{
    int N, M, X; get(N, M, X);
    int[] HS; get_lines(N, HS);
    auto T = new P[][N];
    foreach (_; 0..M) {
        int a, b, t; get(a, b, t); --a; --b;
        if (HS[a] - t >= 0) T[a] ~= P(b, t);
        if (HS[b] - t >= 0) T[b] ~= P(a, t);
    }

    auto DP = new long[](N);
    DP[] = long.max / 3;
    DP[0] = 0;
    auto ss = heapify!"a.t > b.t"([P(0, 0)]);
    while (!ss.empty) with (ss.front) {
        ss.popFront();
        auto x = t > X ? 0 : X - t;

        foreach (n; T[to]) {
            long tt;
            if (x - n.t <= 0) {
                tt = t + n.t + n.t - x;
            } else if (x - n.t > HS[n.to]) {
                tt = t + n.t + x - (HS[n.to] + n.t);
            } else {
                tt = t + n.t;
            }
            if (DP[n.to] > tt) {
                DP[n.to] = tt;
                ss.insert(P(n.to, tt));
            }
        }
    }

    writeln(DP[N-1] == long.max / 3 ? -1 : DP[N-1] <= X ? DP[N-1] + HS[N-1] - (X - DP[N-1]) : DP[N-1] + HS[N-1]);
}

/*

4 4 10
10
1
4
1
1 2 5
1 3 6
2 4 1
3 4 3

1 -> 2 -> 4
4 + 5 + 0 + 1 + 1 = 11
1 -> 3 -> 4
0 + 6 + 0 + 3 + 0 = 9


*/