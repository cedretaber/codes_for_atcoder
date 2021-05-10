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
    int N, Q; get(N, Q);
    auto res = (N - 2).to!long ^^ 2;
    auto wi = new int[](N);
    wi[N - 1] = N - 1;
    auto hi = new int[](N);
    hi[N - 1] = N - 1;
    int w = N - 1, h = N - 1;
    while (Q--) {
        int t, x; get(t, x); --x;
        if (t == 1) {
            if (x < w) {
                auto pw = w;
                while (w > x) wi[--w] = wi[pw];
                hi[wi[x]] = x;
            }
            res -= wi[x] - 1;
        } else {
            if (x < h) {
                auto ph = h;
                while (h > x) hi[--h] = hi[ph];
                wi[hi[x]] = x;
            }
            res -= hi[x] - 1;
        }
    }
    writeln(res);
}
