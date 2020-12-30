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
    int N, Q; get(N, Q);
    long[] hs; get(hs);
    int[long] ds;
    foreach (i; 1..N) {
        if (i % 2 == 1) {
            ++ds[hs[i-1] - hs[i]];
        } else {
            ++ds[hs[i] - hs[i-1]];
        }
    }
    long b;
    while (Q--) {
        string q; get(q);
        if (q[0] == '1') {
            auto v = q.split[1].to!long;
            b -= v;
        } else if (q[0] == '2') {
            auto v = q.split[1].to!long;
            b += v;
        } else {
            auto uv = q.split[1..$];
            auto u = uv[0].to!int - 1;
            auto v = uv[1].to!long;
            if (u != 0) {
                if (u % 2 == 0) {
                    --ds[hs[u] - hs[u-1]];
                } else {
                    --ds[hs[u-1] - hs[u]];
                }
            }
            if (u != N-1) {
                if (u % 2 == 0) {
                    --ds[hs[u] - hs[u+1]];
                } else {
                    --ds[hs[u+1] - hs[u]];
                }
            }
            hs[u] += v;
            if (u != 0) {
                if (u % 2 == 0) {
                    ++ds[hs[u] - hs[u-1]];
                } else {
                    ++ds[hs[u-1] - hs[u]];
                }
            }
            if (u != N-1) {
                if (u % 2 == 0) {
                    ++ds[hs[u] - hs[u+1]];
                } else {
                    ++ds[hs[u+1] - hs[u]];
                }
            }
        }

        writeln(b in ds ? ds[b] : 0);
    }
}