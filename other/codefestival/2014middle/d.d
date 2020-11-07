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
    long[] ps, ls; get_lines(N, ps, ls);

    // foreach (i; 0..N) {
    //     ps[i] += 1000 - ls[i];
    //     ls[i] = ls[i] * 2 + 1;
    // }

    // auto DP = new long[][](N, 2001);
    // foreach (ref dp; DP) dp[] = -1;
    // long solve(int i, long l) {
    //     if (i == N-1) return ls[i] - l;

    //     if (DP[i][l] == -1) {
    //         long res;
    //         if (l+1 < ls[i]) (res += solve(i, l+1)) %= P;
    //         if (ps[i] + l + 1 < ps[i+1] + ls[i+1]) (res += solve(i+1, max(0, ps[i] + l - ps[i+1] + 1))) %= P;
    //         DP[i][l] = res;
    //     }
    //     return DP[i][l];
    // }
    // writeln(solve(0, 0));

    auto DP = new long[][](N, 2001);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, long l) {
        if (i == N-1) return ls[N-1]*2 - l + 1;

        if (DP[i][l] == -1) {
            long res;
            if (l < ls[i]*2) (res += solve(i, l+1)) %= P;
            auto r = ps[i] + l - ls[i];
            if (r < ps[i+1] + ls[i+1]) (res += solve(i+1, max(0, r - (ps[i+1] - ls[i+1]) + 1))) %= P;
            DP[i][l] = res;
        }
        return DP[i][l];
    }
    writeln(solve(0, 0));
}

/*

-3 -2 -1  0  1  2  3  4
 0  1  2  3  4  5  6  7
       0  1  2  3  4

 0  1  2 3 4 5 6
-3 -2 -1 0 1 2 3

 0  1  2 3 4  5  6
-3 -2 -1 0 1  2  3
 0  1  2 3 4  5  6 7 8 9
             -2 -1 0 1 2
              0  1 2 3 4

0 3
4 2

2
0 3
2 2
-3 -2 -1  *  1  2  3
          0  1  *  3  4

-3 -> 0,1,2,3,4
-2 -> 0,1,2,3,4
-1 -> 0,1,2,3,4
0 -> 1,2,3,4
1 -> 2,3,4
2 -> 3,4
3 -> 4

25

*/