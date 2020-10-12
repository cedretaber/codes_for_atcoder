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
    auto S = new long[][N];
    foreach (_; 0..N) {
        int t, d; get(t, d);
        S[t-1] ~= d;
    }
    long[] ts, ds;
    ts.reserve(N);
    ds.reserve(N);
    foreach (ss; S) if (!ss.empty) {
        sort!"a > b"(ss);
        ts ~= ss[0];
        ds ~= ss[1..$];
    }
    sort!"a > b"(ts);
    foreach (i; 1..ts.length) ts[i] += ts[i-1];
    sort!"a > b"(ds);
    foreach (i; 1..ds.length) ds[i] += ds[i-1];
    ds = [0L] ~ ds;
    long r;
    foreach (k; 0..ts.length) {
        if (k >= K) break;
        r = max(r, (k+1)^^2 + ts[k] + ds[min($-1, K-k-1)]);
    }
    writeln(r);
}