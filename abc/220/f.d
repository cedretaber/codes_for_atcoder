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
    auto T = new int[][N];
    foreach (_; 1..N) {
        int u, v; get(u, v); --u; --v;
        T[u] ~= v;
        T[v] ~= u;
    }

    auto rs = new long[](N);
    auto cs = new int[](N);

    Tuple!(int, long) run1(int i, int p) {
        int c;
        long r;
        foreach (j; T[i]) if (j != p) {
            auto t = run1(j, i);
            c += t[0];
            r += t[1];
        }
        cs[i] = c;
        r += c;
        rs[i] = r;
        return tuple(c + 1, r);
    }
    run1(0, 0);

    void run2(int i, int p) {
        if (p != -1) rs[i] = rs[p] + N - (cs[i] + 1) * 2;
        foreach (j; T[i]) if (j != p) run2(j, i);
    }
    run2(0, -1);

    writefln!"%(%d\n%)"(rs);
}
