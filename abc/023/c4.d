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
    int R, C, K; get(R, C, K);
    int N; get(N);
    auto rs = new int[](R);
    auto cs = new int[](C);
    alias P = Tuple!(int, "r", int, "c");
    P[] ps;
    while (N--) {
        int r, c; get(r, c); --r; --c;
        ++rs[r];
        ++cs[c];
        ps ~= P(r, c);
    }
    long res;
    foreach (p; ps) {
        auto k = rs[p.r] + cs[p.c];
        if (k == K + 1) {
            ++res;
        } else if (k == K) {
            --res;
        }
    }

    auto cc = new long[](R + 1);
    foreach (c; cs) ++cc[c];

    foreach (r; rs) if (0 <= K - r && K - r <= R) {
        res += cc[K - r];
    }

    writeln(res);
}
