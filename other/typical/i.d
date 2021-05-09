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

alias P = Tuple!(int, "i", double, "x", double, "y");

double get_angle(double x, double y)
{
    auto r = abs(x - y);
    if (r >= 180) return 360 - r;
    return r;
}

void main()
{
    int N; get(N);
    P[] ps;
    foreach (i; 0..N) {
        double x, y; get(x, y);
        ps ~= P(i, x, y);
    }
    double res = 0;
    foreach (p; ps) with (p) {
        double[] pp;
        foreach (q; ps) if (q.i != i) pp ~= atan2(q.y - y, q.x - x) * 180 / PI;
        sort(pp);
        foreach (q; pp) {
            auto t = (q + 180) % 360;
            int l, r = N - 2;
            if (pp[0] < t && t < pp[$ - 1]) while (l + 1 < r) {
                auto m = (l + r) / 2;
                if (pp[m] < t) {
                    l = m;
                } else {
                    r = m;
                }
            }
            res = max(res, get_angle(q, pp[l]), get_angle(q, pp[r]));
        }
    }
    writefln!"%.12f"(res);
}
