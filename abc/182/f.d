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
    int N; long X; get(N, X);
    long[] AS; get(AS);

    if (N == 1) {
        writeln(1);
        return;
    }

    auto bs = new long[](N);
    foreach (i; 0..N-1) bs[i] = AS[i+1] / AS[i];

    auto cs = new long[](N);
    {
        auto x = X;
        foreach_reverse (i; 0..N) {
            cs[i] = x / AS[i];
            x %= AS[i];
        }
    }

    auto DP = new long[][](N, 2);
    DP[1][0] = 1;
    if (cs[0] != 0) DP[1][1] = 1;

    foreach (i; 1..N-1) {
        auto c = cs[i];

        DP[i+1][0] += DP[i][0];
        if (c != 0) DP[i+1][1] += DP[i][0];

        DP[i+1][1] += DP[i][1];
        if (c+1 != bs[i]) DP[i+1][0] += DP[i][1];
    }
    writeln(DP[N-1][0] + DP[N-1][1]);
}

/*

A1 + A2 + A3 + A4 + ...

3 9
1 5 10
[5, 2, 0]

10 5 1
 x 2 5

9 -> [0, 1, 4]



1 5 10
[5, 2, 0]

9 -> 4 1 0

1桁目
0 -> 繰り下がりあり、ok
1..3 -> 繰り下がりあり、ng
4 -> 繰り下がりなし、ok

2桁目
繰り下がりあり
0 -> 繰り下がりあり、ok
1 -> 繰り下がりあり、ng

繰り下がりなし
0 -> 繰り下がりあり、ok
1 -> 繰り下がりなし、ok

3桁目
繰り下がりあり
0 -> 足りない、ng
1 -> ピッタリ、ok
2.. -> ng

繰り下がりなし
0 -> ok
1.. -> ng



1 2 4 8 16

*/