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
    long N; int K; get(N, K);

    long[] ps;
    for (long i = 1; i^^2 <= N; ++i) {
        ps ~= N / i;
    }

    auto bs = new long[](ps.length * 2);
    foreach (i, p; ps) {
        bs[i] = i + 1;
        bs[ps.length + i] = p;
        if (i+1 == p) bs[i] = 0;
    }
    sort(bs);
    if (bs[0] == 0) bs = bs[1..$];
    bs = [0L] ~ bs;
    auto cs = new long[](bs.length);
    foreach (i; 1..bs.length) cs[i] = bs[i] - bs[i-1];

    auto DP = new long[][](K, bs.length);
    foreach (j; 0..bs.length) DP[K-1][j] = bs[j];

    foreach_reverse (i; 0..K-1) {
        foreach (j; 1..bs.length) {
            DP[i][j] = (DP[i][j-1] + DP[i+1][bs.length - j] * cs[j] % P) % P;
        }
    }
    writeln(DP[0][$-1]);
}

/*

4 2

(1,4) (1,3) (1,2) (1,1)
(2,1) (2,2)
(3,1)
(4,1)

9 2

(1,1) ... (1,9)
(2,1) (2,2) (2,3) (2,4)
(3,1) (3,2) (3,3)
(4,1) (4,2)
(5,1)
(6,1)
(7,1)
(8,1)
(9,1)

9 + 4 + 3 + 2 + 5 = 


*/