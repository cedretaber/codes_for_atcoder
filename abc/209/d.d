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
    int N, Q; get(N, Q);
    auto T = new int[][N];
    foreach (_; 1..N) {
        int A, B; get(A, B); --A; --B;
        T[A] ~= B;
        T[B] ~= A;
    }

    auto ds = new int[](N);
    auto ps = new int[][](N, 30);
    void run1(int i, int p, int d) {
        ds[i] = d;
        ps[i][0] = p;
        foreach (j; T[i]) if (j != p) run1(j, i, d + 1);
    }
    run1(0, 0, 0);
    foreach (j; 1..30) foreach (i; 0..N) {
        ps[i][j] = ps[ps[i][j - 1]][j - 1];
    }

    while (Q--) {
        int C, D; get(C, D); --C; --D;
        auto cd = ds[C];
        auto dd = ds[D];

        if (cd > dd) {
            swap(C, D);
            swap(cd, dd);
        }
        auto rd = dd - cd;
        foreach (i; 0..30) if (rd & (1 << i)) D = ps[D][i];
        if (C == D) {
            writeln((dd - cd) % 2 == 0 ? "Town" : "Road");
            continue;
        }

        if (ps[C][0] == ps[D][0]) {
            rd = ds[ps[C][0]];
        } else {
            int l, r = 29;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (ps[C][m] == ps[D][m]) {
                    r = m;
                } else {
                    l = m;
                }
            }
            rd = ds[r];
        }

        writeln((cd + dd - rd * 2) % 2 == 0 ? "Town" : "Road");
    }
}
