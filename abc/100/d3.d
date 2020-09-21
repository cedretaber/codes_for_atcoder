import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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
    long[] AS; get(AS);
    foreach (i; 1..N) AS[i] += AS[i-1];
    int i, j = 1, k = 2;
    long p(int i) { return AS[i]; }
    long q(int i) { return AS[j] - AS[i]; }
    long r(int k) { return AS[k] - AS[j]; }
    long s(int k) { return AS[$-1] - AS[k]; }
    auto res = long.max;
    while (j < N-1) {
        while (i < j-1 && abs(p(i) - q(i)) > abs(p(i+1) - q(i+1))) ++i;
        while (k < N-2 && abs(r(k) - s(k)) > abs(r(k+1) - s(k+1))) ++k;
        res = min(res, max(p(i), q(i), r(k), s(k)) - min(p(i), q(i), r(k), s(k)));
        ++j;
    }
    writeln(res);
}