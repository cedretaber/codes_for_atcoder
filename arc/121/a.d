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
    alias P = Tuple!(int, "i", int, "x", int, "y");
    P[] ps;
    foreach (i; 0..N) {
        int X, Y; get(X, Y);
        ps ~= P(i, X, Y);
    }
    alias D = Tuple!(int, "a", int, "b", int, "d");
    D[] ds;
    sort!"a.x < b.x"(ps);
    ds ~= D(ps[0].i, ps[$ - 1].i, ps[$ - 1].x - ps[0].x);
    ds ~= D(ps[1].i, ps[$ - 1].i, ps[$ - 1].x - ps[1].x);
    ds ~= D(ps[0].i, ps[$ - 2].i, ps[$ - 2].x - ps[0].x);
    sort!"a.y < b.y"(ps);
    ds ~= D(ps[0].i, ps[$ - 1].i, ps[$ - 1].y - ps[0].y);
    ds ~= D(ps[1].i, ps[$ - 1].i, ps[$ - 1].y - ps[1].y);
    ds ~= D(ps[0].i, ps[$ - 2].i, ps[$ - 2].y - ps[0].y);
    sort!"a.d > b.d"(ds);
    foreach (d; ds) {
        if (d.a == ds[0].a && d.b == ds[0].b) continue;
        if (d.a == ds[0].b && d.b == ds[0].a) continue;
        return writeln(d.d);
    }
}
