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

enum SIZE = 18;

void main()
{
    int N; get(N);
    int[] xs; get(xs);
    int L; get(L);

    auto DS = new int[SIZE][N];
    foreach (i; 0..N-1) {
        if (xs[i] + L < xs[i+1]) {
            DS[i][0] = -1;
        } else if (xs[i] + L >= xs[$-1]) {
            DS[i][0] = N-1;
        } else {
            int l = i+1, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (xs[i] + L >= xs[m]) {
                    l = m;
                } else {
                    r = m;
                }
            }
            DS[i][0] = l;
        }
    }
    DS[N-1][0] = -1;

    foreach (j; 1..SIZE) foreach (i; 0..N) {
        DS[i][j] = DS[i][j-1] == -1 ? -1 : DS[DS[i][j-1]][j-1];
    }

    int Q; get(Q);
    while (Q--) {
        int a, b; get(a, b); --a; --b;
        if (a > b) swap(a, b);

        int d;
        for (;;) {
            if (a == b) break;
            if (DS[a][0] == -1 || DS[a][0] >= b) {
                d += 1;
                break;
            }
            int l = 0, r = SIZE;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (DS[a][m] == -1 || DS[a][m] >= b) {
                    r = m;
                } else {
                    l = m;
                }
            }
            d += 2 ^^ l;
            a = DS[a][l];
        }
        writeln(d);
    }
}