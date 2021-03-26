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

alias P = Tuple!(int, "i", long, "v");

void main()
{
    int N; get(N);
    long[] vs; get(vs);
    auto ps = 0.iota(N).map!(i => P(i, vs[i])).array();
    sort!"a.v > b.v"(ps);

    long res;
    auto rbt = redBlackTree(-1, N);
    foreach (p; ps) with (p) {
        auto ls = rbt.lowerBound(i);
        auto l1 = ls.back;
        auto rs = rbt.upperBound(i);
        auto r1 = rs.front;

        ls = rbt.lowerBound(l1);
        if (!ls.empty) {
            auto l2 = ls.back;
            res += (l1 - l2) * (r1 - i) * v;
        }
        rs = rbt.upperBound(r1);
        if(!rs.empty) {
            auto r2 = rs.front;
            res += (i - l1) * (r2 - r1) * v;
        }
        rbt.insert(i);
    }
    writeln(res);
}
