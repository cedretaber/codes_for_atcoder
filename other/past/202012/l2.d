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
    int N; get(N);
    char[] S, T; get(S); get(T);

    auto DP = new int[][](N, N);
    foreach (i; 0..N-2) if (S[i..i+3] == T) DP[i][i+2] = 3;
    foreach (d; 3..N) foreach (i; 0..N) {
        auto j = i + d;
        if (j >= N) break;

        DP[i][j] = max(DP[i+1][j], DP[i][j-1]);
        foreach (k; i..j) {
            DP[i][j] = max(DP[i][j], DP[i][k] + DP[k+1][j]);
            if (S[i] == T[0] && S[k] == T[1] && S[j] == T[2]) {
                if (i+1 == k && DP[k+1][j-1] == j-k-1) DP[i][j] = max(DP[i][j], DP[k+1][j-1] + 3);
                if (j-1 == k && DP[i+1][k-1] == k-i-1) DP[i][j] = max(DP[i][j], DP[i+1][k-1] + 3);
                if (i+1 < k-1 && k+1 < j-1 && DP[i+1][k-1] == k-i-1 && DP[k+1][j-1] == j-k-1) DP[i][j] = max(DP[i][j], DP[i+1][k-1] + DP[k+1][j-1] + 3);
            }
        }
    }
    writeln(DP[0][N-1] / 3);
}