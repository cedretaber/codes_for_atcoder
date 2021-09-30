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
    long N, D; get(N, D);

    auto ps = new long[](N);
    ps[0] = 1;
    foreach (i; 1..N) ps[i] = ps[i - 1] * 2 % P;
    auto ds = new long[](N);

    long q, r;
    foreach (i; 0..N) {
        if (i + N - 1 < D) continue;

        auto j = D - i - (i == 0 ? 0 : 1);
        if (0 <= j && j < N) {
            (q += ps[j]) %= P;
            auto k = N - D + i * 2;
            if (0 <= k && k < N) ds[k] = ps[j];
        } else if (i == D) {
            (q += 1) %= P;
        }
        (q += P - ds[i]) %= P;
        (r += ps[i] * q % P) %= P;
    }
    writeln(r);
}
