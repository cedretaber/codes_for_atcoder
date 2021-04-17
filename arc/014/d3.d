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
    int A, N, M; get(A, N, M);
    int[] LS; get_lines(N, LS);

    int[] ds;
    foreach (i; 1..N) ds ~= LS[i] - LS[i - 1] - 1;
    sort(ds);
    int[] cs = [0];
    foreach (i; 0..ds.length) cs ~= cs[$ - 1] + ds[i];
    cs = cs[1..$];

    while (M--) {
        int X, Y; get(X, Y);
        auto res = min(LS[0] - 1, X) + min(A - LS[$ - 1], Y) + N;
        if (N == 1) {
            writeln(res);
            continue;
        }
        if (ds[0] >= X + Y) {
            writeln(res + (X + Y) * (N - 1));
        } else if (ds[$ - 1] <= X + Y) {
            writeln(res + cs[$ - 1]);
        } else {
            int l, r = N - 2;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (ds[m] < X + Y) {
                    l = m;
                } else {
                    r = m;
                }
            }
            writeln(res + cs[l] + (X + Y) * (N - r - 1));
        }
    }
}
