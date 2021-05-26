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
    int N, T; get(N, T);
    int[] PS; get(PS);

    alias P = Tuple!(int, "i", int, "s", int, "t");
    P[] ps;
    foreach (i; 0..N) {
        int[] SS; get(SS);
        foreach (s; SS) ps ~= P(i, s, 0);
    }
    int i;
    foreach (j; 0..N) {
        int[] TT; get(TT);
        foreach (t; TT) ps[i++].t = t;
    }
    sort!"a.s < b.s"(ps);
    auto rs = new int[](N);
    foreach (p; ps) {
        if (T < p.t) break;
        rs[p.i] = p.s;
        T -= p.t;
    }
    writeln(rs.sum());
}
