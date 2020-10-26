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
    int N, L; get(N, L);
    int[] aa, bb; get(aa); get(bb);

    int[] xs, ys;
    xs.reserve(N+1);
    ys.reserve(N+1);
    xs ~= aa[0] - 1;
    ys ~= bb[0] - 1;
    foreach (i; 1..N) {
        xs ~= aa[i] - aa[i-1] - 1;
        ys ~= bb[i] - bb[i-1] - 1;
    }
    xs ~= L - aa[$-1];
    ys ~= L - bb[$-1];

    long l, r, c;
    foreach (long i; 0..N+1) {
        if (ys[i] == 0) continue;
        while (r <= N && xs[r] == 0) ++r;
        l = r;
        int s;
        while (r <= N && s < ys[i]) s += xs[r++];
        if (s != ys[i]) {
            writeln(-1);
            return;
        }
        c += max(i - l, 0) + max(r - i - 1, 0);
    }
    writeln(c);
}

/*

4 9
1 2 3 4
6 7 8 9

4 9
1 3 4 6
1 2 5 6

*/