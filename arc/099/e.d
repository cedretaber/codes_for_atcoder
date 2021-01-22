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
    int N, M; get(N, M);
    auto C = new bool[][](N, N);
    while (M--) {
        int A, B; get(A, B); --A; --B;
        C[A][B] = true;
        C[B][A] = true;
    }
    auto G = new int[][N];
    foreach (i; 0..N-1) foreach (j; i+1..N) if (!C[i][j]) {
        G[i] ~= j;
        G[j] ~= i;
    }

    auto cs = new int[](N);
    int c = -1;
    int[2] cc;
    int[] xs, ys;
    foreach (i; 0..N) if (cs[i] == 0) {
        c += 2;
        cc[0] = c;
        cc[1] = c + 1;
        bool put(int i, int x) {
            auto c = cc[x];
            auto d = cc[(x + 1) % 2];
            cs[i] = c;
            foreach (j; G[i]) {
                if (cs[j] == c) return false;
                if (cs[j] == 0 && !put(j, (x + 1) % 2)) return false;
            }
            return true;
        }
        if (!put(i, 0)) return writeln(-1);
        int x, y;
        foreach (d; cs) {
            if (d == c) {
                ++x;
            } else if (d == c + 1) {
                ++y;
            }
        }
        xs ~= x;
        ys ~= y;
    }

    auto ds = new bool[](N + 1);
    ds[0] = true;
    foreach (i; 0..xs.length) {
        auto x = xs[i];
        auto y = ys[i];
        auto es = new bool[](N + 1);
        foreach (j; 0..N) if (ds[j]) {
            es[j + x] = true;
            es[j + y] = true;
        }
        ds = es;
    }

    auto r = N * (N - 1);
    foreach (i; 1..N) if (ds[i]) {
        auto j = N - i;
        r = min(r, i * (i - 1) / 2 + j * (j - 1) / 2);
    }
    writeln(r);
}