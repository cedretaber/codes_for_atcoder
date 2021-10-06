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
    long[] ts;
    foreach (_; 0..N) {
        long A, B; get(A, B);
        ts ~= A;
        ts ~= -(A + B);
    }
    sort!((a, b) => abs(a) < abs(b))(ts);
    auto res = new long[](N + 1);
    long p;
    int c;
    while (!ts.empty) {
        long t;
        auto d = c;
        do {
            t = ts.front;
            ts.popFront();
            if (t > 0) {
                ++d;
            } else {
                --d;
            }
        } while (!ts.empty && abs(ts.front) == abs(t));

        t = abs(t);
        if (c) res[c] += t - p;
        p = t;
        c = d;
    }
    writefln!"%(%d %)"(res[1..$]);
}
