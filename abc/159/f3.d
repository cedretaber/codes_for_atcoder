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
    int N, S; get(N, S);
    int[] AS; get(AS);

    auto DP = new long[][][](N+1, S+1, 2);
    foreach (i; 0..N) {
        foreach (j; 0..S+1) {
            auto d = j == 0 ? 1 : 0;
            (DP[i+1][j][0] += DP[i][j][0] + d) %= P;
            (DP[i+1][j][1] += DP[i][j][0] + DP[i][j][1] + d) %= P;
            if (j + AS[i] <= S) {
                (DP[i+1][j + AS[i]][0] += DP[i][j][0] + d) %= P;
                (DP[i+1][j + AS[i]][1] += DP[i][j][0] + d) %= P;
            }
        }
    }
    writeln(DP[N][S][1]);
}

/*

3 4
2 2 4

       2   2   4
0 0,0 1,1 3,2 5,3
1
2     1,1 4,3 7,3
3
4         1,1 5,4

o 1..3, 2..2 -> 1*1 + 2*2 = 5
x 1..2, 2..3 -> 1*2 + 2*1 = 4

10 10
3 1 4 1 5 9 2 6 5 3

  3 1 4 1 5 9 2 6 5 3 
0 1 1 1 1 1 1 1 1 1 1 1
1     1 1 2 2 2 2 2 2 2
2         1 1 1 2 2 2 2
3   1 1 1 1 1 1 3 3 3 4
4     1 2 3 3 3 4 4 4 6
5       1 2 3 3 4 4 5 7
6         1 3 3 6 7 9 c
7       1 1 2 2 5 7 9 d
8       1 2 3 3 6 8 b g
9         1 4 5 7 a e n
a           2 2 3 4 8 h

*/