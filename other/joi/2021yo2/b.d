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
    int N, Q; get(N, Q);

    auto G = new int[][3^^N];
    auto nn = new int[](N);
    foreach (x; 0..3^^N) {
        int xx = x;
        foreach (i; 0..N) {
            nn[N-i-1] = xx % 3;
            xx /= 3;
        }
        foreach (i; 2..N+1) {
            int y;
            foreach_reverse (j; 0..i) (y += nn[j]) *= 3;
            foreach (j; i..N) (y += nn[j]) *= 3;
            G[x] ~= y / 3;
        }
    }

    alias S = Tuple!(int, "n", int, "l");
    S[] ss;
    foreach (i; 0..N+1) foreach (j; 0..N-i+1) {
        auto k = N - i - j;
        int s;
        foreach (_; 0..i) s *= 3;
        foreach (_; 0..j) (s += 1) *= 3;
        foreach (_; 0..k) (s += 2) *= 3;
        ss ~= S(s / 3, 0);
    }

    auto DP = new int[](3^^N);
    DP[] = int.max / 3;
    foreach (s; ss) DP[s.n] = 0;
    while (!ss.empty) {
        auto n = ss.front.n;
        auto l = ss.front.l;
        ss.popFront();
        foreach (t; G[n]) if (DP[t] > l + 1) {
            DP[t] = l + 1;
            ss ~= S(t, l + 1);
        }
    }

    while (Q--) {
        char[] s; get(s);
        int q;
        foreach (c; s) {
            if (c == 'A') {
                q *= 3;
            } else if (c == 'B') {
                (q += 1) *= 3;
            } else {
                (q += 2) *= 3;
            }
        }
        writeln(DP[q / 3]);
    }
}