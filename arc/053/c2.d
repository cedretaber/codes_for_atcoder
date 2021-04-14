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

alias M = Tuple!(long, "a", long, "b");

void main()
{
    int N; get(N);
    M[] ls, xs, rs; ls.reserve(N); xs.reserve(N); rs.reserve(N);
    foreach (_; 0..N) {
        long A, B; get(A, B);
        auto m = M(A, B);
        if (A < B) {
            ls ~= m;
        } else if (A > B) {
            rs ~= m;
        } else {
            xs ~= m;
        }
    }
    sort!"a.a < b.a"(ls);
    sort!"a.b > b.b"(rs);
    long t, max_t;
    foreach (m; chain(ls, xs, rs)) {
        max_t = max(max_t, t += m.a);
        t -= m.b;
    }
    writeln(max_t);
}
