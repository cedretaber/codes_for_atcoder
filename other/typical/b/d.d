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
    int N, S; get(N, S);
    auto DP = new bool[][](N + 1, S + 1);
    DP[0][0] = true;
    int[] AA, BB; AA.length = N; BB.length = N;
    foreach (i; 0..N) {
        int A, B; get(A, B);
        AA[i] = A;
        BB[i] = B;
        foreach (j; 0..S) if (DP[i][j]) {
            if (j + A <= S) DP[i + 1][j + A] = true;
            if (j + B <= S) DP[i + 1][j + B] = true;
        }
    }

    if (!DP[N][S]) return writeln("Impossible");

    char[] res;
    int s = S;
    foreach_reverse (i; 0..N) {
        if (s >= AA[i] && DP[i][s - AA[i]]) {
            res ~= 'A';
            s -= AA[i];
        } else {
            res ~= 'B';
            s -= BB[i];
        }
    }
    reverse(res);
    writeln(res);
}
