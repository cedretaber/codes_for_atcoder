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

alias R = Tuple!(long, "l", long, "r");

void main()
{
    int N; get(N);
    auto T = redBlackTree!("a.l < b.l", false)(R(-1, -1), R(long.max, long.max));
    while (N--) {
        long S, C; get(S, C);
        auto ub = T.upperBound(R(S-1, 0));
        R r;
        if (ub.front.l == S) {
            r = ub.front;
            ub.popFront();
            T.removeKey(r);
            r.r += C;
        } else {
            auto lb = T.lowerBound(R(S, 0));
            if (lb.back.r >= S) {
                r = lb.back;
                r.r += C;
                T.removeKey(lb.back);
            } else {
                r = R(S, S+C-1);
            }
        }
        while (r.r >= ub.front.l) {
            auto t = ub.front;
            ub.popFront();
            T.removeKey(t);
            r.r = t.r + r.r - t.l + 1;
        }
        writeln(r.r);
        T.insert(r);
    }
}