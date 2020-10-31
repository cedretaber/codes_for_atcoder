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

enum P = 998244353L;

void main()
{
    int N, K; get(N, K);
    auto DP = new long[][](N+1, (N*2)+1);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int n, int m) {
        if (n > N || m > N*2 || m == 0) return n + m == N ? 1 : 0;

        if (DP[n][m] == -1) {
            auto r = solve(n, m*2);
            if (m >= 2) (r += solve(n+1, m-2)) %= P;
            DP[n][m] = r;
        }
        return DP[n][m];
    }
    writeln(solve(0, K*2));
}

/*

4 2

1 1 _ _
1 1/2 1/2 _
1 1/2 1/4 1/4
1/2 1/2 1/2 1/2

*/