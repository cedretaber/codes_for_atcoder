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
    int N; long K; get(N, K);
    int[] AS, BS; get(AS); get(BS);

    long l = AS[$-1], r = long.max / 3;
    while (l + 1 < r) {
        auto m = (l + r) / 2;

        auto k = K;
        long y;
        foreach_reverse (i; 0..N) {
            auto a = AS[i];
            auto b = BS[i];
            if (b <= y) {
                y -= b;
                continue;
            }
            b -= y;
            auto c = m - a;
            auto x = (b + c - 1) / c;
            if (x > k) goto ng;
            k -= x;
            y = b % c == 0 ? 0 : c - b % c;
        }
        r = m;
        continue;
        ng:
        l = m;
    }
    writeln(r);
}