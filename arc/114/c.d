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
    int N, M; get(N, M);
    auto ds = new long[](M);
    ds[] = 1;
    auto ps = new long[](N);
    ps[0] = 1;
    foreach (i; 1..N) (ps[i] = ps[i - 1] * M) %= P;
    auto xs = new long[](M);
    long r = M * ps[N - 1] % P;
    foreach (i; 0..N - 1) {
        foreach (j; 0..M) {
            (xs[j] *= M) %= P;
            (xs[j] += ds[j]) %= P;
            (ds[j] *= M - j - 1) %= P;
            (r += (ps[i + 1] + P - xs[j]) % P * ps[N - i - 2] % P) %= P;
        }
    }
    writeln(r);
}
