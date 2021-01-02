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
    int[] as, bs;
    auto T = new int[][N];
    foreach (_; 1..N) {
        int a, b; get(a, b); --a; --b;
        as ~= a;
        bs ~= b;
        T[a] ~= b;
        T[b] ~= a;
    }
    auto ds = new int[](N);
    void walk(int i, int p, int d) {
        ds[i] = d;
        foreach (j; T[i]) if (j != p) walk(j, i, d + 1);
    }
    walk(0, -1, 0);

    auto cs = new long[](N);
    int Q; get(Q);
    while (Q--) {
        int t, e; long x; get(t, e, x); --e;
        auto a = as[e];
        auto b = bs[e];
        if (t == 2) swap(a, b);
        if (ds[a] < ds[b]) {
            cs[0] += x;
            cs[b] -= x;
        } else {
            cs[a] += x;
        }
    }

    void solve(int i, int p, long c) {
        cs[i] += c;
        foreach (j; T[i]) if (j != p) solve(j, i, cs[i]);
    }
    solve(0, -1, 0);

    writefln!"%(%d\n%)"(cs);
}