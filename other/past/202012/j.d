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
    char[] S; get(S);
    while (S[0] < 'a') S.popFront();
    long[] ps;
    long p;
    foreach (c; S) {
        if (c < 'a') p = p * (c - '0' + 1).to!long - 1;
        ps ~= p++;
        if (p > 10L^^16) break;
    }
    long X; get(X); --X;
    for (;;) {
        if (X == 0) return writeln(S[0]);
        int l, r = ps.length.to!int - 1;
        while (l+1 < r) {
            auto m = (l+r) / 2;
            if (ps[m] >= X) {
                r = m;
            } else {
                l = m;
            }
        }
        if (S[r] < 'a') {
            X %= ps[l] + 1;
        } else {
            return writeln(S[r]);
        }
    }
}