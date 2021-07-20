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
    int K, N; get(K, N);
    char[][] vs, ws; get_lines(N, vs, ws);

    auto ks = new int[](K);
    foreach (kx; 0..3^^K) {
        foreach (i; 0..K) {
            ks[i] = kx % 3 + 1;
            kx /= 3;
        }
        auto memo = new char[][K];
        foreach (i; 0..N) {
            auto v = vs[i];
            auto w = ws[i];
            foreach (n; v) {
                auto x = n - '1';
                auto l = ks[x];
                if (w.length < l) goto ng;
                if (memo[x].empty) {
                    memo[x] = w[0..l];
                } else if (w[0..l] != memo[x]) {
                    goto ng;
                }
                w = w[l..$];
            }
            if (!w.empty) goto ng;
        }
        foreach (i; 0..K) writeln(memo[i]);
        return;
        ng:
    }
}
