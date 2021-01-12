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
    int N, M; long L; get(N, M, L);
    auto G = new long[][](N, N);
    foreach (ref g; G) g[] = long.max / 3;
    foreach (i; 0..N) G[i][i] = 0;
    while (M--) {
        int A, B; long C; get(A, B, C); --A; --B;
        if (G[A][B] > C) {
            G[A][B] = C;
            G[B][A] = C;
        }
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (G[i][j] > G[i][k] + G[k][j]) {
            G[i][j] = G[i][k] + G[k][j];
        }
    }

    auto X = new int[][](N, N);
    foreach (ref x; X) x[] = int.max / 3;
    foreach (i; 0..N) foreach (j; 0..N) if (G[i][j] <= L) X[i][j] = 1;
    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) {
        if (X[i][j] > X[i][k] + X[k][j]) {
            X[i][j] = X[i][k] + X[k][j];
        }
    }
    foreach (ref xx; X) foreach (ref x; xx) if (x == int.max / 3) x = 0;

    int Q; get(Q);
    while (Q--) {
        int s, t; get(s, t);
        writeln(X[s-1][t-1] - 1);
    }
}