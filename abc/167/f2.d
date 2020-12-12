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

alias S = Tuple!(int, "d", int, "min_d");

void main()
{
    int N; get(N);
    S[] ls, rs;
    foreach (_; 0..N) {
        int d, min_d;
        char[] s; get(s);
        foreach (c; s) {
            if (c == '(') {
                ++d;
            } else {
                --d;
            }
            min_d = min(min_d, d);
        }
        if (d >= 0) {
            ls ~= S(d, min_d);
        } else {
            rs ~= S(d, min_d);
        }
    }
    sort!"a.min_d > b.min_d"(ls);
    sort!"a.d == a.min_d ? false : b.d == b.min_d ? true : a.min_d < b.min_d"(rs);
    int d;
    foreach (s; ls.chain(rs)) {
        if (d + s.min_d < 0) return writeln("No");
        d += s.d;
    }
    writeln(d == 0 ? "Yes" : "No");
}