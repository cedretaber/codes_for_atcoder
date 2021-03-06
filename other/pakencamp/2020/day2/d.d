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
    auto A = new int[][N];
    auto B = new int[][N];
    auto AA = new int[](10^^5 * 5 + 1);
    auto BB = new int[](10^^5 * 5 + 1);
    auto AL = new int[][10^^5 * 5 + 1];

    foreach (i; 0..N) {
        int a; get(a);
        AA[i] = a;
        get(A[i]);
        foreach (j; A[i]) AL[j] ~= i;

        get(a);
        get(B[i]);
        foreach (j; B[i]) ++BB[j];
    }

    int[] ss;
    foreach (i; 1..10^^5 * 5 + 1) if (BB[i] == 0) foreach (a; AL[i]) if (--AA[a] == 0) ss ~= a;

    int[] res;
    while (!ss.empty) {
        auto n = ss.front;
        ss.popFront();
        res ~= n;
        foreach (b; B[n]) if (--BB[b] == 0) foreach (a; AL[b]) if (--AA[a] == 0) ss ~= a;
    }

    if (res.length != N) return writeln(-1);
    writefln!"%(%d %)"(res.map!"a + 1");
}
