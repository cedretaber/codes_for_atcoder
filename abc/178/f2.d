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
    int[] AS, BS; get(AS); get(BS);

    if (N == 1) {
        if (AS[0] == BS[0]) {
            writeln("No");
        } else {
            writeln("Yes");
            writeln(BS[0]);
        }
        return;
    }

    int i, j = N - 1;
    while (i < j) {
        while (i < N && AS[i] != BS[i]) ++i;
        while (j >= 0 && AS[j] != BS[j]) --j;
        if (i >= N || j < 0 || BS[i] == BS[j]) break;
        swap(BS[i], BS[j]);
        ++i; --j;
    }

    if (i <= j) {
        int l, r = N - 1;
        foreach (k; i..j + 1) {
            if (l < i) {
                while (l < i && (AS[l] == BS[k] || BS[l] == AS[k])) ++l;
                if (l < i) {
                    swap(BS[l], BS[k]);
                    ++l;
                    continue;
                }
            }
            if (r > j) {
                while (r > j && (AS[r] == BS[k] || BS[r] == AS[k])) --r;
                if (r > j) {
                    swap(BS[k], BS[r]);
                    --r;
                    continue;
                }
            }
            return writeln("No");
        }
    }

    writefln!"Yes\n%(%d %)"(BS);
}
