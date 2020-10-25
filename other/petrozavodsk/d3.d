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
    int N, M; get(N, M);
    long[] aa; get(aa);
    auto T = new int[][N];
    while (M--) {
        int x, y; get(x, y);
        T[x] ~= y;
        T[y] ~= x;
    }
    long[][] tt;
    auto fs = new bool[](N);
    foreach (i; 0..N) if (!fs[i]) {
        long[] t;
        void walk(int i) {
            t ~= aa[i];
            fs[i] = true;
            foreach (j; T[i]) if (!fs[j]) walk(j);
        }
        walk(i);
        tt ~= t;
    }

    if (tt.length == 1) {
        writeln(0);
        return;
    }

    long[] rs;
    long s;
    foreach (t; tt) {
        sort(t);
        s += t[0];
        rs ~= t[1..$];
    }

    if (rs.length < tt.length - 2) {
        writeln("Impossible");
        return;
    }
    sort(rs);
    writeln(s + reduce!"a + b"(0L, rs[0..tt.length - 2]));
}