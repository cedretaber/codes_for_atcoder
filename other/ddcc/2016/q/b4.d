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
    int[] AS; get(AS);

    auto II = new int[][10^^5 + 1];
    foreach (i, a; AS) II[a] ~= i.to!int;

    int i = -1, res = 1;
    foreach (ii; II) if (!ii.empty) {
        if (i < ii[0]) {
            i = ii[$-1];
        } else if (i > ii[$-1]) {
            ++res;
            i = ii[$-1];
        } else {
            ++res;
            int l, r = ii.length.to!int - 1;
            while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (ii[m] < i) {
                    l = m;
                } else {
                    r = m;
                }
            }
            i = ii[l];
        }
    }
    if (res > 1 && i == 0) --res;
    writeln(res);
}
