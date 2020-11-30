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
    int N, K; get(N, K);
    long[] AS, BS; get(AS); get(BS);
    sort(BS);

    long l, r = 10L^^18 + 1;
    while (l+1 < r) {
        auto m = (l+r)/2;
        long k;
        foreach (a; AS) {
            if (a * BS[0] > m) {
                continue;
            } else if (a * BS[$-1] <= m) {
                k += N;
            } else {
                int ll, rr = N;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (a * BS[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += rr;
            }
        }
        if (k >= K) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}