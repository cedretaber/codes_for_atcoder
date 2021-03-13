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

alias P = Tuple!(int, "w", int, "v");
alias B = Tuple!(int, "i", int, "x");

void main()
{
    int N, M, Q; get(N, M, Q);
    P[] PS; get_lines(N, PS);
    sort!"a.v > b.v"(PS);
    int[] XS; get(XS);
    B[] bs;
    foreach (i, x; XS) bs ~= B(i.to!int + 1, x);
    sort!"a.x < b.x"(bs);

    auto fs = new bool[](M);
    while (Q--) {
        int L, R; get(L, R);
        fs[] = false;
        int s;
        foreach (p; PS) {
            foreach (b; bs) if ((b.i < L || b.i > R) && b.x >= p.w && !fs[b.i - 1]) {
                s += p.v;
                fs[b.i - 1] = true;
                break;
            }
        }
        writeln(s);
    }
}
