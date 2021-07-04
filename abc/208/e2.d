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
    char[] N; long K; get(N, K);
    long[long][][] DP;
    DP.length = N.length;
    foreach (ref dp; DP) dp.length = 2;
    int n = N[0] - '0';
    foreach (j; 1..n) DP[0][0][j] = 1;
    DP[0][1][n] = 1;
    foreach (i; 1..N.length) {
        n = N[i] - '0';
        foreach (j; 1..10) DP[i][0][j] += 1;
        foreach (k, v; DP[i - 1][0]) {
            foreach (j; 0..10) DP[i][0][k * j] += v;
        }
        foreach (k, v; DP[i - 1][1]) {
            foreach (j; 0..n) DP[i][0][k * j] += v;
            DP[i][1][k * n] += v;
        }
    }
    long res;
    foreach (dp; DP[N.length - 1]) foreach (k, v; dp) if (k <= K) res += v;
    writeln(res);
}
