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
    int A1, A2; get(A1, A2);
    int B1, B2; get(B1, B2);
    int C1, C2; get(C1, C2);

    auto s = A1 + A2 + B1 + B2 + C1 + C2;

    auto DP = new double[][][][][][](A1 + 1, A2 + 1, B1 + 1, B2 + 1, C1 + 1, C2 + 1);
    DP[0][0][0][0][0][0] = 0;

    foreach (a1; 0..A1 + 1)
    foreach (a2; 0..A2 + 1)
    foreach (b1; 0..B1 + 1)
    foreach (b2; 0..B2 + 1)
    foreach (c1; 0..C1 + 1)
    foreach (c2; 0..C2 + 1) {
        if (a1 == 0 && a2 == 0 && b1 == 0 && b2 == 0 && c1 == 0 && c2 == 0) continue;

        auto t = (a1 +  a2 + b1 + b2 + c1 + c2) % 2 == s % 2;
        auto c100 = t ? 100 : 0;
        auto c50 = t ? 50 : 0;
        double r = t ? 0 : int.max;
        if (a1 != 0 || a2 != 0) {
            double x = 0;
            if (a1 != 0) x += (c100 + DP[a1 - 1][a2][b1][b2][c1][c2]) * a1;
            if (a2 != 0) x += (c50 + DP[a1][a2 - 1][b1][b2][c1][c2]) * a2;
            x /= a1 + a2;
            r = t ? max(r, x) : min(r, x);
        }
        if (b1 != 0 || b2 != 0) {
            double x = 0;
            if (b1 != 0) x += (c100 + DP[a1][a2][b1 - 1][b2][c1][c2]) * b1;
            if (b2 != 0) x += (c50 + DP[a1][a2][b1][b2 - 1][c1][c2]) * b2;
            x /= b1 + b2;
            r = t ? max(r, x) : min(r, x);
        }
        if (c1 != 0 || c2 != 0) {
            double x = 0;
            if (c1 != 0) x += (c100 + DP[a1][a2][b1][b2][c1 - 1][c2]) * c1;
            if (c2 != 0) x += (c50 + DP[a1][a2][b1][b2][c1][c2 - 1]) * c2;
            x /= c1 + c2;
            r = t ? max(r, x) : min(r, x);
        }
        DP[a1][a2][b1][b2][c1][c2] = r;
    }

    writefln!"%.12f"(DP[A1][A2][B1][B2][C1][C2]);
}
