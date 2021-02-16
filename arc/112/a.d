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
    int T; get(T);
    while (T--) {
        long L, R; get(L, R);
        if (R < L*2) {
            writeln(0);
            continue;
        }
        auto n = R - 2 * L + 1;
        writeln(n * (n + 1) / 2);
    }
}

/*

L .. R

A - B = C

B = L の時、 A は L + L ... R => R - (L + L) + 1 => R - 2L + 1
B = L+1 の時、 A は L+1 + L ... R => R - (L+1 + L) + 1 => R - 2L
B = L+2 の時、 A は L+2 + L ... R => R - (L+2 + L) + 1 => R - 2L - 1
:
B = L+n の時、 A は L+n + L ... R ただし、 L+n + L = R <=> n = R - 2L => R - R + 1 = 1

*/