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
    alias P = Tuple!(long, "x", long, "y");
    P[] ps; get_lines(N, ps);
    sort(ps);

    long l, r = 10L ^^ 9;
    while (l + 1 < r) {
        auto m = (l + r) / 2;
        P[] Q;
        long min_y = 10L ^^ 9, max_y;
        foreach (p; ps) {
            Q ~= p;
            while (p.x - Q.front.x >= m) {
                min_y = min(min_y, Q.front.y);
                max_y = max(max_y, Q.front.y);
                Q.popFront();
            }
            if (m <= p.y - min_y || m <= max_y - p.y) goto ok;
        }
        r = m;
        continue;
        ok:
        l = m;
    }
    writeln(l);
}
