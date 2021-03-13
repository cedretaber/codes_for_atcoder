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
    char[] S; get(S);
    char[] X; get(X);

    auto DP = new int[][](7, N);
    bool solve(int i, int n) {
        if (DP[n][i]) return DP[n][i] == 1;

        auto a = (n * 10 + S[i] - '0') % 7;
        auto b = n * 10 % 7;

        if (i == N-1) {
            if (X[i] == 'T') {
                return a == 0 || b == 0;
            } else {
                return a != 0 || b != 0;
            }
        } else {
            auto r1 = solve(i + 1, a);
            auto r2 = solve(i + 1, b);
            bool r;
            if (X[i] == X[i + 1]) {
                r = r1 || r2;
            } else {
                r = !r1 || !r2;
            }
            DP[n][i] = r ? 1 : -1;
            return r;
        }
    }
    auto r = solve(0, 0);
    writeln((X[0] == 'A' && r) || (X[0] == 'T' && !r) ? "Aoki" : "Takahashi");
}
