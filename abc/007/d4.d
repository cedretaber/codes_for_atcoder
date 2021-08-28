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

long count(char[] x)
{
    if (x == "0") return 0;
    auto DP = new long[][](x.length, 2);
    foreach (i, c; x) {
        auto n = c - '0';
        if (i == 0) {
            foreach (j; 1..n) if (j != 4) DP[i][0] += 1;
            if (n != 4 && n != 9) DP[i][1] = 1;
        } else {
            foreach (j; 0..n) if (j != 4) DP[i][0] += DP[i - 1][1];
            if (n != 4 && n != 9) DP[i][1] = DP[i - 1][1];
            DP[i][0] += 7;
            DP[i][0] += DP[i - 1][0] * 8;
        }
    }
    return DP[x.length - 1].sum();
}

void main()
{
    long A, B; get(A, B);
    auto a = A - 1 - count((A - 1).to!(char[]));
    auto b = B - count(B.to!(char[]));
    writeln(b - a);
}
