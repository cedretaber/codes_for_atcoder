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

alias P = Tuple!(int, "a", int, "b", long, "c");

void main()
{
    int N, M; get(N, M);
    P[] ps;
    foreach (_; 0..M) {
        int A, B; long C; get(A, B, C);
        ps ~= P(A - 1, B - 1, C);
    }

    auto memo = new long[](N);
    memo[] = long.min / 3;
    memo[0] = 0;

    foreach (_; 0..N) foreach (p; ps) if (memo[p.b] < memo[p.a] + p.c) memo[p.b] = memo[p.a] + p.c;
    auto r = memo[N - 1];
    foreach (_; 0..N) foreach (p; ps) if (memo[p.b] < memo[p.a] + p.c) memo[p.b] = memo[p.a] + p.c;

    if (memo[N - 1] > r) {
        writeln("inf");
    } else {
        writeln(r);
    }
}
