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
    int N, K; get(N, K);
    alias S = Tuple!(int, "t", long, "d");
    S[] SS; get_lines(N, SS);
    sort!"a.d > b.d"(SS);

    long n, x;
    auto cs = new int[](N + 1);
    foreach (s; SS[0..K]) with (s) {
        n += d;
        if (cs[t] == 0) ++x;
        ++cs[t];
    }
    auto r = n + x ^^ 2;
    int i = K - 1;
    foreach (s; SS[K..$]) with (s) if (cs[t] == 0) {
        while (i >= 0 && cs[SS[i].t] == 1) --i;
        if (i < 0) break;
        n -= SS[i].d - d;
        --cs[SS[i].t];
        ++cs[t];
        ++x;
        --i;
        r = max(r, n + x ^^ 2);
    }
    writeln(r);
}
