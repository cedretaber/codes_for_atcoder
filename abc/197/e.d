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
    auto ac = new bool[](N);
    auto max_x = new long[](N);
    max_x[] = long.min;
    auto min_x = new long[](N);
    min_x[] = long.max;

    foreach (_; 0..N) {
        long X; int C; get(X, C); --C;
        ac[C] = true;
        max_x[C] = max(max_x[C], X);
        min_x[C] = min(min_x[C], X);
    }

    auto DP = new long[][](N + 1, 2);
    long last_min, last_max;
    foreach (i; 0..N) {
        if (!ac[i]) {
            DP[i + 1] = DP[i];
        } else {
            auto d = max_x[i] - min_x[i];
            DP[i + 1][0] = min(DP[i][0] + abs(max_x[i] - last_min), DP[i][1] + abs(max_x[i] - last_max)) + d;
            DP[i + 1][1] = min(DP[i][0] + abs(min_x[i] - last_min), DP[i][1] + abs(min_x[i] - last_max)) + d;
            last_min = min_x[i];
            last_max = max_x[i];
        }
    }
    writeln(min(DP[N][0] + abs(last_min), DP[N][1] + abs(last_max)));
}
