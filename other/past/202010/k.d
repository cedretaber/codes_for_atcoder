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

enum P = 10L^^9;

void main()
{
    int K; get(K);
    auto bs = new long[](K);
    auto ns = new long[][](K, 20);

    foreach (i; 0..K) {
        int n; get(n);
        long[20] aa;
        long b;
        foreach_reverse (a; readln.split.to!(int[])) {
            --a;
            foreach (x; 0..a) (b += aa[x]) %= P;
            ++aa[a];
        }
        bs[i] = b;
        ns[i] = aa[].dup;
    }

    int Q; get(Q);
    long res;
    long[20] aa;
    foreach_reverse (b; readln.split.to!(int[])) {
        --b;
        (res += bs[b]) %= P;
        foreach (i, x; ns[b]) foreach (j; 0..i) (res += aa[j] * x % P) %= P;
        foreach (i; 0..20) (aa[i] += ns[b][i]) %= P;
    }
    writeln(res);
}