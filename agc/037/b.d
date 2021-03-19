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
    long N; get(N);
    char[] S; get(S);

    auto ps = new int[](N * 3);
    DList!int rs, gs, bs;
    foreach (ii, c; S) {
        auto i = ii.to!int;
        if (c == 'R') {
            rs.insert(i);
        } else if (c == 'G') {
            gs.insert(i);
        } else {
            bs.insert(i);
        }
        if (!rs.empty && !gs.empty && !bs.empty) {
            auto r = rs.front; rs.removeFront();
            auto g = gs.front; gs.removeFront();
            auto b = bs.front; bs.removeFront();
            if (r > g) swap(r, g);
            if (g > b) swap(g, b);
            if (r > g) swap(r, g);
            ps[r] = -1;
            ps[b] = 1;
        }
    }
    auto qs = new int[](N * 3);
    int q;
    foreach_reverse (i, p; ps) {
        if (p == 1) {
            ++q;
        } else if (p == 0) {
            qs[i] = q;
            --q;
        }
    }

    long a, r = 1;
    foreach (i, p; ps) {
        if (p == -1) {
            ++a;
        } else if (p == 0) {
            (r *= a-- * qs[i] % P) %= P;
        }
    }
    foreach (i; 2..N + 1) (r *= i) %= P;
    writeln(r);
}
