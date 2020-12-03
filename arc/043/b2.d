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
    int[] DS; get_lines(N, DS);
    sort(DS);

    auto memo = new long[](N);
    int j;
    foreach (i; 0..N-1) {
        while (j < N && DS[j] < DS[i] * 2) ++j;
        memo[i] = N - j;
    }
    foreach_reverse (i; 0..N-1) (memo[i] += memo[i+1]) %= P;
    j = 0;
    foreach (i; 0..N-2) {
        while (j < N-1 && DS[j] < DS[i] * 2) ++j;
        memo[i] = memo[j];
    }
    memo[$-2] = 0;
    foreach_reverse (i; 0..N-1) (memo[i] += memo[i+1]) %= P;
    j = 0;
    foreach (i; 0..N-3) {
        while (j < N-2 && DS[j] < DS[i] * 2) ++j;
        memo[i] = memo[j];
    }
    memo[$-3] = 0;
    foreach_reverse (i; 0..N-1) (memo[i] += memo[i+1]) %= P;

    writeln(memo[0]);
}