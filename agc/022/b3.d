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
    int N; get(N);
    if (N == 3) return writeln("2 5 63");
    if (N == 4) return writeln("2 5 20 63");
    if (N == 5) return writeln("2 4 6 3 9");

    int[] ns, ss;
    int i = 1;
    while (ns.length + ss.length < N) {
        if (i % 2 == 0) {
            ns ~= i;
        } else if (i % 3 == 0) {
            ss ~= i;
        }
        ++i;
    }
    if (ss.length % 2 == 1) {
        ss = ss[0..$ - 1];
        if (i % 2 == 1) ++i;
        ns ~= i;
        ++i;
    }
    if (ns[$ - 1] % 3 == 2) {
        ns = ns[0..$ - 1];
        while (i % 6 != 0) ++i;
        ns ~= i;
    }
    writefln!"%(%d %)"(ns.chain(ss));
}

/*

2, 1, 0, 2, 1, 0, ..., 0


*/
