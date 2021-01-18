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
        int x, y; get(x, y); --x; --y;
        T[x] ~= y;
        T[y] ~= x;
    }
    auto ds = new int[](N);
    auto ps = new int[][](N, 18);

    void walk(int i, int p, int d) {
        ds[i] = d;
        if (p != -1) ps[i][0] = p;
        foreach (j; T[i]) if (j != p) walk(j, i, d + 1);
    }
    walk(0, -1, 0);
    foreach (j; 1..18) foreach (i; 0..N) ps[i][j] = ps[ps[i][j-1]][j-1];

    int Q; get(Q);
    while (Q--) {
        int a, b; get(a, b); --a; --b;
        if (ds[a] > ds[b]) swap(a, b);
        auto d = ds[b] - ds[a];
        auto c = b;
        foreach (i; 0..18) if (d & (1<<i)) c = ps[c][i];
        if (a == c) {
            writeln(ds[b] - ds[a] + 1);
        } else {
            int l, r = ds[a];
            while (l+1 < r) {
                auto m = (l+r) / 2;
                auto aa = a;
                auto cc = c;
                foreach (i; 0..18) if (m & (1<<i)) {
                    aa = ps[aa][i];
                    cc = ps[cc][i];
                }
                if (aa == cc) {
                    r = m;
                } else {
                    l = m;
                }
            }
            foreach (i; 0..18) if (r & (1<<i)) c = ps[c][i];
            writeln(ds[a] + ds[b] - ds[c] * 2 + 1);
        }
    }
}