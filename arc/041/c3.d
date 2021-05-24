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
    int N; long L; get(N, L);
    
    alias R = Tuple!(char, "d", long[], "xs");
    R[] rs;
    R r;
    char last = 'x';
    while (N--) {
        long x; char[] ds; get(x, ds);
        auto d = ds[0];
        if (d == last) {
            r.d = d;
            r.xs ~= x;
        } else {
            if (last != 'x') rs ~= r;
            r = R(d, [x]);
            last = d;
        }
    }
    rs ~= r;

    long res;
    if (rs.front.d == 'L') {
        long p = 1;
        foreach (x; rs.front.xs) {
            res += x - p;
            ++p;
        }
        rs.popFront();
    }
    while (rs.length >= 2) {
        res += max(rs[0].xs.length, rs[1].xs.length) * (rs[1].xs[0] - rs[0].xs[$ - 1] - 1);
        long p = rs.front.xs[$ - 1];
        foreach_reverse (x; rs.front.xs) {
            res += p - x;
            --p;
        }
        rs.popFront();
        p = rs.front.xs[0];
        foreach (x; rs.front.xs) {
            res += x - p;
            ++p;
        }
        rs.popFront();
    }
    if (!rs.empty) {
        long p = L;
        foreach_reverse (x; rs.front.xs) {
            res += p - x;
            --p;
        }
    }
    writeln(res);
}
