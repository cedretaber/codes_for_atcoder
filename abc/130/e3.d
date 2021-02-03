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

long P = 10L^^9 + 7;

void main()
{
    int N, M; get(N, M);
    long[] SS, TS; get(SS); get(TS);

    auto DP = new long[][](N + 1, M + 1);
    foreach (i; 0..N+1) DP[i][0] = 1;
    foreach (j; 0..M+1) DP[0][j] = 1;
    foreach (i; 1..N+1) foreach (j; 1..M+1) {
        DP[i][j] = (DP[i][j-1] + DP[i-1][j]) % P;
        if (SS[i-1] != TS[j-1]) (DP[i][j] += P - DP[i-1][j-1]) %= P;
    }
    writeln(DP[N][M]);
}