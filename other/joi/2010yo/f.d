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

alias P = Tuple!(int, "t", int, "b", int, "l", int, "r");

void main()
{
    int N, M; get(M, N);
    int[][] MAP; get_lines(N, MAP);

    int x, c;
    foreach (i; 0..N) foreach (j; 0..M) if (MAP[i][j]) {
        if (MAP[i][j] == 2) c = x;
        MAP[i][j] = ++x;
    }

    auto G = new P[](x);
    foreach (ref p; G) p = P(-1, -1, -1, -1);
    foreach (i; 0..N) foreach (j; 0..M) if (MAP[i][j]) {
        x = MAP[i][j] - 1;
        for (int k = i+1; k < N; ++k) if (MAP[k][j]) {
            auto y = MAP[k][j] - 1;
            G[x].b = y;
            G[y].t = x;
            break;
        }
        for (int k = j+1; k < M; ++k) if (MAP[i][k]) {
            auto y = MAP[i][k] - 1;
            G[x].r = y;
            G[y].l = x;
            break;
        }
    }
    x++;

    int solve(int i, ulong s) {
        if (i == c && s == (1UL<<x)-1) return 1;

        int r;
        static foreach (j; 0..4) {{
            auto n = G[i][j];
            while (n != -1 && (s & (1UL<<n))) {
                if (n == c && s == (1UL<<x)-1) break;
                n = G[n][j];
            }
            if (n != -1) r += solve(n, s | (1UL<<n));
        }}
        return r;
    }
    writeln(solve(c, 0 | (1UL<<c)));
}