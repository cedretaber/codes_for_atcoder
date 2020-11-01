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
    int N, M; get(N, M);
    long[] HS, WS; get(HS); get(WS);
    sort(HS);
    sort(WS);

    auto cs = new long[](N);
    auto ds = new long[](N);
    foreach (i; 0..N-1) {
        if (i) cs[i] = cs[i-1];
        if (i%2 == 0) cs[i] += HS[i+1] - HS[i];
    }
    foreach_reverse (i; 1..N) {
        if (i+1 < N) ds[i] = ds[i+1];
        if (i%2 == 1) ds[i] += HS[i+1] - HS[i];
    }

    long res = long.max;
    int i;
    foreach (w; WS) {
        while (i < N && HS[i] < w) ++i;
        long r;
        if (i == N) {
            r = cs[N-2] + w - HS[$-1];
        } else if (i%2 == 0) {
            if (i > 0) r += cs[i-2];
            r += HS[i] - w;
            if (i+1 < N) r += ds[i+1];
        } else {
            if (i-3 >= 0) r += cs[i-3];
            r += w - HS[i-1];
            r += ds[i];
        }
        res = min(res, r);
    }
    writeln(res);
}

/*

 +   +
1 2 3 4 5
   +   +

*/