import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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
    int A, B, C; get(A, B, C);
    int N; get(N);
    auto res = new int[](A+B+C+1);
    res[] = 2;
    int[] as, bs, cs;
    foreach (_; 0..N) {
        int a, b, c, r; get(a, b, c, r);
        if (r == 0) {
            as ~= a;
            bs ~= b;
            cs ~= c;
        } else {
            res[a] = 1;
            res[b] = 1;
            res[c] = 1;
        }
    }
    foreach (i; 0..as.length) {
        auto a = as[i];
        auto b = bs[i];
        auto c = cs[i];
        if (res[a] == 1 && res[b] == 1) {
            res[c] = 0;
        } else if (res[a] == 1 && res[c] == 1) {
            res[b] = 0;
        } else if (res[b] == 1 && res[c] == 1) {
            res[a] = 0;
        }
    }
    foreach (r; res[1..$]) writeln(r);
}