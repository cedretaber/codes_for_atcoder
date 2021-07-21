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
    int N, M, K, Q; get(N, M, K, Q);
    long[] CS, DS; CS.reserve(N); DS.reserve(N);
    foreach (_; 0..N) {
        long P; int T; get(P, T);
        if (T == 0) {
            CS ~= P;
        } else {
            DS ~= P;
        }
    }
    sort(CS);
    sort(DS);

    long res = CS[0..min(M, $)].sum();
    int i = min(M, CS.length.to!int) - 1, j;
    while (i + 1 + j < M) res += DS[j++];
    long k = (j + K - 1) / K;
    res += Q * k;
    auto r = res;
    for (;;) {
        while (i >= 0 && j < DS.length && j + 1 <= k * K && CS[i] > DS[j]) {
            r = r - CS[i] + DS[j];
            --i;
            ++j;
        }
        res = min(res, r);
        if (j < k * K) break;
        ++k;
        r += Q;
    }
    writeln(res);
}
