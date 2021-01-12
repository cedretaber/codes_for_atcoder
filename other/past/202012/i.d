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

alias C = Tuple!(int, "i", int, "c");

void main()
{
    int N, M, K; get(N, M, K);
    int[] hs; get(hs);
    auto cs = readln.split.map!(c => C(c.to!int - 1, 0)).array;
    auto G = new int[][N];
    while (M--) {
        int A, B; get(A, B); --A; --B;
        if (hs[A] < hs[B]) {
            G[A] ~= B;
        } else {
            G[B] ~= A;
        }
    }

    auto DP = new int[](N);
    DP[] = int.max / 3;
    foreach (c; cs) DP[c.i] = 0;
    while (!cs.empty) {
        auto i = cs.front.i;
        auto c = cs.front.c;
        cs.popFront();
        if (DP[i] != c) continue;
        foreach (j; G[i]) if (DP[j] > c + 1) {
            DP[j] = c + 1;
            cs ~= C(j, c + 1);
        }
    }
    writefln!"%(%d\n%)"(DP.map!(c => c == int.max / 3 ? -1 : c));
}