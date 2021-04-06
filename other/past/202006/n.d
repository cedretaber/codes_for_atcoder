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
    auto aa = 1.iota(N + 1).array();
    auto rbt = redBlackTree(-1);
    void swap_aa(int x) {
        swap(aa[x], aa[x + 1]);
        if (x > 0) {
            if (aa[x - 1] < aa[x]) {
                rbt.removeKey(x);
            } else {
                rbt.insert(x);
            }
        }
        if (aa[x] < aa[x + 1]) {
            rbt.removeKey(x + 1);
        } else {
            rbt.insert(x + 1);
        }
        if (x + 2 < N) {
            if (aa[x + 1] < aa[x + 2]) {
                rbt.removeKey(x + 2);
            } else {
                rbt.insert(x + 2);
            }
        }
    }
    while (Q--) {
        int t, x, y; get(t, x, y); --x;
        if (t == 1) {
            swap_aa(x);
        } else for (;;) {
            auto r = rbt.lowerBound(y);
            if (r.back <= x) break;
            swap_aa(r.back - 1);
        }
    }
    writefln!"%(%d %)"(aa);
}
