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

alias D = Tuple!(int, "t", int, "a");

void main()
{
    int N, X; get(N, X);
    auto ds = new D[](N);
    foreach (i, t; readln.split) ds[i].t = t.to!int;
    foreach (i, a; readln.split) ds[i].a = a.to!int;
    sort!"a.t < b.t"(ds);

    bool check(int max_t) {
        auto aa = heapify!"a < b"([-1]);
        int i = N-1;
        foreach_reverse (t; max_t..10^^5+1) while (i >= 0 && ds[i].t == t) aa.insert(ds[i--].a);
        int x;
        foreach_reverse (t; 0..max_t) {
            if (aa.front > 0) {
                x = min(X, x + aa.front);
                aa.popFront();
            }
            while (i >= 0 && ds[i].t == t) aa.insert(ds[i--].a);
        }
        return x == X;
    }

    if (!check(10^^5)) return writeln(-1);

    int l, r = 10^^5;
    while (l + 1 < r) {
        auto m = (l + r) / 2;
        if (check(m)) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}