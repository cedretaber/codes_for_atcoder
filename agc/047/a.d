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
    long[] ts, fs;
    auto DP = new int[][](50, 50);
    foreach (_; 0..N) {
        string sa; get(sa);
        auto nn = sa.split(".");
        long a = nn[0].to!long * 10L^^9;
        if (nn.length == 2) {
            long x = 10L^^8;
            foreach (i; nn[1]) {
                a += (i - '0').to!long * x;
                x /= 10;
            }
        }
        long aa = a;
        int t, f;
        while (aa%2 == 0) {
            ++t;
            aa /= 2;
        }
        aa = a;
        while (aa%5 == 0) {
            ++f;
            aa /= 5;
        }
        DP[t][f] += 1;
        ts ~= t;
        fs ~= f;
    }
    foreach_reverse (i; 0..50) foreach_reverse (j; 0..50) {
        if (i) DP[i-1][j] += DP[i][j];
        if (j) DP[i][j-1] += DP[i][j];
        if (i && j) DP[i-1][j-1] -= DP[i][j];
    }

    long res;
    foreach (i; 0..N) {
        auto t = max(0, 18 - ts[i]);
        auto f = max(0, 18 - fs[i]);
        res += DP[t][f];
        if (ts[i] >= t && fs[i] >= f) --res;
    }
    writeln(res / 2);
}


/*
  0 1 2 3 4 -> 5
0     1
1
2
3 1
4
|
2


*/