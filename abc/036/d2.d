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

enum P = 10L^^9+7;

void main()
{
    int N; get(N);
    auto T = new int[][N];
    foreach (_; 1..N) {
        int a, b; get(a, b); --a; --b;
        T[a] ~= b;
        T[b] ~= a;
    }

    auto DP = new long[][](N, 2);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, int p, int c) {
        if (DP[i][c] != -1) return DP[i][c];

        long r = 1;
        foreach (j; T[i]) if (p != j) {
            auto rr = solve(j, i, 0);
            if (c == 0) (rr += solve(j, i, 1)) %= P;
            (r *= rr) %= P;
        }
        return DP[i][c] = r;
    }
    writeln((solve(0, -1, 0) + solve(0, -1, 1)) % P);
}

/*

+ + +
+ + *
+ * +

* + +
* + *

*/