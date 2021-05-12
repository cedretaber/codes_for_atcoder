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
    auto G = new int[][](N, N);
    foreach (ref g; G) g[] = int.max / 3;
    foreach (i; 0..N) G[i][i] = 0;
    while (M--) {
        int A, B, C; get(A, B, C); --A; --B;
        G[A][B] = G[B][A] = C;
    }

    foreach (k; 0..N) foreach (i; 0..N) foreach (j; 0..N) if (G[i][j] > G[i][k] + G[k][j]) G[i][j] = G[i][k] + G[k][j];
    long s;
    foreach (i; 0..N) foreach (j; i + 1..N) s += G[i][j];

    int K; get(K); while (K--) {
        int X, Y, Z; get(X, Y, Z); --X; --Y;
        if (G[X][Y] > Z) {
            s -= G[X][Y] - Z;
            G[X][Y] = G[Y][X] = Z;
            foreach (i; 0..N) foreach (j; i + 1..N) {
                auto d = min(G[i][X] + Z + G[Y][j], G[i][Y] + Z + G[X][j]);
                if (G[i][j] > d) {
                    s -= G[i][j] - d;
                    G[i][j] = G[j][i] = d;
                }
            }
        }
        writeln(s);
    }
}
