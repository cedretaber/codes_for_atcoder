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
    int N, D; get(N, D);
    int X, Y; get(X, Y);

    if (X % D != 0 || Y % D != 0) {
        writeln(0);
        return;
    }

    X /= D;
    Y /= D;

    if (abs(X) > 30 || abs(Y) > 30) {
        writeln(0);
        return;
    }

    auto dp = new double[][][](121, 121, 2);
    foreach (ref dp1; dp) foreach (ref dp2; dp1) dp2[] = 0;
    dp[60][60][0] = 1;
    foreach (T; 0..N) {
        auto t = T % 2;
        auto s = (T + 1) % 2;
        foreach (ref dp1; dp) foreach (ref dp2; dp1) dp2[s] = 0;
        foreach (i; 0..121)
        foreach (j; 0..121)
        static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
            auto ii = i + d[0];
            auto jj = j + d[1];
            if (0 <= ii && ii <= 120 && 0 <= jj && jj <= 120) {
                dp[ii][jj][s] += dp[i][j][t] / 4;
            }
        }}
    }
    writefln!"%.12f"(dp[Y + 60][X + 60][N % 2]);
}