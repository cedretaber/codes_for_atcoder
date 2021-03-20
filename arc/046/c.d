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

alias P = Tuple!(int, "a", int, "b");

void main()
{
    int N, M; get(N, M);
    P[] XS, YS; get_lines(N, XS); get_lines(M, YS);
    sort!"a.a == b.a ? a.b > b.b : a.a < b.a"(XS);
    sort!"a.b < b.b"(YS);

    auto rbt = redBlackTree!("a < b", true)(-1);
    int res;
    foreach (x; XS) {
        while (!YS.empty && YS.front.b <= x.a) {
            rbt.insert(YS.front.a);
            YS.popFront();
        }
        auto r = rbt.upperBound(x.b - 1);
        if (!r.empty) {
            ++res;
            rbt.removeKey(r.front);
        }
    }
    writeln(res);
}
