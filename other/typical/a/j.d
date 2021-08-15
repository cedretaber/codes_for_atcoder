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
    int N, Q; get(N, Q);
    alias P = Tuple!(long, "x", long, "y");
    long max_x = long.min, min_x = long.max, max_y = long.min, min_y = long.max;
    P[] ps;
    while (N--) {
        int x, y; get(x, y);
        auto p = P(x - y, x + y);
        ps ~= p;
        max_x = max(max_x, p.x);
        min_x = min(min_x, p.x);
        max_y = max(max_y, p.y);
        min_y = min(min_y, p.y);
    }
    while (Q--) {
        int q; get(q); --q;
        auto p = ps[q];
        writeln(max(abs(max_x - p.x), abs(min_x - p.x), abs(max_y - p.y), abs(min_y - p.y)));
    }
}
