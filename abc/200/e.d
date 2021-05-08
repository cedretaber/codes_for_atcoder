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
    long N, K; get(N, K);
    auto DP = new long[][](2, N * 3 + 2);
    foreach (i; 0..N) {
        DP[0][i + 2] += 1;
        DP[0][i + 1 + N + 1] -= 1;
    }
    foreach (i; 1..N * 2 + 1) {
        DP[0][i] += DP[0][i - 1];
        DP[1][i + 1] += DP[0][i];
        DP[1][i + N + 1] -= DP[0][i];
    }
    long k = K, x;
    foreach (i; 3..N * 3 + 1) {
        DP[1][i] += DP[1][i - 1];
        k -= DP[1][i];
        if (k <= 0) {
            k += DP[1][i];
            x = i;
            break;
        }
    }

    foreach (i; 1..x - 1) {
        auto r = x - i;
        if (r > N * 2) continue;
        auto d = r - N > 0 ? N * 2 - r + 1 : r - 1;
        if (k > d) {
            k -= d;
            continue;
        }
        return writeln(i, " ", r - N > 0 ? r - N + k - 1 : k, " ", r - N > 0 ? N - k + 1 : r - k);
    }
}
