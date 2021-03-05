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
    int Q; get(Q);
    while (Q--) {
        long A, B; get(A, B);
        if (A > B) swap(A, B);
        if (A == B) {
            writeln(A + B - 2);
            continue;
        }
        long l, r = 10^^9;
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            if (m^^2 < A * B) {
                l = m;
            } else {
                r = m;
            }
        }
        if ((l + 1) * l < A * B) {
            writeln(l * 2 - 1);
        } else {
            writeln(l * 2 - 2);
        }
    }
}


/*

1 3
3 1

1 2 3 4 5
9 5 3 2 1

1 2 3 4 5 6 7
7 6 5 4 3 2 1

2/7

1 2 3 4 5
5 4 3 2 1

1 (2) 3 4 5 6 7
8   6 5 4 3 2 1


*/
