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
    auto hss = new int[][10^^5+1];
    foreach (_; 0..N) {
        int w, h; get(w, h);
        hss[w] ~= h;
    }
    int[] ns;
    foreach (hs; hss) {
        sort!"a > b"(hs);
        ns ~= hs;
    }

    int[] xs;
    foreach (h; ns) {
        if (xs.empty || xs[$-1] < h) {
            xs ~= h;
        } else if (xs[0] >= h) {
            xs[0] = h;
        } else {
            int l, r = xs.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (xs[m] < h) {
                    l = m;
                } else {
                    r = m;
                }
            }
            xs[r] = h;
        }
    }
    writeln(xs.length);
}