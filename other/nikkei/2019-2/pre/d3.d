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

    auto G = new P[][N];
    foreach (i; 1..N) G[i] ~= P(i - 1, 0);
    while (M--) {
        int L, R; long C; get(L, R, C); --L; --R;
        G[L] ~= P(R, C);
    }
    auto DP = new long[](N);
    DP[] = long.max / 3;
    DP[0] = 0;

    auto Q = heapify!"a.c > b.c"([P(0, 0)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        foreach (p; G[to]) if (DP[p.to] > c + p.c) {
            DP[p.to] = c + p.c;
            Q.insert(P(p.to, c + p.c));
        }
    }
    writeln(DP[N - 1] == long.max / 3 ? -1 : DP[N - 1]);
}
