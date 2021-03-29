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
    long[] AA; get(AA);
    long p = AA[0], q, r = AA[1] + AA[2], s;
    foreach (a; AA[3..$]) s += a;
    int i = 1, k = 3;
    auto res = long.max;
    foreach (j; 1..N-2) {
        q += AA[j];
        r -= AA[j];
        while (i < j && abs(q - p) > abs((q - AA[i]) - (p + AA[i]))) {
            p += AA[i];
            q -= AA[i];
            ++i;
        }
        while (k < N-1 && abs(s - r) > abs((s - AA[k]) - (r + AA[k]))) {
            r += AA[k];
            s -= AA[k];
            ++k;
        }
        res = min(res, max(p, q, r, s) - min(p, q, r, s));
    }
    writeln(res);
}
