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
    int N, M; long L; get(N, M, L);
    auto g1 = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j; 0..N) g1[i][j] = long.max / 3;
        g1[i][i] = 0;
    }
    while (M--) {
        int A, B; long C; get(A, B, C); --A; --B;
        g1[A][B] = C;
        g1[B][A] = C;
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (g1[i][j] > g1[i][k] + g1[k][j]) g1[i][j] = g1[i][k] + g1[k][j];
    }
    auto g2 = new int[][](N, N);
    foreach (ref g; g2) g[] = int.max / 3;
    foreach (i; 0..N) foreach (j; 0..N) if (g1[i][j] <= L) g2[i][j] = 1;

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (g2[i][j] > g2[i][k] + g2[k][j]) g2[i][j] = g2[i][k] + g2[k][j];
    }

    int Q; get(Q); while (Q--) {
        int S, T; get(S, T);
        auto d = g2[S - 1][T - 1];
        writeln((d == int.max / 3 ? 0 : d) - 1);
    }
}
