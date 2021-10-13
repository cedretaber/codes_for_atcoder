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
    int N, M; get(N, M); N *= 2;
    auto hs = new char[][N]; get_lines(N, hs);

    alias P = Tuple!(int, "i", int, "w");
    P[] ps;
    foreach (i; 0..N) ps ~= P(i, 0);

    foreach (j; 0..M) {
        for (int i; i < N; i += 2) {
            auto a = hs[ps[i].i][j];
            auto b = hs[ps[i + 1].i][j];
            if (
                (a == 'G' && b == 'C') ||
                (a == 'C' && b == 'P') ||
                (a == 'P' && b == 'G')
            ) {
                ps[i].w += 1;
            } else if (a != b) {
                ps[i + 1].w += 1;
            }
        }

        sort!"a.w == b.w ? a.i < b.i : a.w > b.w"(ps);
    }

    int[] rs;
    foreach (p; ps) rs ~= p.i + 1;
    writefln!"%(%d\n%)"(rs);
}
