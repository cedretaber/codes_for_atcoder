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
    int K, Q; get(K, Q);
    long[] ds; get(ds);

    auto cs = new long[](K+1);
    auto es = new long[](K+1);
    while (Q--) {
        long n, x, m; get(n, x, m);
        foreach (i, d; ds) {
            cs[i+1] = cs[i] + d % m;
            es[i+1] = es[i];
            if (d % m == 0) ++es[i+1];
        }
        auto s = x + cs[$-1] * ((n - 1) / K) + cs[(n - 1) % K];
        writeln(n - 1 - (es[$-1] * ((n - 1) / K) + es[(n - 1) % K] + s / m - x / m));
    }
}

/*

d_1, d_2, ..., d_k

n x m
=> x, x+d_1, x+d_1+d_2, ..., x+d_1+d_2+...+d_(n%k)

3 1
3 1 4
5 3 2

1 1 0

3 4 5 5 6
1 0 1 1 0

*/