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
    int N, M, K; get(N, M, K);
    int[] AA; get(AA);

    alias E = Tuple!(int, "i", int, "to");
    auto T = new E[][N];
    foreach (i; 0..N - 1) {
        int U, V; get(U, V); --U; --V;
        T[U] ~= E(i, V);
        T[V] ~= E(i, U);
    }

    alias UV = Tuple!(int, int);
    int[UV] es;
    foreach (i; 1..M) {
        auto a = AA[i - 1] - 1;
        auto b = AA[i] - 1;
        if (a > b) swap(a, b);
        ++es[UV(a, b)];
    }

    auto cs = new int[](N - 1);
    auto ds = new int[](N - 1);
    foreach (s; 0..N) {
        ds[] = 0;
        void run(int i, int p) {
            auto e = UV(s, i);
            if (e in es) {
                auto x = es[e];
                cs[] += ds[] * x;
            }
            foreach (n; T[i]) if (n.to != p) {
                ++ds[n.i];
                run(n.to, i);
                --ds[n.i];
            }
        }
        run(s, -1);
    }
    auto s = cs.sum();
    if (K > s || (s - K) % 2 == 1) return writeln(0);
    auto b = (s - K) / 2;
    writeln(cs);
    writeln(s);
}

/*

R + B = S
R - B = K <=> R = K + B

K + B + B = S
2B = S - K
B = (S - K) / 2

*/
