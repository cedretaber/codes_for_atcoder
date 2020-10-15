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
    string T; get(T);
    bool[string] ss;
    foreach (_; 0..N) {
        string s; get(s);
        ss[s] = true;
    }

    auto M = T.length.to!int;
    auto G = new int[][M];
    foreach (i; 0..M) {
        foreach (j; 2..21) {
            if (i+j > M) break;
            if (T[i..i+j] in ss) G[i] ~= i+j-1;
        }
    }
    alias S = Tuple!(int, "i", int, "c");
    auto Q = heapify!"a.c > b.c"([S(0, 0)]);
    auto DP = new int[](M);
    DP[] = int.max;
    DP[0] = 0;
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.popFront();
        if (i && DP[i-1] > c) {
            DP[i-1] = c;
            Q.insert(S(i-1, c));
        }
        foreach (j; G[i]) if (DP[j] > c+1) {
            DP[j] = c+1;
            Q.insert(S(j, c+1));
        }
    }
    writeln(DP[M-1]);
}